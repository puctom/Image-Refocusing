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


def is_stack_target(target):
    return target.startswith("stack_") or target.startswith("stack_from_")


def target_args(target, dataset, dataset_name, focus, focuses):
    if is_stack_target(target):
        output_dir = f"/tmp/roofline_{target}_{dataset_name}"
        stack_focuses = focuses if focuses is not None else [focus]
        return [f"./build/{target}", dataset, output_dir] + [str(f) for f in stack_focuses]
    return [f"./build/{target}", dataset, str(focus), "/tmp/out.png"]


def collect_survey(project_dir, target, target_cmd):
    cmd = [
        "advisor",
        "--collect=survey",
        f"--project-dir={project_dir}",
        "--search-dir",
        "src:r=.",
        "--",
    ] + target_cmd
    if not is_stack_target(target):
        cmd.insert(2, "--start-paused")
    run_cmd(
        cmd,
        source_setvars=True,
    )


def collect_tripcounts(project_dir, target, target_cmd):
    cmd = [
        "advisor",
        "--collect=tripcounts",
        "--flop",
        "--no-trip-counts",
        "--enable-cache-simulation",
        f"--project-dir={project_dir}",
        "--search-dir",
        "src:r=.",
        "--",
    ] + target_cmd
    if not is_stack_target(target):
        cmd.insert(5, "--start-paused")
    run_cmd(
        cmd,
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


def generate_roofline_report(project_dir, report_output):
    run_cmd(
        [
            "advisor",
            "--report=roofline",
            f"--project-dir={project_dir}",
            f"--report-output={report_output}",
        ],
        source_setvars=True,
    )


def discover_datasets(input_dir, exclude):
    """Return sorted dataset directory names found in input_dir, minus excludes.

    input_dir is interpreted relative to cpp_refocus (matching how dataset
    paths are handed to the target binary).
    """
    input_path = (CPP_DIR / input_dir).resolve()
    if not input_path.is_dir():
        raise RuntimeError(f"Input directory not found: {input_path}")

    excluded = set(exclude)
    return sorted(
        entry.name
        for entry in input_path.iterdir()
        if entry.is_dir() and entry.name not in excluded
    )


def parse_args():
    parser = argparse.ArgumentParser(
        description="Collect clean Intel Advisor CPU Roofline/MLR results for "
        "every dataset in the input directory across one or more targets."
    )
    parser.add_argument(
        "targets",
        nargs="+",
        help="One or more CPP target names, e.g. opt11 opt12. "
        "Each is processed in turn.",
    )
    parser.add_argument(
        "--input-dir",
        default="../in",
        help="Directory of datasets, relative to cpp_refocus (default: ../in). "
        "Each sub-directory is treated as one dataset.",
    )
    parser.add_argument(
        "--exclude",
        nargs="*",
        default=["validation"],
        help="Dataset directory names to skip (default: validation)",
    )
    parser.add_argument(
        "--focus",
        type=float,
        default=6.7,
        help="Focus value passed to the target (default: 6.7)",
    )
    parser.add_argument(
        "--focuses",
        type=float,
        nargs="+",
        default=None,
        help="Focus values passed to stack targets. Defaults to --focus.",
    )
    parser.add_argument(
        "--project-dir",
        default="intel-advisor-mlr",
        help="Advisor project directory relative to cpp_refocus",
    )
    parser.add_argument(
        "--output-dir",
        default="roofline_reports",
        help="Directory (relative to cpp_refocus) for the generated roofline "
        "HTML reports (default: roofline_reports)",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    project_dir = Path(args.project_dir)
    full_project_dir = CPP_DIR / project_dir
    output_dir = Path(args.output_dir)
    full_output_dir = CPP_DIR / output_dir
    os.makedirs(full_output_dir, exist_ok=True)

    datasets = discover_datasets(args.input_dir, args.exclude)
    if not datasets:
        print(
            f"No datasets found in {args.input_dir} "
            f"(excluded: {', '.join(args.exclude) or 'none'}). Nothing to do."
        )
        return

    print(f"Targets:  {', '.join(args.targets)}")
    print(f"Datasets: {', '.join(datasets)}")

    reports = []
    for target in args.targets:
        # Build the binary once per target; it is dataset-independent.
        build_target(target)

        for dataset_name in datasets:
            dataset = f"{args.input_dir}/{dataset_name}"
            target_cmd = target_args(
                target, dataset, dataset_name, args.focus, args.focuses
            )
            print(f"\n=== Roofline: target={target} dataset={dataset_name} ===")

            # Remove the intel advisor project tree for a clean collection.
            shutil.rmtree(full_project_dir, ignore_errors=True)
            os.makedirs(full_project_dir, exist_ok=True)

            # We have to do the collection in two steps: Survey -> Trip Counts
            # because otherwise we can't "exclude initialization"
            collect_survey(project_dir, target, target_cmd)
            survey_csv = read_survey_csv(project_dir)
            if not is_stack_target(target):
                ensure_kernel_only_survey(survey_csv)

            collect_tripcounts(project_dir, target, target_cmd)

            # Unique name per (target, dataset) so reports never overwrite.
            report_name = f"roofline_{target}_{dataset_name}.html"
            generate_roofline_report(project_dir, output_dir / report_name)

            report_path = full_output_dir / report_name
            reports.append(report_path)
            print(f"Saved roofline report to {report_path}")

    print("\nAll roofline reports:")
    for report_path in reports:
        print(f"  {report_path}")


if __name__ == "__main__":
    main()
