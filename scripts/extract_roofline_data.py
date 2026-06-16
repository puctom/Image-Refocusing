#!/usr/bin/env python3
"""Extract roofline data from Intel Advisor standalone roofline HTML exports.

Advisor embeds the full chart data as a JSON object literal
(``({"rooflineData": {...}})``) inside the HTML. All coordinates and roof
values are stored as log10, so this script converts them back to linear units.

By default it summarizes the DRAM memory level (the DRAM bandwidth roof and the
program-total DRAM dot) for every report, but ``--all-roofs`` dumps every
ceiling. Output is CSV on stdout, or to ``--out``.

Examples:
    python scripts/extract_roofline_data.py                 # all reports -> DRAM summary
    python scripts/extract_roofline_data.py --out dram.csv
    python scripts/extract_roofline_data.py path/to/one.html --all-roofs
"""
import argparse
import csv
import json
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
DEFAULT_DIR = PROJECT_ROOT / "cpp_refocus" / "roofline_reports"

MARKER = '({"rooflineData":'


def extract_payload(html):
    """Return the full parsed JSON payload (rooflineData, summaryInfo, ...).

    Advisor embeds it as ``({"rooflineData": {...}, ...})``; we brace-match the
    object that follows the marker, honoring string escaping.
    """
    pos = html.find(MARKER)
    if pos == -1:
        raise ValueError("No embedded rooflineData found")
    start = pos + 1  # the opening '{'
    depth = 0
    in_str = False
    esc = False
    for i in range(start, len(html)):
        c = html[i]
        if in_str:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                in_str = False
        else:
            if c == '"':
                in_str = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
                if depth == 0:
                    return json.loads(html[start:i + 1])
    raise ValueError("Unbalanced braces while parsing rooflineData")


def extract_roofline_data(html):
    """Return just the parsed ``rooflineData`` dict from one HTML export."""
    return extract_payload(html)["rooflineData"]


def lin(log_value):
    """Advisor stores coordinates/roofs as log10; convert back to linear."""
    return 10.0 ** log_value


def parse_variant_dataset(path):
    """roofline_<variant>_<dataset>.html -> (variant, dataset).

    Datasets are named like ``mock_2048`` (two underscore tokens); the variant
    is everything before that and may itself contain underscores.
    """
    stem = path.stem
    if stem.startswith("roofline_"):
        stem = stem[len("roofline_"):]
    tokens = stem.split("_")
    if len(tokens) >= 3:
        return "_".join(tokens[:-2]), "_".join(tokens[-2:])
    return stem, ""


def roofs_for_threadcount(rd, thread_count):
    """Pick the roof set matching thread_count (1 = single-threaded)."""
    groups = rd.get("allRoofs", [])
    for g in groups:
        if g.get("threadCount") == thread_count:
            return g.get("roofs", [])
    return groups[0].get("roofs", []) if groups else []


def dram_summary(rd):
    """DRAM roof bandwidth + the DRAM program-total dot, in linear units."""
    single = roofs_for_threadcount(rd, 1)
    dram_roof = next(
        (r for r in single if r.get("memoryLevel") == "DRAM" and r.get("isMem")),
        None,
    )
    dram_point = next(
        (p for p in rd.get("programTotal", [])
         if str(p.get("memoryLevelPref", "")).startswith("DRAM")),
        None,
    )
    fma = next((r for r in single if r.get("name", "").startswith("SP Vector FMA")), None)
    scalar_add = next((r for r in single if r.get("name", "").startswith("Scalar Add")), None)
    return {
        "dram_bw_gbs": lin(dram_roof["val"]) if dram_roof else "",
        "dram_ai_flop_byte": lin(dram_point["x"]) if dram_point else "",
        "perf_gflops": lin(dram_point["y"]) if dram_point else "",
        "self_time_s": dram_point.get("selfElapsedTime") if dram_point else "",
        "self_mem_gbs": dram_point.get("selfMem") if dram_point else "",
        "sp_fma_peak_gflops": lin(fma["val"]) if fma else "",
        "scalar_add_peak_gflops": lin(scalar_add["val"]) if scalar_add else "",
    }


def gather_files(paths):
    files = []
    for p in paths:
        p = Path(p)
        if p.is_dir():
            files.extend(sorted(p.glob("*.html")))
        else:
            files.append(p)
    return files


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("paths", nargs="*", default=[str(DEFAULT_DIR)],
                        help=f"HTML files or directories (default: {DEFAULT_DIR})")
    parser.add_argument("--all-roofs", action="store_true",
                        help="Emit one row per roof (every memory/compute ceiling) "
                             "instead of the DRAM summary")
    parser.add_argument("--out", help="Write CSV here instead of stdout")
    args = parser.parse_args()

    files = gather_files(args.paths)
    if not files:
        print("No HTML files found.", file=sys.stderr)
        return 1

    rows = []
    for f in files:
        try:
            rd = extract_roofline_data(f.read_text(encoding="utf-8", errors="replace"))
        except ValueError as exc:
            print(f"WARN {f.name}: {exc}", file=sys.stderr)
            continue
        variant, dataset = parse_variant_dataset(f)
        if args.all_roofs:
            for r in roofs_for_threadcount(rd, 1):
                rows.append({
                    "file": f.name, "variant": variant, "dataset": dataset,
                    "roof": r.get("name"), "memory_level": r.get("memoryLevel"),
                    "value_linear": lin(r["val"]), "measure": r.get("measure"),
                })
        else:
            rows.append({"file": f.name, "variant": variant, "dataset": dataset,
                         **dram_summary(rd)})

    if not rows:
        print("No data extracted.", file=sys.stderr)
        return 1

    out = open(args.out, "w", newline="") if args.out else sys.stdout
    writer = csv.DictWriter(out, fieldnames=list(rows[0].keys()))
    writer.writeheader()
    writer.writerows(rows)
    if args.out:
        out.close()
        print(f"Wrote {len(rows)} rows to {args.out}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
