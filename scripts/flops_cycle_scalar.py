"""
General-purpose performance plot (flops/cycle) in Pueschel style.

Edit the CONFIG block below to choose:
  - which CSV files to plot
  - the label, color, and y-column for each
  - the x-axis column (shared across all files)
  - how flops are counted (FLOPS function)
  - axis labels, title, scales, output filename

Then run:  python3 scripts/flops_cycle_scalar.py
"""

import os
import sys

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker

# ---------------------------------------------------------------------------
# CONFIG  — edit this block for your plot
# ---------------------------------------------------------------------------

# Per-shift op counts used by the FLOPS function.
DEFAULT_OPS_PER_SHIFT = 36 * 289
REDUCED_OPS_PER_SHIFT = 30 * 289   # DP Counts and Conv. Reuse

# --- Line definitions -------------------------------------------------------
# One entry per available line. "key" is the name used in PLOT_CONFIGS below to
# toggle the line on/off per plot.
SERIES_DEFS = [
    {"key": "dp_counts",  "path": "timing_results/timing_stack_from_opt7_6_20260614_153157_bench3.csv", "label": "DP Counts", "color": "#5F4B8B", "ops_per_shift": REDUCED_OPS_PER_SHIFT},
    {"key": "conv_reuse", "path": "timing_results/timing_stack_from_opt7_fma_20260614_153157_bench2.csv", "label": "Conv. Reuse", "color": "#B66A3C", "ops_per_shift": REDUCED_OPS_PER_SHIFT},
    {"key": "ilp_unroll", "path": "timing_results/timing_stack_from_opt5_fma_20260614_153157_bench1.csv", "label": "ILP Unroll", "color": "#557A3D", "ops_per_shift": DEFAULT_OPS_PER_SHIFT},
    {"key": "inlining",   "path": "timing_results/timing_stack_from_opt5_20260531_101022_bench3.csv", "label": "Inlining", "color": "#2F6F73", "ops_per_shift": DEFAULT_OPS_PER_SHIFT},
    {"key": "loop_order", "path": "timing_results/timing_stack_from_opt4_20260531_101022_bench2.csv", "label": "Loop Order", "color": "#9B4F5A", "ops_per_shift": DEFAULT_OPS_PER_SHIFT},
    {"key": "baseline",   "path": "timing_results/timing_stack_from_basic-opt_20260531_101022_bench1.csv", "label": "Baseline", "color": "#53616E", "ops_per_shift": DEFAULT_OPS_PER_SHIFT},
]

# --- Peak definitions -------------------------------------------------------
# One entry per available peak reference line: (key, label, value). "key" is the
# name used in PLOT_CONFIGS below to toggle the peak on/off per plot.
PEAK_DEFS = [
    ("scalar_peak",                   "scalar peak (FMA, dp)",           4.0),
    ("instr_mix_conv_reuse",          "instr. mix conv. reuse",          3.33),
    ("instr_mix_conv_reuse_compiled", "instr. mix conv. reuse compiled", 2.85),
    ("instr_mix",                     "instr. mix",                      3.0),
    ("instr_mix_compiled",            "instr. mix compiled",             2.66),
]

# --- Plot configurations ----------------------------------------------------
# Each entry is one plot. Toggle each line/peak on or off per plot using the
# keys defined in SERIES_DEFS and PEAK_DEFS above. Anything omitted defaults to
# False. Plots are numbered 1..n and written to perf_scalar_<n>.png.
PLOT_CONFIGS = [
    # {
    #     "loop_order": True,
    #     "baseline": True,
    # },
    # {
    #     "loop_order": True,
    #     "baseline": True, 
    #     "inlining": True,
    # },
    # {
    #     "loop_order": True,
    #     "baseline": True, 
    #     "inlining": True,
    #     "scalar_peak": True,
    # },
    # {
    #     "loop_order": True,
    #     "baseline": True, 
    #     "inlining": True,
    #     "scalar_peak": True,
    #     "instr_mix": True,
    # },
    # {
    #     "loop_order": True,
    #     "baseline": True, 
    #     "inlining": True,
    #     "scalar_peak": True,
    #     "instr_mix": True,
    #     "instr_mix_compiled": True,
    # },
    # {
    #     "loop_order": True,
    #     "baseline": True, 
    #     "inlining": True,
    #     "scalar_peak": True,
    #     "conv_reuse": True,
    # },
    # {
    #     "loop_order": True,
    #     "baseline": True, 
    #     "inlining": True,
    #     "scalar_peak": True,
    #     "conv_reuse": True,
    #     "dp_counts": True,
    # },
    # {
    #     "loop_order": True,
    #     "baseline": True, 
    #     "inlining": True,
    #     "scalar_peak": True,
    #     "conv_reuse": True,
    #     "dp_counts": True,
    #     "instr_mix_conv_reuse": True,
    # },
    {
        "loop_order": True,
        "baseline": True, 
        "inlining": True,
        "ilp_unroll": True,
        "scalar_peak": False,
        "conv_reuse": True,
        "dp_counts": True,
        "instr_mix_conv_reuse": False,
        # "instr_mix_conv_reuse_compiled": True,
    },
]

# Shared x and cycles columns (same across all CSVs).
X_COL      = "img_w"
CYCLES_COL = "median_cycles"

# --- Flop count per measurement ---------------------------------------------
def FLOPS(df, ops_per_shift):
    return ops_per_shift * df["img_w"] * df["img_h"]
# ---------------------------------------------------------------------------

# Optional shared filter applied to every CSV.
def SHARED_FILTER(df):
    return (
        df["data_source"].str.startswith("generated")
        & (df["img_w"] == df["img_h"])
        & (df["img_w"] >= 100)  # skip very small inputs with noisy perf
    )

# Plot decoration
TITLE       = "Performance (single precision) on Intel Tiger Lake"
FLAGS       = "-march=native -ffast-math -fno-tree-vectorize"
# Y-axis descriptor, drawn centered just above the top of the y-axis spine.
Y_AXIS_DESC = "[flops / cycle]"
X_LABEL     = "input size (image width = height)  [pixels]"
OUTPUT_PATH = "perf_scalar.svg"

# Axis scales: "linear", "log", or "log2".
# Performance plots conventionally use linear y so the peak line is a flat
# ceiling and improvements are visually proportional.
X_SCALE = "log"
Y_SCALE = "linear"
X_MIN = 256
X_MAX = 4096

LEGEND_LOC = None

# X-axis tick formatting: "exact", "human_size", or "plain"
X_TICK_FORMAT = "exact"
TICK_FONTSIZE = 12

# ---------------------------------------------------------------------------
# Implementation
# ---------------------------------------------------------------------------

def human_size(n):
    n = int(n)
    if n < 1024:
        return str(n)
    if n < 1024 * 1024:
        return f"{n // 1024}k"
    return f"{n // (1024 * 1024)}M"


def style_axes(ax):
    for side in ("top", "right", "left", "bottom"):
        ax.spines[side].set_visible(False)
    ax.spines["bottom"].set_visible(True)
    ax.spines["bottom"].set_linewidth(1.8)
    ax.spines["bottom"].set_color("#222222")

    ax.set_facecolor("#E5E5E5")
    ax.yaxis.grid(True, color="white", linewidth=2.6)
    ax.xaxis.grid(False)
    ax.set_axisbelow(True)

    ax.tick_params(axis="both", which="both", direction="out",
                   length=4, width=0.8, colors="#333333")


def apply_scale(ax, axis, scale):
    if scale == "linear":
        return
    if scale == "log":
        getattr(ax, f"set_{axis}scale")("log", base=10)
        return
    if scale == "log2":
        getattr(ax, f"set_{axis}scale")("log", base=2)
        return
    raise ValueError(f"Unknown scale: {scale!r}")


def numbered_output_path(base, n):
    """perf_scalar.png -> perf_scalar_<n>.png"""
    root, ext = os.path.splitext(base)
    return f"{root}_{n}{ext}"


# ---------------------------------------------------------------------------
# Load  — read every defined CSV once into a cache keyed by series "key".
# ---------------------------------------------------------------------------
print("Loading CSV files:")
series_cache = {}
for entry in SERIES_DEFS:
    path = entry["path"]
    if not os.path.exists(path):
        print(f"  [skip] {path} not found")
        continue
    df = pd.read_csv(path)
    if SHARED_FILTER is not None:
        df = df[SHARED_FILTER(df)]
    df = df.sort_values(X_COL).reset_index(drop=True)

    missing = [c for c in (X_COL, CYCLES_COL) if c not in df.columns]
    if missing:
        print(f"  [skip] {path}: missing columns {missing}")
        continue
    if df.empty:
        print(f"  [skip] {path}: no rows after filter")
        continue

    # Compute performance = flops / cycles
    df["perf"] = FLOPS(df, entry["ops_per_shift"]) / df[CYCLES_COL]

    series_cache[entry["key"]] = {**entry, "df": df}
    print(f"  [ok]   {os.path.basename(path):<40s}  "
          f"({len(df)} rows, perf range "
          f"{df['perf'].min():.2f}–{df['perf'].max():.2f} flops/cycle)")

if not series_cache:
    sys.exit("No data to plot. Check the SERIES_DEFS paths in the CONFIG block.")


# ---------------------------------------------------------------------------
# Plot  — one figure per entry in PLOT_CONFIGS.
# ---------------------------------------------------------------------------
def make_plot(cfg, output_path):
    # Lines enabled by this config (in SERIES_DEFS order), restricted to those
    # that actually loaded.
    loaded = [series_cache[d["key"]]
              for d in SERIES_DEFS
              if cfg.get(d["key"], False) and d["key"] in series_cache]
    # Peaks enabled by this config (in PEAK_DEFS order).
    peak_lines = [(label, value)
                  for key, label, value in PEAK_DEFS if cfg.get(key, False)]

    if not loaded:
        print(f"  [skip] {output_path}: no enabled lines have data")
        return

    fig, ax = plt.subplots(figsize=(9, 6))
    fig.subplots_adjust(left=0.12, right=0.95, top=0.76, bottom=0.13)

    all_x = set()
    for entry in loaded:
        df = entry["df"]
        x = df[X_COL].to_numpy()
        y = df["perf"].to_numpy()
        all_x.update(x.tolist())

        ax.plot(x, y,
                marker="s", markersize=6.5, linewidth=2.8,
                color=entry["color"], markerfacecolor=entry["color"],
                markeredgecolor=entry["color"], label=entry["label"])

    # Peak performance reference lines
    for peak_label, peak_value in peak_lines:
        ax.axhline(peak_value, color="#888888", linewidth=1.0,
                   linestyle="--", zorder=1)
        ax.text(0.005, peak_value, f"{peak_label}  ",
                transform=ax.get_yaxis_transform(),
                ha="left", va="bottom",
                fontsize=10, color="#555555")

    apply_scale(ax, "x", X_SCALE)
    apply_scale(ax, "y", Y_SCALE)

    # X ticks
    x_ticks = sorted(all_x)
    if X_SCALE in ("log", "log2"):
        ax.set_xticks(x_ticks)
        ax.xaxis.set_minor_locator(mticker.NullLocator())
        if len(x_ticks) > 1:
            ax.set_xlim(X_MIN, X_MAX)
    if X_TICK_FORMAT == "human_size":
        ax.set_xticks(x_ticks)
        ax.set_xticklabels([human_size(v) for v in x_ticks])
    elif X_TICK_FORMAT == "exact":
        ax.set_xticks(x_ticks)
        ax.set_xticklabels([str(int(v)) for v in x_ticks])
    ax.tick_params(axis="both", labelsize=TICK_FONTSIZE)
    if X_SCALE == "linear":
        ax.set_xlim(left=0)

    # Y spans 0..4.2 for scalar performance plots.
    if Y_SCALE == "linear":
        ax.set_ylim(0, 4.2)

    # Axis labels
    ax.set_xlabel(X_LABEL, fontsize=13, color="#333333", labelpad=8)

    # Title block: title, grayed flags below it, then the y-axis descriptor
    # centered just above the top of the y-axis spine.
    fig.text(0.12, 0.87, TITLE,
             fontsize=15, fontweight="bold", color="#222222", ha="left")
    if FLAGS:
        fig.text(0.12, 0.83, FLAGS,
                 fontsize=12, fontweight="bold", color="#555555", ha="left")
    if Y_AXIS_DESC:
        pos = ax.get_position()
        fig.text(pos.x0, pos.y1 + 0.012, Y_AXIS_DESC,
                 fontsize=13, color="#333333", ha="center", va="bottom")

    style_axes(ax)

    if LEGEND_LOC is not None:
        handles, labels = ax.get_legend_handles_labels()
        ax.legend(handles, labels,
                  loc=LEGEND_LOC,
                  frameon=True, fontsize=9, labelcolor="#333333",
                  handlelength=2.2, borderaxespad=0.8,
                  facecolor="white", edgecolor="none",
                  framealpha=0.92)

    fig.savefig(output_path, dpi=160, bbox_inches="tight")
    plt.close(fig)
    print(f"\nSaved plot to {output_path}")

    # Summary
    print("Data plotted:")
    for entry in loaded:
        print(f"\n{entry['label']} ({os.path.basename(entry['path'])}):")
        cols = [X_COL, CYCLES_COL, "perf"]
        print(entry["df"][cols].to_string(index=False))


for i, cfg in enumerate(PLOT_CONFIGS, start=1):
    print(f"\n=== Plot {i} of {len(PLOT_CONFIGS)} ===")
    make_plot(cfg, numbered_output_path(OUTPUT_PATH, i))
