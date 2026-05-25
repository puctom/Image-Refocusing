"""
General-purpose performance plot (flops/cycle) in Pueschel style.

Edit the CONFIG block below to choose:
  - which CSV files to plot
  - the label, color, and y-column for each
  - the x-axis column (shared across all files)
  - how flops are counted (FLOPS function)
  - axis labels, title, scales, output filename

Then run:  python3 plot_perf.py
"""

import os
import sys

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker

# ---------------------------------------------------------------------------
# CONFIG  — edit this block for your plot
# ---------------------------------------------------------------------------

# One entry per line on the plot.
SERIES = [
    {"path": "all_together/timing_basic_20260520_030006.csv", "label": "basic",          "color": "#2ca02c"},
    {"path": "all_together/all_together/timing_opt3_20260520_031559.csv",  "label": "opt3",               "color": "#d62728"},
    {"path": "all_together/timing_opt7_20260520_032617.csv",      "label": "opt7",   "color": "#9467bd"},
    {"path": "all_together/timing_opt9_20260503_070121.csv",      "label": "opt 9 AVX",   "color": "#ff7f0e"},
    {"path": "all_together/timing_opt13_20260520_033005.csv",      "label": "opt13",      "color": "#17becf"},
    {"path": "all_together/timing_opt17_20260520_033110.csv",     "label": "opt17",      "color": "#e377c2"},
]

# Shared x and cycles columns (same across all CSVs).
X_COL      = "img_w"
CYCLES_COL = "median_cycles"

# --- Flop count per measurement ---------------------------------------------
def FLOPS(df):
    ops_per_shift = 36 * 289         
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
TITLE       = "Refocus (shift-and-sum) on Intel Tiger Lake"
SUBTITLE    = "Performance [flops / cycle] vs. input size  (generated data, square images)"
X_LABEL     = "input size (image width = height)  [pixels]"
Y_LABEL     = "Performance  [flops / cycle]"
OUTPUT_PATH = "perf.png"

# Axis scales: "linear", "log", or "log2".
# Performance plots conventionally use linear y so the peak line is a flat
# ceiling and improvements are visually proportional.
X_SCALE = "log2"
Y_SCALE = "linear"

# Peak-performance reference lines (horizontal).
PEAK_LINES = [
    ("scalar peak (FMA, dp)", 4.0),
    ("AVX2 peak (FMA, sp)", 24.0),
]

LEGEND_LOC = "upper left"

# X-axis tick formatting: "human_size" or "plain"
X_TICK_FORMAT = "human_size"

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
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    for side in ("left", "bottom"):
        ax.spines[side].set_linewidth(0.8)
        ax.spines[side].set_color("#333333")

    ax.set_facecolor("#E5E5E5")
    ax.yaxis.grid(True, color="white", linewidth=1.0)
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


# ---------------------------------------------------------------------------
# Load
# ---------------------------------------------------------------------------
print("Loading CSV files:")
loaded = []
for entry in SERIES:
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
    df["perf"] = FLOPS(df) / df[CYCLES_COL]

    loaded.append({**entry, "df": df})
    print(f"  [ok]   {os.path.basename(path):<40s}  "
          f"({len(df)} rows, perf range "
          f"{df['perf'].min():.2f}–{df['perf'].max():.2f} flops/cycle)")

if not loaded:
    sys.exit("No data to plot. Check the SERIES paths in the CONFIG block.")

# ---------------------------------------------------------------------------
# Plot
# ---------------------------------------------------------------------------
fig, ax = plt.subplots(figsize=(9, 6))
fig.subplots_adjust(left=0.12, right=0.95, top=0.80, bottom=0.13)

all_x = set()
for entry in loaded:
    df = entry["df"]
    x = df[X_COL].to_numpy()
    y = df["perf"].to_numpy()
    all_x.update(x.tolist())

    ax.plot(x, y,
            marker="s", markersize=5.5, linewidth=2.0,
            color=entry["color"], markerfacecolor=entry["color"],
            markeredgecolor=entry["color"], label=entry["label"])

# Peak performance reference lines
for peak_label, peak_value in PEAK_LINES:
    ax.axhline(peak_value, color="#888888", linewidth=1.0,
               linestyle="--", zorder=1)
    ax.text(0.995, peak_value, f"  {peak_label}",
            transform=ax.get_yaxis_transform(),
            ha="right", va="bottom",
            fontsize=8, color="#555555")

apply_scale(ax, "x", X_SCALE)
apply_scale(ax, "y", Y_SCALE)

# X ticks
x_ticks = sorted(all_x)
if X_SCALE in ("log", "log2"):
    ax.set_xticks(x_ticks)
    ax.xaxis.set_minor_locator(mticker.NullLocator())
    if len(x_ticks) > 1:
        ax.set_xlim(x_ticks[0] * 0.85, x_ticks[-1] * 1.15)
if X_TICK_FORMAT == "human_size":
    ax.set_xticks(x_ticks)
    ax.set_xticklabels([human_size(v) for v in x_ticks])

# Y starts at 0 for linear performance plots (so the bars are honest).
if Y_SCALE == "linear":
    ax.set_ylim(bottom=0)

# Axis labels
ax.set_xlabel(X_LABEL, fontsize=10, color="#333333", labelpad=6)
# if Y_LABEL:
#     ax.set_ylabel(Y_LABEL, fontsize=10, color="#333333",
#                   labelpad=6, rotation=90)

# Title block
fig.text(0.12, 0.87, TITLE,
         fontsize=12, fontweight="bold", color="#222222", ha="left")
if SUBTITLE:
    fig.text(0.12, 0.83, SUBTITLE,
             fontsize=10, color="#333333", ha="left")

style_axes(ax)

if LEGEND_LOC is not None:
    handles, labels = ax.get_legend_handles_labels()
    ax.legend(handles, labels,
              loc=LEGEND_LOC,
              frameon=True, fontsize=9, labelcolor="#333333",
              handlelength=2.2, borderaxespad=0.8,
              facecolor="white", edgecolor="none",
              framealpha=0.92)

fig.savefig(OUTPUT_PATH, dpi=160, bbox_inches="tight")
print(f"\nSaved plot to {OUTPUT_PATH}")

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
print("\nData plotted:")
for entry in loaded:
    print(f"\n{entry['label']} ({os.path.basename(entry['path'])}):")
    cols = [X_COL, CYCLES_COL, "perf"]
    print(entry["df"][cols].to_string(index=False))