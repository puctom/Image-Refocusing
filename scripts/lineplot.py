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

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import math

# ---------------------------------------------------------------------------
# CONFIG  — edit this block for your plot
# ---------------------------------------------------------------------------

# One entry per line on the plot.
# Each dict needs: path, label, color.
# Optional: filter (a callable that takes a DataFrame and returns a mask).
# SERIES = [
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_no_ilp_no_reuse_20260601_202823.csv",     "label": "opt17_no_ilp_no_reuse",                "color": "#1f4e9e"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_20260602_041212.csv",      "label": "opt17",      "color": "#1eff05"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_ilp_only_20260601_203043.csv",   "label": "opt17_ilp_only",   "color": "#bcbd22"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_row_reuse_only_20260601_203255.csv",     "label": "opt17_row_reuse_only",      "color": "#9b117dff"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt12_20260602_040221.csv",     "label": "opt12",      "color": "#b30df4ff"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt11_20260602_040018.csv",     "label": "opt11",      "color": "#290b36ff"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt12_new_tile_20260602_040817.csv",     "label": "opt12_new_tile",      "color": "#9a82a5ff"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_no_ilp_no_reuse_old_tile_20260602_040933.csv",     "label": "opt17_no_ilp_no_reuse_old_tile",      "color": "#e9d2f3ff"},

# ]

# #  FOR old_tile vs new_tile

# SERIES = [
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_no_ilp_no_reuse_20260601_202823.csv",     "label": "opt17_no_ilp_no_reuse",                "color": "#52d918"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_20260602_041212.csv",      "label": "opt17",      "color": "#20a911"},
#     # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_ilp_only_20260601_203043.csv",   "label": "opt17_ilp_only",   "color": "#bcbd22"},
#     # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_row_reuse_only_20260601_203255.csv",     "label": "opt17_row_reuse_only",      "color": "#9b117dff"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt12_20260602_040221.csv",     "label": "opt12",      "color": "#fa2e6fff"},
#     # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt11_20260602_040018.csv",     "label": "opt11",      "color": "#290b36ff"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt12_new_tile_20260602_040817.csv",     "label": "opt12_new_tile",      "color": "#b4f91fff"},
#     {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_no_ilp_no_reuse_old_tile_20260602_040933.csv",     "label": "opt17_no_ilp_no_reuse_old_tile",      "color": "#d83434ff"},

# ]


#  FOR register reuse
SERIES = [
    # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_no_ilp_no_reuse_20260601_202823.csv",     "label": "opt17_no_ilp_no_reuse",                "color": "#52d918"},
    {"path": "scripts/timing_opt17_20260602_041212.csv",      "label": "Process 4 rows (reuse)",      "color": "#ec84f5"},
    {"path": "scripts/timing_opt17_ilp_only_20260601_203043.csv",   "label": "Without reusing",   "color": "#7a1818ff"},
    # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_row_reuse_only_20260601_203255.csv",     "label": "opt17_row_reuse_only",      "color": "#9b117dff"},
    # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt12_20260602_040221.csv",     "label": "opt12",      "color": "#fa2e6fff"},
    # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt11_20260602_040018.csv",     "label": "opt11",      "color": "#290b36ff"},
    # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt12_new_tile_20260602_040817.csv",     "label": "opt12_new_tile",      "color": "#b4f91fff"},
    # {"path": "/home/team15/tomasz-worktree-dir/scripts/timing_results/timing_opt17_no_ilp_no_reuse_old_tile_20260602_040933.csv",     "label": "opt17_no_ilp_no_reuse_old_tile",      "color": "#d83434ff"},

]


# Shared x and y columns (same across all CSVs).
X_COL = "img_w"
Y_COL = "median_cycles"

# Optional shared filter applied to every CSV. Return df for no filter.
# Example: keep only square generated images.
def SHARED_FILTER(df):
    return (
        df["data_source"].str.startswith("generated")
        & (df["img_w"] == df["img_h"]) & (df["img_w"] < 3072) & (df["img_w"] > 64)
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

# Label of the series to use as the denominator in the normalized L1D plot.
# Set to None to use the first loaded series.
L1D_NORM_REF_LABEL = "Without reusing"

# Sizes (img_w values) to include in the normalized L1D bar chart.
# Set to None to include all sizes passing SHARED_FILTER.
L1D_NORM_SIZES = [512, 1024, 2048]

CACHE_METRICS = [
    {"col": "avg_l1d_loads",     "title": "L1 Data Cache Loads",            "scale": "log"},
    {"col": "avg_l1d_loads",     "title": "L1 Data Cache Loads Linear",            "scale": "linear"},
    {"col": "avg_l1d_misses",    "title": "L1 Data Cache Misses",           "scale": "log"},
    {"col": "avg_l1d_stores",    "title": "L1 Data Cache Stores",           "scale": "log"},
    {"col": "avg_l1d_miss_rate", "title": "L1D Miss Rate (%)",            "scale": "linear"},
    {"col": "avg_l1i_misses",    "title": "L1 Instruction Cache Misses",    "scale": "log"},

    {"col": "avg_dtlb_loads",    "title": "DTLB Loads",                     "scale": "log"},
    {"col": "avg_dtlb_load_misses","title": "DTLB Load Misses",             "scale": "log"},
    {"col": "avg_dtlb_stores",   "title": "DTLB Stores",                    "scale": "log"},
    {"col": "avg_dtlb_store_misses","title": "DTLB Store Misses",           "scale": "log"},

    {"col": "avg_itlb_load_misses","title": "ITLB Load Misses",             "scale": "log"},

    {"col": "avg_llc_loads",     "title": "Last Level Cache (L3) Loads",    "scale": "log"},
    {"col": "avg_llc_loads",     "title": "Last Level Cache (L3) Loads Linear",    "scale": "linear"},
    {"col": "avg_llc_misses",    "title": "Last Level Cache (L3) Misses",   "scale": "log"},
    {"col": "avg_llc_stores",    "title": "LLC Stores",                     "scale": "log"},
    {"col": "avg_llc_miss_rate", "title": "LLC Miss Rate (%)",            "scale": "linear"},
    {"col": "avg_llc_store_misses","title": "LLC Store Misses",             "scale": "log"},

    {"col": "avg_major_page_faults","title": "Major Page Faults",           "scale": "linear"},
    {"col": "avg_minor_page_faults","title": "Minor Page Faults",           "scale": "linear"},
    {"col": "avg_branch_instr",  "title": "Branch Instructions",            "scale": "log"},
    {"col": "avg_branch_misses", "title": "Branch Misses",                 "scale": "log"},
    {"col": "branch_miss_rate",  "title": "Branch Miss Rate (%)",         "scale": "linear"},
    {"col": "avg_instructions",  "title": "Instructions",                  "scale": "log"},
    {"col": "ipc",               "title": "IPC",                           "scale": "linear"},
]


# ---------------------------------------------------------------------------
# Implementation
# ---------------------------------------------------------------------------


def fmt_count(n):
    """Format a raw count with a K/M/G suffix, 1 decimal place."""
    n = float(n)
    if n >= 1e9:
        return f"{n/1e9:.1f}G"
    if n >= 1e6:
        return f"{n/1e6:.1f}M"
    if n >= 1e3:
        return f"{n/1e3:.1f}K"
    return f"{n:.0f}"


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


# Create a dynamic grid based on number of metrics.
n_metrics = len(CACHE_METRICS)
# prefer 4 columns for reasonable width
ncols = 4
nrows = math.ceil(n_metrics / ncols)
fig_width = max(12, ncols * 4)
fig_height = max(6, nrows * 3)
fig, axs = plt.subplots(nrows=nrows, ncols=ncols, figsize=(fig_width, fig_height))
fig.subplots_adjust(hspace=0.4, wspace=0.25, top=0.88, bottom=0.08, left=0.05, right=0.95)

# Overall Figure Title
fig.suptitle("Memory Hierarchy Performance Profile (probably not so useful though)", fontsize=16, fontweight="bold", color="#222222", y=0.96)

axs_flat = axs.flatten()

for idx, metric in enumerate(CACHE_METRICS):
    ax = axs_flat[idx]
    y_col = metric["col"]
    y_title = metric["title"]
    y_scale = metric["scale"]
    
    all_x = set()
    has_data = False

    for entry in loaded:
        df = entry["df"]
        if y_col not in df.columns:
            continue
            
        has_data = True
        x = df[X_COL].to_numpy()
        y = df[y_col].to_numpy()
        all_x.update(x.tolist())

        ax.plot(x, y,
                marker="s", markersize=5, linewidth=1.5,
                color=entry["color"], markerfacecolor=entry["color"],
                markeredgecolor=entry["color"], label=entry["label"])

    if not has_data:
        ax.text(0.5, 0.5, f"No data for\n{y_col}", ha='center', va='center', transform=ax.transAxes, color="gray")
        style_axes(ax)
        ax.set_title(y_title, fontsize=11, fontweight="bold", color="#333333", pad=10)
        continue

    apply_scale(ax, "x", X_SCALE)
    apply_scale(ax, "y", y_scale)

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

    # Y formatting on log scale
    if y_scale == "log":
        ax.yaxis.set_major_formatter(mticker.LogFormatterMathtext(base=10))

    ax.set_title(y_title, fontsize=11, fontweight="bold", color="#333333", pad=10)
    ax.set_xlabel(X_LABEL, fontsize=9, color="#555555", labelpad=4)
    style_axes(ax)

    # Put the legend only in the first subplot to save space
    if idx == 0 and LEGEND_LOC is not None:
        handles, labels = ax.get_legend_handles_labels()
        if handles:
            ax.legend(handles, labels, loc=LEGEND_LOC,
                      frameon=True, fontsize=9, labelcolor="#333333",
                      handlelength=2.0, borderaxespad=0.8,
                      facecolor="white", edgecolor="none", framealpha=0.9)

# Hide any unused subplots (if grid larger than metrics)
axs_flat = axs.flatten()
for ax_empty in axs_flat[len(CACHE_METRICS):]:
    ax_empty.set_visible(False)

out_file = "cache_metrics_grid.png"
fig.savefig(out_file, dpi=160, bbox_inches="tight", facecolor="white")
plt.close(fig)
print(f"  [saved] {out_file}")


# ---------------------------------------------------------------------------
# Cycles Per Pixel Plot
# ---------------------------------------------------------------------------
fig, ax = plt.subplots(figsize=(9, 6))
fig.subplots_adjust(left=0.12, right=0.95, top=0.80, bottom=0.13)

all_x = set()
has_cpp_data = False

for entry in loaded:
    df = entry["df"]
    if "cycles_per_pixel" not in df.columns:
        continue
    
    has_cpp_data = True
    x = df[X_COL].to_numpy()
    y = df["cycles_per_pixel"].to_numpy()
    all_x.update(x.tolist())

    ax.plot(x, y,
            marker="s", markersize=5.5, linewidth=1.6,
            color=entry["color"], markerfacecolor=entry["color"],
            markeredgecolor=entry["color"], label=entry["label"])

if has_cpp_data:
    apply_scale(ax, "x", X_SCALE)
    # Linear scale for cycles_per_pixel
    apply_scale(ax, "y", "linear")

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

    # Axis labels
    ax.set_xlabel(X_LABEL, fontsize=10, color="#333333", labelpad=6)
    ax.set_ylabel("Cycles per Pixel", fontsize=10, color="#333333",
                  labelpad=6, rotation=90)

    # Title block
    fig.text(0.12, 0.87, "Cycles Per Pixel (Linear Scale)",
             fontsize=12, fontweight="bold", color="#222222", ha="left")
    fig.text(0.12, 0.83, "Linear cycles per pixel vs. input size  (generated data, square images)",
             fontsize=10, color="#333333", ha="left")

    style_axes(ax)

    # Legend
    if LEGEND_LOC is not None:
        handles, labels = ax.get_legend_handles_labels()
        ax.legend(handles, labels,
                  loc=LEGEND_LOC,
                  frameon=True, fontsize=9, labelcolor="#333333",
                  handlelength=2.2, borderaxespad=0.8,
                  facecolor="white", edgecolor="none",
                  framealpha=0.92)

    fig.savefig("cycles_per_pixel.png", dpi=160, bbox_inches="tight")
    print(f"Saved cycles_per_pixel plot to cycles_per_pixel.png")
else:
    print("  [skip] cycles_per_pixel column not found in any data files")
    plt.close(fig)


# ---------------------------------------------------------------------------
# L1D Loads Normalized Column Plot
# ---------------------------------------------------------------------------
_l1d_col = "avg_l1d_loads"
_l1d_series = [(e, e["df"].set_index(X_COL)[_l1d_col])
               for e in loaded if _l1d_col in e["df"].columns]

if len(_l1d_series) >= 2:
    # Pick reference series by label, fall back to first.
    _ref_entry = next(
        (e for e, _ in _l1d_series if e["label"] == L1D_NORM_REF_LABEL),
        _l1d_series[0][0],
    )
    ref_label = _ref_entry["label"]
    ref_s     = next(s for e, s in _l1d_series if e["label"] == ref_label)

    common_x = sorted(set.intersection(*[set(s.index) for _, s in _l1d_series]))
    if L1D_NORM_SIZES is not None:
        common_x = [x for x in common_x if x in L1D_NORM_SIZES]

    if not common_x:
        print("  [skip] l1d_loads_normalized: no x values remain after size filter")
    else:
        n_groups = len(common_x)
        n_bars   = len(_l1d_series)
        bar_w    = 0.8 / n_bars
        x_idx    = np.arange(n_groups)

        fig, ax = plt.subplots(figsize=(max(10, n_groups * 0.7), 5))
        fig.subplots_adjust(left=0.10, right=0.95, top=0.80, bottom=0.15)

        for i, (entry, s) in enumerate(_l1d_series):
            ref_vals = ref_s.reindex(common_x).to_numpy(dtype=float)
            vals     = s.reindex(common_x).to_numpy(dtype=float)
            normed   = vals / ref_vals
            offsets  = x_idx + (i - (n_bars - 1) / 2.0) * bar_w
            bars = ax.bar(offsets, normed, width=bar_w * 0.92,
                          color=entry["color"], label=entry["label"])
            for rect, abs_val in zip(bars, vals):
                ax.text(rect.get_x() + rect.get_width() / 2,
                        rect.get_height() + 0.005,
                        fmt_count(abs_val),
                        ha="center", va="bottom",
                        fontsize=8, color="#333333")

        ax.axhline(1.0, color="#555555", linewidth=1.0, linestyle="--")

        ax.set_xticks(x_idx)
        ax.set_xticklabels([str(v) for v in common_x],
                           rotation=45, ha="right", fontsize=8)
        ax.set_xlabel(X_LABEL, fontsize=10, color="#333333", labelpad=6)
        ax.set_ylabel(f"L1D loads  /  {ref_label}", fontsize=10,
                      color="#333333", labelpad=6)

        fig.text(0.10, 0.87, "L1 Data Cache Loads — Normalized",
                 fontsize=12, fontweight="bold", color="#222222", ha="left")
        fig.text(0.10, 0.83, f"Each series divided by \"{ref_label}\"  (1.0 = same as reference)",
                 fontsize=10, color="#333333", ha="left")

        style_axes(ax)

        if LEGEND_LOC is not None:
            handles, labels = ax.get_legend_handles_labels()
            ax.legend(handles, labels, loc=LEGEND_LOC,
                      frameon=True, fontsize=9, labelcolor="#333333",
                      handlelength=1.8, borderaxespad=0.8,
                      facecolor="white", edgecolor="none", framealpha=0.92)

        _out = "l1d_loads_normalized.png"
        fig.savefig(_out, dpi=160, bbox_inches="tight")
        plt.close(fig)
        print(f"Saved l1d_loads_normalized plot to {_out}")
else:
    print("  [skip] l1d_loads_normalized: need at least 2 series with avg_l1d_loads")

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
print("\nData plotted:")
for entry in loaded:
    print(f"\n{entry['label']} ({os.path.basename(entry['path'])}):")
    cols = [X_COL, Y_COL]
    print(entry["df"][cols].to_string(index=False))