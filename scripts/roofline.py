import argparse
import os
import shutil
import subprocess
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
CPP_DIR = PROJECT_ROOT / "cpp_refocus"


def run_cmd(cmd, source_setvars=False, capture_output=False):
    cmd = " ".join(cmd) 
    if source_setvars:
        cmd = "source /opt/intel/oneapi/setvars.sh --force ; " + cmd 

    print("Running:", cmd)
    return subprocess.run(
        ["bash", "-lc", cmd],
        cwd=CPP_DIR,
        check=True,
        text=True,
        capture_output=capture_output,
    )


def build_target(target):
    run_cmd(["make", f"build/{target}"])


def collect_survey(project_dir, target, dataset, focus):
    run_cmd(
        [
            "advisor",
            "--collect=survey",
            "--start-paused",
            f"--project-dir={project_dir}",
            "--search-dir",
            "src:r=.",
            "--",
            f"./build/{target}",
            dataset,
            str(focus),
            "/tmp/out.png",
        ],
        source_setvars=True,
    )


def collect_tripcounts(project_dir, target, dataset, focus):
    run_cmd(
        [
            "advisor",
            "--collect=tripcounts",
            "--flop",
            "--no-trip-counts",
            "--enable-cache-simulation",
            "--start-paused",
            f"--project-dir={project_dir}",
            "--search-dir",
            "src:r=.",
            "--",
            f"./build/{target}",
            dataset,
            str(focus),
            "/tmp/out.png",
        ],
        source_setvars=True,
    )


def read_survey_csv(project_dir):
    result = run_cmd(
        [
            "advisor",
            "--report=survey",
            f"--project-dir={project_dir}",
            "--show-loops",
            "--no-show-functions",
            "--format=csv",
            "--limit=20",
        ],
        source_setvars=True,
        capture_output=True,
    )
    return result.stdout


def ensure_kernel_only_survey(survey_csv):
    bad_markers = ["lodepng_", "unfilterScanline", "load_subaperture_images"]
    leaked = [marker for marker in bad_markers if marker in survey_csv]
    if leaked:
        raise RuntimeError(
            "Initialization leaked into Advisor collection. "
            f"Found unexpected entries in Survey report: {', '.join(leaked)}"
        )
    if "refocus_shift_and_sum" not in survey_csv:
        raise RuntimeError("Expected refocus_shift_and_sum to appear in Survey report.")


def generate_roofline_report(project_dir):
    run_cmd(
        [
            "advisor",
            "--report=roofline",
            f"--project-dir={project_dir}",
            f"--report-output={project_dir}/roofline.html",
        ],
        source_setvars=True,
    )


def parse_args():
    parser = argparse.ArgumentParser(
        description="Collect a clean Intel Advisor CPU Roofline/MLR result."
    )
    parser.add_argument("target", help="CPP target name, e.g. opt11")
    parser.add_argument(
        "--dataset",
        default="../in/validation",
        help="Dataset path relative to cpp_refocus (default: ../in/validation)",
    )
    parser.add_argument(
        "--focus",
        type=float,
        default=6.7,
        help="Focus value passed to the target (default: 6.7)",
    )
    parser.add_argument(
        "--project-dir",
        default="intel-advisor-mlr",
        help="Advisor project directory relative to cpp_refocus",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    project_dir = Path(args.project_dir)
    full_project_dir = CPP_DIR / project_dir

    # Build the binary
    build_target(args.target)

    # Remove the intel advisor project tree
    shutil.rmtree(full_project_dir, ignore_errors=True)
    os.makedirs(full_project_dir, exist_ok=True)

    # We have to do the collection in two steps: Survey -> Trip Counts
    # because because otherwise we can't "exclude initialization"
    collect_survey(project_dir, args.target, args.dataset, args.focus)
    survey_csv = read_survey_csv(project_dir)
    ensure_kernel_only_survey(survey_csv)

    collect_tripcounts(project_dir, args.target, args.dataset, args.focus)
    generate_roofline_report(project_dir)

    roofline_path = full_project_dir / "roofline.html"
    print(f"\nAdvisor MLR result saved to {roofline_path}")


if __name__ == "__main__":
    main()
