"""
General-purpose line plot in Pueschel style.

Edit the CONFIG block below to choose:
  - which CSV files to plot
  - the label, color, and y-column for each
  - the x-axis column (shared across all files)
  - axis labels, title, scales, output filename

Then run:  python3 plot_lines.py
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
# Each dict needs: path, label, color.
# Optional: filter (a callable that takes a DataFrame and returns a mask).
SERIES = [
    {"path": "timing_basic_20260425_181206.csv",     "label": "basic (scalar)",                "color": "#1f4e9e"},
    {"path": "timing_basic-opt_20260425_193644.csv", "label": "basic + compiler opt",          "color": "#2ca02c"},
    {"path": "timing_opt1_20260425_204021.csv",      "label": "loop reordering",               "color": "#d62728"},
    {"path": "timing_opt2_20260425_212215.csv",      "label": "+ common subexp elimination",   "color": "#9467bd"},
    {"path": "timing_opt3_20260425_215043.csv",      "label": "+ better bounds for x and y",   "color": "#ff7f0e"},
    {"path": "timing_opt4_20260425_221727.csv",      "label": "+ unchecked array access",      "color": "#17becf"},
]

# Shared x and y columns (same across all CSVs).
X_COL = "img_w"
Y_COL = "median_cycles"

# Optional shared filter applied to every CSV. Return df for no filter.
# Example: keep only square generated images.
def SHARED_FILTER(df):
    return (
        df["data_source"].str.startswith("generated")
        & (df["img_w"] == df["img_h"])
    )

# Plot decoration
TITLE       = "Refocus (shift-and-sum) on Intel Tiger Lake"
SUBTITLE    = "Median cycles vs. input size  (generated data, square images)"
X_LABEL     = "input size (image width = height)  [pixels]"
Y_LABEL     = None   # set to a string to show a y-axis label, or None to hide
OUTPUT_PATH = "lineplot.png"

# Axis scales: "linear", "log", or "log2" (log base 2 — useful for power-of-2
# image sizes on the x-axis).
X_SCALE = "log2"
Y_SCALE = "log"

# Legend placement: "upper left", "upper right", "lower left", "lower right",
# "best", or None to hide.
LEGEND_LOC = "upper left"

# X-axis tick formatting.
# "human_size"  -> 128, 256, 1k, 4k, 1M  (good for image sizes)
# "plain"       -> matplotlib default
X_TICK_FORMAT = "human_size"

# ---------------------------------------------------------------------------
# Implementation
# ---------------------------------------------------------------------------


def human_size(n):
    """Format integer n as 16, 64, 256, 1k, 4k, 1M, ... (power-of-2 friendly)."""
    n = int(n)
    if n < 1024:
        return str(n)
    if n < 1024 * 1024:
        return f"{n // 1024}k"
    return f"{n // (1024 * 1024)}M"


def style_axes(ax):
    """Apply Pueschel-style axis decoration."""
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    for side in ("left", "bottom"):
        ax.spines[side].set_linewidth(0.8)
        ax.spines[side].set_color("#333333")

    ax.set_facecolor("#ededed")
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

    missing = [c for c in (X_COL, Y_COL) if c not in df.columns]
    if missing:
        print(f"  [skip] {path}: missing columns {missing}")
        continue
    if df.empty:
        print(f"  [skip] {path}: no rows after filter")
        continue

    loaded.append({**entry, "df": df})
    print(f"  [ok]   {os.path.basename(path):<40s} "
          f"y={Y_COL}  ({len(df)} rows)")

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
    y = df[Y_COL].to_numpy()
    all_x.update(x.tolist())

    ax.plot(x, y,
            marker="s", markersize=5.5, linewidth=1.6,
            color=entry["color"], markerfacecolor=entry["color"],
            markeredgecolor=entry["color"], label=entry["label"])

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

# Y formatting on log scale: 10^x labels.
if Y_SCALE == "log":
    ax.yaxis.set_major_formatter(mticker.LogFormatterMathtext(base=10))

# Axis labels
ax.set_xlabel(X_LABEL, fontsize=10, color="#333333", labelpad=6)
if Y_LABEL:
    ax.set_ylabel(Y_LABEL, fontsize=10, color="#333333",
                  labelpad=6, rotation=90)

# Title block (above the plot, left-aligned)
fig.text(0.12, 0.87, TITLE,
         fontsize=12, fontweight="bold", color="#222222", ha="left")
if SUBTITLE:
    fig.text(0.12, 0.83, SUBTITLE,
             fontsize=10, color="#333333", ha="left")

style_axes(ax)

# Legend — kept inside the plot area, white background.
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
    cols = [X_COL, Y_COL]
    print(entry["df"][cols].to_string(index=False))