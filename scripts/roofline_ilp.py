"""
DRAM roofline plot (flops/cycle vs operational intensity) in Pueschel style.

Data comes straight from the Intel Advisor roofline HTML exports under
cpp_refocus/roofline_reports/ (one file per <target>x<dataset>). For each report
we read the *DRAM* memory level (NOT CARM): the DRAM data transferred and the
FLOPs the kernel performed.

Advisor's FLOP count omits int->float conversions, which are a large part of this
workload (every uint8 pixel sampled is converted) and execute on the same ports
as FP add/mul/fma. We therefore *adjust* the FLOP count upward by the number of
conversions before computing both axes:

    operational intensity = adjusted_flops / DRAM_bytes      [flops / byte]
    performance           = adjusted_flops / cycles          [flops / cycle]

The adjustment is size-independent: per shift the inner loop does
`flops_per_shift` FP ops (counted by Advisor) plus `conv_per_shift` conversions
(NOT counted), so

    adjusted_flops = advisor_flops * (flops_per_shift + conv_per_shift)
                                     / flops_per_shift

(see cpp_refocus/src/opt7_5_flop_counted.cpp for the per-op accounting).

Each optimization (target) is drawn with its own marker (color + shape); the
several image sizes of a target share that marker. The only roof drawn is the
DRAM memory-bandwidth roof, read from the reports themselves.

Run:  python3 scripts/roofline_ilp.py
"""

import re
import sys
from pathlib import Path

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
from matplotlib.lines import Line2D
from matplotlib.patches import Patch

SCRIPT_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPT_DIR))
from extract_roofline_data import extract_payload, lin  # noqa: E402

# ---------------------------------------------------------------------------
# CONFIG  — edit this block for your plot
# ---------------------------------------------------------------------------

# Directory of Advisor roofline HTML exports (roofline_<target>_<dataset>.html).
REPORTS_DIR = SCRIPT_DIR.parent / "cpp_refocus" / "roofline_reports"

# CPU clock used to convert seconds -> cycles. Read from the reports when
# present (i5-1135G7 @ 2.40 GHz); this is the fallback.
DEFAULT_FREQ_GHZ = 2.40

# Memory-bandwidth roof slope [bytes / cycle], from the STREAM benchmark.
# (We use the measured STREAM bandwidth, not the Advisor DRAM-roof estimate.)
MEM_BW_BYTES_PER_CYCLE = 7.84

# Per-target model. One entry per optimization:
#   label           legend text
#   marker          the marker SHAPE for this code version (color encodes size)
#   flops_per_shift FP add/mul ops per shift that Advisor counts
#   conv_per_shift  int->float conversions per shift (Advisor does NOT count)
# All rep* kernels are hand-vectorized AVX2: the inner loop accumulates the
# bilinear stencil with vector FMAs, so per output pixel (3 channels) Advisor
# counts 24 flops (12 FMAs = 12 mul + 12 add). conv_per_shift is the number of
# int->float converts (_mm256_cvtepi32_ps) per pixel, which Advisor omits:
#   - 12 for the no-reuse kernels (rep2/rep3/rep5 load all 4 corners per pixel)
#   - 6 for the conversion-reuse kernel (rep6 reuses each converted row register
#     across two output rows, so in steady state only 2 of the 4 corners per
#     output element are newly converted).
# See cpp_refocus/Makefile for the target -> source mapping (e.g. rep6 ->
# opt17_abl_tile_8x2032_ilp_reuse) and opt7_5_flop_counted.cpp for the scalar
# per-op accounting the AVX kernels mirror.
TARGET_MODELS = {
    "rep2": {"label": "Hand vectorized",         "marker": "o", "flops_per_shift": 24, "conv_per_shift": 12},
    "rep3":    {"label": "8x256 small tile",           "marker": "s", "flops_per_shift": 24, "conv_per_shift": 12},
    "rep5":  {"label": "8xfull_row large tile",           "marker": "D", "flops_per_shift": 24, "conv_per_shift": 12},
    "rep6":    {"label": "Load and conv reuse",           "marker": "^", "flops_per_shift": 24, "conv_per_shift": 6},
    "stack_opt10":    {"label": "Focal stack (incl. load-conv-reuse)",           "marker": "^", "flops_per_shift": 24, "conv_per_shift": 6},
}

# Color per image size [px]. Cool -> warm follows increasing size.
SIZE_COLORS = {
    256:  "#4C72B0",
    512:  "#55A868",
    1024: "#DD8452",
    2048: "#C44E52",
}

# Only plot these image sizes (px). None = all sizes found.
SIZES = [256, 512, 1024, 2048]

# Horizontal compute-peak ceilings [flops / cycle]. AVX2 single precision:
# 2 FMA ports x 8 lanes x 2 flops = 32 (matches the SP Vector FMA roof in the
# reports, ~76.5 GFLOPS / 2.40 GHz). The instruction-mix ceilings are the
# scalar 3.0 / 3.33 ceilings scaled by the 8-wide SIMD: 24 without conversion
# reuse, 26.67 with it (FMA+convert ports retire (24 + 6) adjusted flops per
# 9 cycles -> 3.33/cycle x 8).
PEAK_DEFS = [
    ("avx_fma_peak",        "AVX Peak",                    32.0),
    ("avx_instr_mix",       "AVX instr. mix",               24.0),
    ("avx_instr_mix_reuse", "AVX instr. mix, conv. reuse", 26.67),
]

# Plot decoration
TITLE       = "DRAM Roofline on Intel Tiger Lake"
SUBTITLE    = "(vectorized code)"
FLAGS       = "-march=native -ffast-math"
Y_AXIS_DESC = "[flops / cycle]"
X_LABEL     = "operational intensity  [flops / byte]"
OUTPUT_PATH = SCRIPT_DIR / "roofline_ilp_avx.pdf"

# Axis scales: "linear", "log", or "log2".
X_SCALE = "log2"
Y_SCALE = "log2"

# Plot bounds (data units). None = auto-fit.
X_LIM = None
Y_LIM = None

# Font sizes (pt) and figure size, tuned so the figure stays readable when
# scaled into a single column of a two-column report. Bump FONT_SCALE to make
# everything uniformly larger.
FONT_SCALE   = 1.0
FIGSIZE      = (7.2, 5.4)
FS_TITLE     = 20
FS_FLAGS     = 12
FS_AXIS_DESC = 17
FS_XLABEL    = 18
FS_TICKS     = 16
FS_LEGEND    = 15
FS_PEAK      = 14

MARKER_SIZE  = 9.5    # data-point markers
ROOF_LW      = 2.2    # diagonal memory roof
CEIL_LW      = 1.8    # horizontal compute ceilings

# ---------------------------------------------------------------------------
# Extraction
# ---------------------------------------------------------------------------

def parse_target_dataset(stem):
    """roofline_<target>_<dataset> -> (target, dataset). Dataset is the last two
    underscore tokens (e.g. mock_2048); target is the rest."""
    if stem.startswith("roofline_"):
        stem = stem[len("roofline_"):]
    tokens = stem.split("_")
    if len(tokens) >= 3:
        return "_".join(tokens[:-2]), "_".join(tokens[-2:])
    return stem, ""


def size_from_dataset(dataset):
    m = re.search(r"(\d+)", dataset)
    return int(m.group(1)) if m else None


def freq_ghz_from_payload(payload):
    """Pull '... @ 2.40GHz' / 'Frequency: 2.40 GHz' from summaryInfo."""
    for item in payload.get("summaryInfo", {}).get("platform", []):
        if str(item.get("caption", "")).lower() == "frequency":
            m = re.search(r"([\d.]+)\s*GHz", str(item.get("value", "")))
            if m:
                return float(m.group(1))
    return DEFAULT_FREQ_GHZ


def dram_point_and_roof(rd):
    """Return (dram_ai, perf_gflops, dram_bw_gbs) from the DRAM memory level."""
    point = next((p for p in rd.get("programTotal", [])
                  if str(p.get("memoryLevelPref", "")).startswith("DRAM")), None)
    # Single-threaded roof set (threadCount == 1).
    roofs = []
    for g in rd.get("allRoofs", []):
        if g.get("threadCount") == 1:
            roofs = g.get("roofs", [])
            break
    dram_roof = next((r for r in roofs
                      if r.get("memoryLevel") == "DRAM" and r.get("isMem")), None)
    if point is None or dram_roof is None:
        return None
    return lin(point["x"]), lin(point["y"]), lin(dram_roof["val"])


def gather_points():
    """Return (points, freq_ghz, dram_bw_gbs).

    points: list of dicts with target, size, ai (adjusted), perf_cyc (adjusted).
    """
    if not REPORTS_DIR.is_dir():
        sys.exit(f"Reports directory not found: {REPORTS_DIR}")

    points = []
    freqs, bws = [], []
    print(f"Reading Advisor reports from {REPORTS_DIR}")
    for html_file in sorted(REPORTS_DIR.glob("*.html")):
        target, dataset = parse_target_dataset(html_file.stem)
        model = TARGET_MODELS.get(target)
        if model is None:
            continue
        size = size_from_dataset(dataset)
        if SIZES is not None and size not in SIZES:
            continue

        payload = extract_payload(html_file.read_text(encoding="utf-8", errors="replace"))
        rd = payload["rooflineData"]
        parsed = dram_point_and_roof(rd)
        if parsed is None:
            print(f"  [skip] {html_file.name}: no DRAM point/roof")
            continue
        dram_ai, perf_gflops, dram_bw_gbs = parsed
        freq = freq_ghz_from_payload(payload)
        freqs.append(freq)
        bws.append(dram_bw_gbs)

        # Conversion adjustment: scale both axes by (fp + conv) / fp.
        factor = ((model["flops_per_shift"] + model["conv_per_shift"])
                  / model["flops_per_shift"])
        points.append({
            "target": target,
            "size": size,
            "ai": dram_ai * factor,                  # flops / byte
            "perf_cyc": perf_gflops * factor / freq,  # flops / cycle (GFLOPS/GHz)
            "factor": factor,
        })

    if not points:
        sys.exit("No points extracted. Check REPORTS_DIR and TARGET_MODELS keys.")

    freq_ghz = float(np.median(freqs))
    dram_bw_gbs = float(np.median(bws))
    return points, freq_ghz, dram_bw_gbs


# ---------------------------------------------------------------------------
# Plot styling helpers
# ---------------------------------------------------------------------------

def style_axes(ax):
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    for side in ("left", "bottom"):
        ax.spines[side].set_linewidth(1.1)
        ax.spines[side].set_color("#333333")
    ax.set_facecolor("#E5E5E5")
    ax.yaxis.grid(True, color="white", linewidth=1.3)
    ax.xaxis.grid(True, color="white", linewidth=1.3)
    ax.set_axisbelow(True)
    ax.tick_params(axis="both", which="both", direction="out",
                   length=6, width=1.1, colors="#333333")


def apply_scale(ax, axis, scale):
    if scale == "linear":
        return
    base = {"log": 10, "log2": 2}.get(scale)
    if base is None:
        raise ValueError(f"Unknown scale: {scale!r}")
    getattr(ax, f"set_{axis}scale")("log", base=base)


# ---------------------------------------------------------------------------
# Plot
# ---------------------------------------------------------------------------

def make_plot(points, output_path):
    # Memory roof slope in bytes / cycle (STREAM benchmark).
    mem_bw_bpc = MEM_BW_BYTES_PER_CYCLE

    fig, ax = plt.subplots(figsize=FIGSIZE)
    fig.subplots_adjust(left=0.155, right=0.965, top=0.74, bottom=0.155)

    apply_scale(ax, "x", X_SCALE)
    apply_scale(ax, "y", Y_SCALE)

    # Auto-fit bounds from the data (with margin) unless overridden. Keep the
    # top just above the highest point / compute ceiling to avoid dead space.
    ais = np.array([p["ai"] for p in points])
    perfs = np.array([p["perf_cyc"] for p in points])
    top = max([perfs.max()] + [v for _, _, v in PEAK_DEFS])
    x_lim = X_LIM or (ais.min() / 2, ais.max() * 2)
    y_lim = Y_LIM or (perfs.min() / 2, top * 1.45)
    ax.set_xlim(*x_lim)
    ax.set_ylim(*y_lim)
    x_lo, x_hi = ax.get_xlim()

    # Diagonal memory-bandwidth roof: perf = BW * intensity. Labeled right
    # above the line, rotated to follow its slope (angle computed in display
    # space so it is correct regardless of the log-log aspect ratio).
    xs = np.array([x_lo, x_hi])
    ax.plot(xs, mem_bw_bpc * xs, color="#888888", linewidth=ROOF_LW * FONT_SCALE,
            linestyle="--", zorder=1)

    p0 = ax.transData.transform((x_lo, mem_bw_bpc * x_lo))
    p1 = ax.transData.transform((x_hi, mem_bw_bpc * x_hi))
    roof_angle = np.degrees(np.arctan2(p1[1] - p0[1], p1[0] - p0[0]))
    _, y_hi = ax.get_ylim()
    x_lab = min(x_hi, max(x_lo, y_hi / mem_bw_bpc)) * 0.2
    ax.text(x_lab, mem_bw_bpc * x_lab, rf"  $\beta$ = {mem_bw_bpc:g} B/cycle",
            rotation=roof_angle, rotation_mode="anchor",
            ha="left", va="bottom", fontsize=FS_PEAK * FONT_SCALE,
            color="#888888", zorder=2)

    # Horizontal compute-peak ceilings, drawn only to the right of where they
    # cross the diagonal memory roof (i.e. starting at ai = peak / mem_bw).
    for _key, peak_label, peak_value in PEAK_DEFS:
        x_start = max(x_lo, peak_value / mem_bw_bpc)
        if x_start >= x_hi:
            continue  # ceiling lies entirely above the visible memory roof
        ax.plot([x_start, x_hi], [peak_value, peak_value], color="#888888",
                linewidth=CEIL_LW * FONT_SCALE, linestyle="--", zorder=1)
        if peak_label:
            ax.text(7, peak_value, f" {peak_label}",
                    ha="left", va="bottom", fontsize=12 * FONT_SCALE,
                    color="#888888")

    # Shape encodes the code version; color encodes the image size.
    for target, model in TARGET_MODELS.items():
        for p in (q for q in points if q["target"] == target):
            ax.plot(p["ai"], p["perf_cyc"],
                    marker=model["marker"], markersize=MARKER_SIZE * FONT_SCALE,
                    linewidth=0, color=SIZE_COLORS.get(p["size"], "#888888"),
                    markeredgecolor="white", markeredgewidth=0.8, zorder=3)

    # Plain numbers on log2 axes (no 2^n exponents).
    for axis_obj in (ax.xaxis, ax.yaxis):
        axis_obj.set_major_formatter(mticker.ScalarFormatter())
        axis_obj.set_minor_formatter(mticker.NullFormatter())
    ax.tick_params(axis="both", labelsize=FS_TICKS * FONT_SCALE)
    ax.set_xlabel(X_LABEL, fontsize=FS_XLABEL * FONT_SCALE,
                  color="#333333", labelpad=6)

    left_x = 0.155
    fig.text(left_x, 0.935, TITLE, fontsize=FS_TITLE * FONT_SCALE,
             fontweight="bold", color="#222222", ha="left")
    if SUBTITLE:
        fig.text(left_x, 0.89, SUBTITLE, fontsize=FS_FLAGS * FONT_SCALE,
                 color="#000000", ha="left")
    if FLAGS:
        fig.text(left_x, 0.85, FLAGS, fontsize=FS_FLAGS * FONT_SCALE,
                 color="#555555", ha="left")
    if Y_AXIS_DESC:
        pos = ax.get_position()
        fig.text(pos.x0, pos.y1 + 0.015, Y_AXIS_DESC,
                 fontsize=FS_AXIS_DESC * FONT_SCALE, color="#333333",
                 ha="center", va="bottom")

    style_axes(ax)

    # Two legends below the plot: marker shape = code version, color = size.
    version_handles = [
        Line2D([], [], linestyle="none", marker=m["marker"],
               markersize=MARKER_SIZE * FONT_SCALE, color="#555555",
               markeredgecolor="white", markeredgewidth=0.8, label=m["label"])
        for m in TARGET_MODELS.values()
    ]
    present_sizes = sorted({p["size"] for p in points if p["size"] in SIZE_COLORS})
    size_handles = [Patch(facecolor=SIZE_COLORS[s], edgecolor="none", label=str(s))
                    for s in present_sizes]

    legend_kw = dict(frameon=False, fontsize=FS_LEGEND * FONT_SCALE,
                     labelcolor="#333333", handlelength=1.1, handletextpad=0.5,
                     labelspacing=0.5, borderaxespad=0.0,
                     title_fontsize=FS_LEGEND * FONT_SCALE)
    leg_v = ax.legend(handles=version_handles, title="code version", ncol=1,
                      loc="upper left", bbox_to_anchor=(0.0, -0.28), **legend_kw)
    leg_v._legend_box.align = "left"
    ax.add_artist(leg_v)
    leg_s = ax.legend(handles=size_handles, title="image size [px]", ncol=1,
                      loc="upper right", bbox_to_anchor=(1.0, -0.28), **legend_kw)
    leg_s._legend_box.align = "left"

    fig.savefig(output_path, dpi=200, bbox_inches="tight")
    plt.close(fig)
    print(f"\nSaved plot to {output_path}")


def main():
    points, freq_ghz, dram_bw_gbs = gather_points()
    print(f"\nFrequency: {freq_ghz:.2f} GHz   DRAM roof: {dram_bw_gbs:.2f} GB/s\n")
    print(f"{'target':10} {'size':>5} {'factor':>6} {'AI[fl/B]':>9} {'perf[fl/cyc]':>12}")
    for p in sorted(points, key=lambda p: (p["target"], p["size"] or 0)):
        print(f"{p['target']:10} {str(p['size']):>5} {p['factor']:6.3f} "
              f"{p['ai']:9.3f} {p['perf_cyc']:12.3f}")
    make_plot(points, OUTPUT_PATH)


if __name__ == "__main__":
    main()
