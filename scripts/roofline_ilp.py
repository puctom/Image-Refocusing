"""
Roofline plot (flops/cycle vs operational intensity) in Pueschel style.

Companion to flops_cycle_scalar.py — it reuses the same flops/cycle
performance calculation, but instead of plotting perf vs input size it plots
each implementation against its operational intensity [flops / byte] so the
memory-bandwidth roof and compute ceilings become visible.

Edit the CONFIG block below to choose:
  - which CSV files to plot, their label/color/op-count/operational intensity
  - the memory bandwidth (bytes/cycle) used for the diagonal memory roof
  - how each implementation is reduced to point(s) (POINT_MODE)
  - which compute-peak ceilings to draw
  - axis labels, title, scales, output filename

Then run:  python3 scripts/roofline_ilp.py
"""

import os
import sys

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker

# ---------------------------------------------------------------------------
# CONFIG  — edit this block for your plot
# ---------------------------------------------------------------------------

# Per-shift op counts used by the FLOPS function (same as flops_cycle_scalar.py).
DEFAULT_OPS_PER_SHIFT = 36 * 289
REDUCED_OPS_PER_SHIFT = 30 * 289   # opt7 / opt7_5 / opt17: conversion reuse

# Memory bandwidth used for the diagonal memory roof, in bytes / cycle.
# The diagonal roof is  perf = MEM_BW_BYTES_PER_CYCLE * operational_intensity.
MEM_BW_BYTES_PER_CYCLE = 5.7

# How to reduce each implementation (many input sizes) to roofline point(s):
#   "scatter" — one marker per input size (vertical cluster at fixed intensity)
#   "peak"    — one marker at the max flops/cycle achieved across input sizes
#   "largest" — one marker at the perf of the largest input (img_w * img_h)
POINT_MODE = "scatter"

# --- Line/point definitions -------------------------------------------------
# One entry per available implementation. "key" toggles it on/off per plot in
# PLOT_CONFIGS below. "op_intensity" is operational intensity in flops / byte:
# 10 for the conversion-reuse variants (opt7 / opt7_5 / opt17), 12 otherwise.
SERIES_DEFS = [
    {"key": "basic_opt", "path": "timing_results/timing_basic_20260602_092806.csv",  "label": "baseline", "color": "#5B6C8F", "ops_per_shift": DEFAULT_OPS_PER_SHIFT, "op_intensity": 12.0},
    {"key": "opt7_5",    "path": "timing_results/timing_opt7_5_20260601_165409.csv",  "label": "best scalar optimization",    "color": "#C49A4A", "ops_per_shift": REDUCED_OPS_PER_SHIFT, "op_intensity": 10.0},
    {"key": "opt9",      "path": "timing_results/timing_opt9_20260601_183347.csv",    "label": "baseline AVX",      "color": "#6F8F72", "ops_per_shift": DEFAULT_OPS_PER_SHIFT, "op_intensity": 12.0},
    {"key": "opt17",     "path": "timing_results/timing_opt17_20260601_184650.csv",   "label": "best AVX optimization",     "color": "#B56A5F", "ops_per_shift": REDUCED_OPS_PER_SHIFT, "op_intensity": 10.0},
]

# --- Compute-peak ceilings --------------------------------------------------
# Horizontal compute roofs, in flops / cycle. "key" toggles each on/off per
# plot in PLOT_CONFIGS. Edit these to match the relevant peak(s) for the
# vectorized / ILP implementations.
PEAK_DEFS = [
    ("vector_peak",                 "vector peak (FMA, sp)",              32.0),
    ("vector_instr_mix_conv_reuse", "vector instr. mix conv. reuse peak", 26.66),
    ("vector_instr_mix",            "vector instr. mix peak",             24.0),
    ("scalar_peak",                 "scalar peak (FMA, sp)",              4.0),
    ("scalar_instr_mix",            "scalar instr. mix peak",             3.33),
]

# Toggle the diagonal memory-bandwidth roof per plot via the "memory_roof" key.

# --- Plot configurations ----------------------------------------------------
# Each entry is one plot. Toggle each point series / compute peak / the memory
# roof on or off using the keys from SERIES_DEFS, PEAK_DEFS, and "memory_roof".
# Anything omitted defaults to False. Plots are written to roofline_ilp_<n>.png.
PLOT_CONFIGS = [
    {
        "basic_opt": True,
        "memory_roof": True,
        "scalar_peak": True,
    },
    {
        "basic_opt": True,
        "opt7_5": True,
        "memory_roof": True,
        "scalar_peak": True,
        "scalar_instr_mix": True,
    },
    {
        "basic_opt": True,
        "opt7_5": True,
        "opt9": True,
        "memory_roof": True,
        "scalar_peak": True,
        "scalar_instr_mix": True,
        "vector_peak": True,
        "vector_instr_mix": True,
    },
    {
        "basic_opt": True,
        "opt7_5": True,
        "opt9": True,
        "opt17": True,
        "memory_roof": True,
        "scalar_peak": True,
        "scalar_instr_mix": True,
        "vector_peak": True,
        "vector_instr_mix_conv_reuse": True,
    },
]

# Shared columns (same across all CSVs).
X_COL      = "img_w"   # used for input-size reduction, not the plot x-axis
CYCLES_COL = "median_cycles"

# --- Flop count per measurement (same as flops_cycle_scalar.py) -------------
def FLOPS(df, ops_per_shift):
    return ops_per_shift * df["img_w"] * df["img_h"]
# ---------------------------------------------------------------------------

# Optional shared filter applied to every CSV.
def SHARED_FILTER(df):
    return (
        df["data_source"].str.startswith("generated")
        & (df["img_w"] == df["img_h"])
        & (df["img_w"] >= 100)    # skip very small inputs with noisy perf
        & (df["img_w"] < 3072)    # skip 3072x3072 (out-of-cache outlier)
    )

# Plot decoration
TITLE       = "Roofline (single precision) on Intel Tiger Lake, 2.4 GHz"
FLAGS       = "-march=native -ffast-math"
# Y-axis descriptor, drawn centered just above the top of the y-axis spine.
Y_AXIS_DESC = "performance [flops / cycle]"
X_LABEL     = "operational intensity  [flops / byte]"
OUTPUT_PATH = "roofline_ilp.png"

# Axis scales: "linear", "log", or "log2". Rooflines conventionally use log2/log2
# so the memory roof is a straight diagonal.
X_SCALE = "log2"
Y_SCALE = "log2"

# Plot bounds (in data units). Set to None to auto-fit.
X_LIM = (0.25, 32.0)
Y_LIM = (0.125, 64.0)

LEGEND_LOC = "lower right"

# ---------------------------------------------------------------------------
# Implementation
# ---------------------------------------------------------------------------

def style_axes(ax):
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    for side in ("left", "bottom"):
        ax.spines[side].set_linewidth(0.8)
        ax.spines[side].set_color("#333333")

    ax.set_facecolor("#E5E5E5")
    ax.yaxis.grid(True, color="white", linewidth=1.0)
    ax.xaxis.grid(True, color="white", linewidth=1.0)
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
    """roofline_ilp.png -> roofline_ilp_<n>.png"""
    root, ext = os.path.splitext(base)
    return f"{root}_{n}{ext}"


def reduce_points(df):
    """Return (xs, ys) of roofline points for one series, per POINT_MODE.

    Operational intensity (x) is constant per series; only perf (y) varies."""
    if POINT_MODE == "scatter":
        return df["perf"].to_numpy()
    if POINT_MODE == "peak":
        return np.array([df["perf"].max()])
    if POINT_MODE == "largest":
        row = df.loc[(df["img_w"] * df["img_h"]).idxmax()]
        return np.array([row["perf"]])
    raise ValueError(f"Unknown POINT_MODE: {POINT_MODE!r}")


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

    # Compute performance = flops / cycles (identical to flops_cycle_scalar.py).
    df["perf"] = FLOPS(df, entry["ops_per_shift"]) / df[CYCLES_COL]

    series_cache[entry["key"]] = {**entry, "df": df}
    print(f"  [ok]   {os.path.basename(path):<40s}  "
          f"(I={entry['op_intensity']:g} flops/byte, {len(df)} rows, perf range "
          f"{df['perf'].min():.2f}–{df['perf'].max():.2f} flops/cycle)")

if not series_cache:
    sys.exit("No data to plot. Check the SERIES_DEFS paths in the CONFIG block.")


# ---------------------------------------------------------------------------
# Plot  — one figure per entry in PLOT_CONFIGS.
# ---------------------------------------------------------------------------
def make_plot(cfg, output_path):
    loaded = [series_cache[d["key"]]
              for d in SERIES_DEFS
              if cfg.get(d["key"], False) and d["key"] in series_cache]
    peak_lines = [(label, value)
                  for key, label, value in PEAK_DEFS if cfg.get(key, False)]

    if not loaded:
        print(f"  [skip] {output_path}: no enabled lines have data")
        return

    fig, ax = plt.subplots(figsize=(9, 6))
    fig.subplots_adjust(left=0.12, right=0.95, top=0.76, bottom=0.13)

    apply_scale(ax, "x", X_SCALE)
    apply_scale(ax, "y", Y_SCALE)
    if X_LIM is not None:
        ax.set_xlim(*X_LIM)
    if Y_LIM is not None:
        ax.set_ylim(*Y_LIM)

    x_lo, x_hi = ax.get_xlim()

    # Diagonal memory-bandwidth roof: perf = BW * intensity.
    if cfg.get("memory_roof", False):
        xs = np.array([x_lo, x_hi])
        ys = MEM_BW_BYTES_PER_CYCLE * xs
        ax.plot(xs, ys, color="#888888", linewidth=1.2, linestyle="--", zorder=1)
        # Label placed along the diagonal, inside the visible y-range.
        _, y_hi = ax.get_ylim()
        x_lab = min(x_hi, max(x_lo, y_hi / MEM_BW_BYTES_PER_CYCLE)) * 0.5
        ax.text(x_lab, MEM_BW_BYTES_PER_CYCLE * x_lab,
                f" mem roof: {MEM_BW_BYTES_PER_CYCLE:g} B/cycle",
                rotation=0, ha="left", va="bottom",
                fontsize=8, color="#555555", zorder=2)

    # Horizontal compute-peak ceilings.
    for peak_label, peak_value in peak_lines:
        ax.axhline(peak_value, color="#888888", linewidth=1.0,
                   linestyle="--", zorder=1)
        ax.text(0.005, peak_value, f"{peak_label}  ",
                transform=ax.get_yaxis_transform(),
                ha="left", va="bottom",
                fontsize=8, color="#555555")

    # Implementation points at fixed operational intensity.
    for entry in loaded:
        ys = reduce_points(entry["df"])
        xs = np.full_like(ys, entry["op_intensity"], dtype=float)
        ax.plot(xs, ys,
                marker="o", markersize=6.0, linewidth=0,
                color=entry["color"], markerfacecolor=entry["color"],
                markeredgecolor="white", markeredgewidth=0.6,
                label=entry["label"], zorder=3)

    # Tick formatting: plain numbers on log2 axes (no 2^n exponents).
    for axis_obj in (ax.xaxis, ax.yaxis):
        axis_obj.set_major_formatter(mticker.ScalarFormatter())
        axis_obj.set_minor_formatter(mticker.NullFormatter())
    ax.tick_params(axis="both", labelsize=8)

    ax.set_xlabel(X_LABEL, fontsize=10, color="#333333", labelpad=6)

    # Title block: title, grayed flags below it, then the y-axis descriptor
    # centered just above the top of the y-axis spine.
    fig.text(0.12, 0.87, TITLE,
             fontsize=12, fontweight="bold", color="#222222", ha="left")
    if FLAGS:
        fig.text(0.12, 0.83, FLAGS,
                 fontsize=9, color="#555555", ha="left")
    if Y_AXIS_DESC:
        pos = ax.get_position()
        fig.text(pos.x0, pos.y1 + 0.012, Y_AXIS_DESC,
                 fontsize=10, color="#333333", ha="center", va="bottom")

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
        print(f"\n{entry['label']} ({os.path.basename(entry['path'])}, "
              f"I={entry['op_intensity']:g} flops/byte):")
        cols = [X_COL, CYCLES_COL, "perf"]
        print(entry["df"][cols].to_string(index=False))


for i, cfg in enumerate(PLOT_CONFIGS, start=1):
    print(f"\n=== Plot {i} of {len(PLOT_CONFIGS)} ===")
    make_plot(cfg, numbered_output_path(OUTPUT_PATH, i))
