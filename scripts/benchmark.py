#!/usr/bin/env python3
import argparse
import subprocess
import sys
from pathlib import Path
import datetime

# If this script is in /scripts directory it should be runnable from anywhere.
# For example: python3 ../scripts/benchmark.py basic --focus 3.319 --sizes 128 256 512
SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
CPP_DIR = PROJECT_ROOT / "cpp_refocus"
BUILD_DIR = CPP_DIR / "build"
DATA_DIR = PROJECT_ROOT / "in" / "validation"

RESULTS_DIR = SCRIPT_DIR / "timing_results"
RESULTS_DIR.mkdir(parents=True, exist_ok=True)

PROFILING_DIR = SCRIPT_DIR / "profiling_reports"
PROFILING_DIR.mkdir(parents=True, exist_ok=True)

timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")

# configuration defaults
DEFAULT_FOCUS = 6.7
DEFAULT_STACK_FOCUSES = [-49.3, -20.0, 0.0, 5.0, 12.352, 33.33, 49.0]
DEFAULT_SIZES = [16, 32, 64, 128, 256, 512, 1024, 2048]

def save_detailed_perf_annotate(label, perf_data_file):
    annotation_file = PROFILING_DIR / f"annotation_{label}_{timestamp}.txt"
    print("  -> Generating assembly annotation for refocus_shift_and_sum...")

    annotate_cmd = [
        "perf", "annotate", 
        "--stdio",
        "-i", str(perf_data_file), # -i: read from our specific perf.data 
        "-M", "intel" # use Intel assembly syntax
    ]
    
    with open(annotation_file, "w") as f:
        subprocess.run(annotate_cmd, stdout=f, stderr=subprocess.DEVNULL, check=True)
        
    print(f"  -> Profiling report saved to: {annotation_file}")

def make_bench_cmd(target, bench_args, perf_data_file=None):
    bench_args_str = [str(a) for a in bench_args]
    bin = str(BUILD_DIR / f"bench-{target}")

    if perf_data_file is not None:
        # Wrap with perf record for performance insights if profiling
        return [
            "perf", "record",
            "-e", "L1-dcache-load-misses,cycles", # Could be more events to record, can be added in the future
            "-o", str(perf_data_file),
            "--", bin
        ] + bench_args_str
    else:
        return [bin] + bench_args_str


# Run benchmark with optional extra profiling
def run_benchmark(target, bench_args, label, profile=False):
    perf_data_file = PROFILING_DIR / f"perf_{target}_{label}_{timestamp}.data" if profile else None
    cmd = make_bench_cmd(target, bench_args, perf_data_file)

    print(f"Running: {' '.join(cmd)}")
    subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, cwd=CPP_DIR) # check=True ensures an exception is raised if CPP fails

    # Profiling post-processing: if profiled, generate detailed assembly annotation
    if perf_data_file and perf_data_file.exists():
        save_detailed_perf_annotate(label, perf_data_file)
def build_bench_binary(target):
    print(f"--- Building Bench Target in {CPP_DIR} ---")
    try:
        subprocess.run(["make", f"build/bench-{target}"], cwd=CPP_DIR, check=True)
    except subprocess.CalledProcessError:
        print("[ERROR] Compilation failed. Aborting benchmarks.")
        sys.exit(1)

def parse_args(raw_args=None):
    # Focus parameter and sizes of generated images can be specified as arguments
    # e.g. python3 scripts/benchmark.py basic --focus 3.5 --sizes 256 512 1024
    # Otherwise the default ones are used.
    parser = argparse.ArgumentParser()
    parser.add_argument("target", type=str)
    
    # Configuration arguments
    parser.add_argument("--focus", type=float, default=DEFAULT_FOCUS,
                        help=f"Focus parameter for single image (default: {DEFAULT_FOCUS})")
    
    # New: List of focuses for the stack execution
    parser.add_argument("--focuses", type=float, nargs="+", default=DEFAULT_STACK_FOCUSES,
                        help=f"List of focus parameters for stack (default: {DEFAULT_STACK_FOCUSES})")
                        
    parser.add_argument("--sizes", type=int, nargs="+", default=DEFAULT_SIZES,
                        metavar="N", help=f"Square image sizes to generate (default: {DEFAULT_SIZES})")
                        
    parser.add_argument("--stack", action="store_true", help="Benchmark the focal stack")
    parser.add_argument("--profile", action="store_true", 
                        help="Run with Linux perf to generate assembly bottlenecks")
    return parser.parse_args(raw_args)

def main():
    args = parse_args()
    build_bench_binary(args.target)

    timing_csv = RESULTS_DIR / f"timing_{args.target}_{timestamp}.csv"

    print("\n--- Running Real Dataset ---")
    if args.stack:
        # Pass the unpacked list of focuses for the stack binary
        cmd_args = [DATA_DIR, "real_data_1", timing_csv] + args.focuses
        run_benchmark(args.target, cmd_args, label="real_data", profile=args.profile)
    else:
        # Pass the single focus
        cmd_args = [DATA_DIR, args.focus, "real_data_1", timing_csv]
        run_benchmark(args.target, cmd_args, label="real_data", profile=args.profile)

    print("\n--- Running Generated Dataset ---")
    for wh in args.sizes:
        label = f"gen_{wh}x{wh}_1"
        if args.stack:
            cmd_args = ["--generate", wh, wh, label, timing_csv] + args.focuses
            run_benchmark(args.target, cmd_args, label=label, profile=args.profile)
        else:  
            cmd_args = ["--generate", wh, wh, args.focus, label, timing_csv]
            run_benchmark(args.target, cmd_args, label=label, profile=args.profile)

    print(f"\n[SUCCESS] Benchmarks complete. Results saved to {timing_csv}")

if __name__ == "__main__":
    main()