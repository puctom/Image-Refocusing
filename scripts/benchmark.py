#!/usr/bin/env python3
import argparse
import random
import subprocess
import sys
from pathlib import Path
import datetime

try:
    import yaml
except ImportError:
    yaml = None

# If this script is in /scripts directory it should be runnable from anywhere.
# For example: python3 ../scripts/benchmark.py basic --focus 3.319 --sizes 128 256 512
# For example (stack): python3 ../scripts/benchmark.py --stack basic --focuses 3.319 --sizes 128 256 512
#                                                   ^NOTE^ the stack flag ^NOTE^ the focuses here
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
DEFAULT_STACK_FOCUSES = [-49.3, -20.12, 0.10, 5.34, 12.352, 33.33, 49.0]
DEFAULT_SIZES = [16, 32, 64, 128, 256, 512, 1024, 2048]

def load_yaml_config(path):
    if yaml is None:
        print("[ERROR] PyYAML is required for --config mode. Install it with: pip install pyyaml")
        sys.exit(1)
    with open(path, "r") as f:
        config = yaml.safe_load(f)
    if not isinstance(config, dict) or "benchmarks" not in config:
        print("[ERROR] YAML config must contain a top-level 'benchmarks' list.")
        sys.exit(1)
    return config

def range_values(spec, name):
    if spec is None:
        return []
    if isinstance(spec, int):
        return [spec]
    if isinstance(spec, list):
        return spec
    if not isinstance(spec, dict):
        raise ValueError(f"{name} must be an integer, list, or range object")

    start = int(spec["start"])
    stop = int(spec["stop"])
    step = int(spec.get("step", 1))
    if step <= 0:
        raise ValueError(f"{name}.step must be positive")
    return list(range(start, stop + 1, step))

def choose_square_like_dimensions(num_pixels):
    best_w = 16
    best_h = max(1, (num_pixels + best_w - 1) // best_w)
    best_score = abs(best_w - best_h)

    for width in range(16, num_pixels + 17, 16):
        height = (num_pixels + width - 1) // width
        score = abs(width - height)
        if score < best_score:
            best_w = width
            best_h = height
            best_score = score
        if width > height and score > best_score:
            break
    return best_w, best_h

def random_focuses(length):
    return [random.uniform(-50.0, 50.0) for _ in range(length)]

def make_generated_cases(bench):
    pixel_spec = bench.get("pixels", bench.get("pixel_count"))
    pixel_values = range_values(pixel_spec, "pixels")
    if pixel_values:
        for pixels in pixel_values:
            w, h = choose_square_like_dimensions(pixels)
            yield w, h, f"gen_{pixels}px_{w}x{h}"
        return

    widths = range_values(bench.get("width"), "width")
    heights = range_values(bench.get("height"), "height")
    if not widths or not heights:
        sizes = range_values(bench.get("sizes", DEFAULT_SIZES), "sizes")
        for wh in sizes:
            yield wh, wh, f"gen_{wh}x{wh}"
        return

    for h in heights:
        for w in widths:
            if w % 16 != 0:
                raise ValueError(f"width must be divisible by 16 in YAML mode, got {w}")
            yield w, h, f"gen_{w}x{h}"

def run_config_benchmarks(config):
    random.seed(config.get("seed"))
    for index, bench in enumerate(config["benchmarks"], start=1):
        target = bench["target"]
        profile = bool(bench.get("profile", False))
        include_real = bool(bench.get("real", False))
        stack_lengths = range_values(bench.get("focal_stack_length"), "focal_stack_length")
        stack = bool(bench.get("stack", bool(stack_lengths)))
        focus = float(bench.get("focus", DEFAULT_FOCUS))

        build_bench_binary(target)
        timing_csv = RESULTS_DIR / f"timing_{target}_{timestamp}_bench{index}.csv"

        if include_real:
            print("\n--- Running Real Dataset ---")
            if stack:
                focuses = random_focuses(stack_lengths[0] if stack_lengths else len(DEFAULT_STACK_FOCUSES))
                cmd_args = [DATA_DIR, "real_data_1", timing_csv] + focuses
            else:
                cmd_args = [DATA_DIR, focus, "real_data_1", timing_csv]
            run_benchmark(target, cmd_args, label=f"real_data_bench{index}", profile=profile)

        print("\n--- Running Generated Dataset ---")
        for w, h, label_base in make_generated_cases(bench):
            if stack:
                lengths = stack_lengths or [len(DEFAULT_STACK_FOCUSES)]
                for stack_len in lengths:
                    label = f"{label_base}_stack{stack_len}_bench{index}"
                    cmd_args = ["--generate", w, h, label, timing_csv] + random_focuses(stack_len)
                    run_benchmark(target, cmd_args, label=label, profile=profile)
            else:
                label = f"{label_base}_bench{index}"
                cmd_args = ["--generate", w, h, focus, label, timing_csv]
                run_benchmark(target, cmd_args, label=label, profile=profile)

        print(f"\n[SUCCESS] Benchmark {index} complete. Results saved to {timing_csv}")

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
    parser.add_argument("target", type=str, nargs="?")
    parser.add_argument("--config", type=Path,
                        help="Read benchmarks from a YAML config file")
    
    # Configuration arguments
    parser.add_argument("--focus", type=float, default=DEFAULT_FOCUS,
                        help=f"Focus parameter for single image (default: {DEFAULT_FOCUS})")
    
    # New: List of focuses for the stack execution
    parser.add_argument("--focuses", type=float, nargs="+", default=DEFAULT_STACK_FOCUSES,
                        help=f"List of focus parameters for stack (default: {DEFAULT_STACK_FOCUSES})")
                        
    parser.add_argument("--sizes", type=int, nargs="+", default=DEFAULT_SIZES,
                        metavar="N", help=f"Square image sizes to generate (default: {DEFAULT_SIZES})")
    parser.add_argument(
        "--exclude-real", 
        dest="real", 
        action="store_false", 
        default=True, # Since dest="real", by default it is enabled
        help="Exclude the benchmark run on the real dataset"
    )
    parser.add_argument("--stack", action="store_true", help="Benchmark the focal stack")
    parser.add_argument("--profile", action="store_true", 
                        help="Run with Linux perf to generate assembly bottlenecks")
    return parser.parse_args(raw_args)

def main():
    args = parse_args()
    if args.config:
        run_config_benchmarks(load_yaml_config(args.config))
        return
    if args.target is None:
        print("[ERROR] target is required unless --config is used.")
        sys.exit(1)

    build_bench_binary(args.target)

    timing_csv = RESULTS_DIR / f"timing_{args.target}_{timestamp}.csv"
    if args.real:
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
