#!/usr/bin/env python3
"""Build and compare interpreter, threaded interpreter and LLVM JIT."""
import argparse
import csv
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parents[1]
MODES = {
    "interpreter": {"NO_JIT": "ON", "THREADED_CODE": "OFF"},
    "threaded": {"NO_JIT": "ON", "THREADED_CODE": "ON"},
    "jit": {"NO_JIT": "OFF", "THREADED_CODE": "ON"},
}
CASES = {"fibonacci": 1819143227, "sum": 987459712, "array_sum": 708067456}


def logged(command, log, cwd=ROOT):
    with log.open("w") as stream:
        result = subprocess.run(command, cwd=cwd, stdout=stream, stderr=subprocess.STDOUT)
    if result.returncode:
        raise RuntimeError(f"Command failed: {' '.join(map(str, command))}\nSee {log}")


def build(mode, options, args):
    directory = args.build_dir / mode
    command = ["cmake", "-S", str(ROOT), "-B", str(directory), "-G", "Unix Makefiles"]
    command += [f"-D{key}={value}" for key, value in options.items()]
    # Reuse downloaded sources without changing the user's main build configuration.
    for dependency in ("googletest", "cli11", "elfio"):
        source = ROOT / "build/_deps" / f"{dependency}_fetchcontent-src"
        if source.is_dir():
            command.append(f"-DFETCHCONTENT_SOURCE_DIR_{dependency.upper()}_FETCHCONTENT={source}")
    logged(command, args.output / f"{mode}-configure.log")
    logged(["cmake", "--build", str(directory), "--target", "toy_vm", "-j", str(args.jobs)],
           args.output / f"{mode}-build.log")
    entries = json.loads((directory / "compile_commands.json").read_text())
    main = next(entry["command"] for entry in entries if entry["file"] == str(ROOT / "src/main.cpp"))
    if ("-DNO_JIT" in main) != (options["NO_JIT"] == "ON"):
        raise RuntimeError(f"{mode}: unexpected NO_JIT definition")
    if ("-DTHREADED_CODE" in main) != (options["THREADED_CODE"] == "ON"):
        raise RuntimeError(f"{mode}: unexpected THREADED_CODE definition")
    return directory / "bin/toy_vm", main


def execute(binary, elf, expected, args):
    start = time.perf_counter()
    result = subprocess.run([str(binary), "-f", str(elf), "-t", str(args.threshold)],
                            input="", capture_output=True, text=True, timeout=args.timeout)
    elapsed = time.perf_counter() - start
    if result.returncode or result.stderr or result.stdout.strip() != str(expected):
        raise RuntimeError(f"{elf.stem} / {binary}: exit={result.returncode}, "
                           f"expected={expected}, stdout={result.stdout!r}, stderr={result.stderr!r}")
    return elapsed


def plot(report, output):
    os.environ.setdefault("MPLCONFIGDIR", str(output / ".matplotlib"))
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    names = list(report)
    fig, ax = plt.subplots(figsize=(10, 5), layout="constrained")
    width = 0.25
    labels = {"interpreter": "Interpreter", "threaded": "Threaded interpreter", "jit": "LLVM JIT"}
    for index, mode in enumerate(MODES):
        values = [report[name][mode]["speedup"] for name in names]
        bars = ax.bar([x + (index - 1) * width for x in range(len(names))], values,
                      width, label=labels[mode])
        ax.bar_label(bars, labels=[f"{value:.2f}x" for value in values], padding=3)
    ax.axhline(1, color="gray", linewidth=1, linestyle="--")
    ax.set_xticks(range(len(names)), ["Fibonacci: 100M", "Sum: 100M", "Array: 100K x 1000"])
    ax.set_ylabel("Speedup relative to interpreter (higher is better)")
    ax.set_title("Toy ISA — median process time, including JIT compilation")
    ax.set_ylim(0, max(report[n][m]["speedup"] for n in names for m in MODES) * 1.25)
    ax.legend()
    fig.savefig(output / "speedup.png", dpi=180)
    fig.savefig(output / "speedup.svg")
    plt.close(fig)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--runs", type=int, default=7)
    parser.add_argument("--warmup", type=int, default=1)
    parser.add_argument("--jobs", type=int, default=4)
    parser.add_argument("--threshold", type=int, default=100)
    parser.add_argument("--timeout", type=float, default=60)
    parser.add_argument("--build-dir", type=Path, default=ROOT / "build/benchmarks")
    parser.add_argument("--output", type=Path, default=ROOT / "benchmarks/results")
    args = parser.parse_args()
    if args.runs < 1 or args.warmup < 0 or args.jobs < 1 or args.threshold < 0 or args.timeout <= 0:
        parser.error("runs, jobs and timeout must be positive; warmup and threshold nonnegative")
    args.build_dir = args.build_dir.resolve()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=True)
    # Fail before building if plotting dependencies are missing.
    os.environ.setdefault("MPLCONFIGDIR", str(args.output / ".matplotlib"))
    try:
        import matplotlib
    except ImportError:
        parser.error("matplotlib is required: python3 -m pip install matplotlib")
    binaries, commands = {}, {}
    for mode, options in MODES.items():
        print(f"Building {mode}...", flush=True)
        binaries[mode], commands[mode] = build(mode, options, args)
    elf_dir = args.output / "elf"
    elf_dir.mkdir(exist_ok=True)
    report = {}
    for name, expected in CASES.items():
        elf = elf_dir / f"{name}.elf"
        # The assembler can print an error and still exit zero: remove stale output.
        if elf.exists():
            elf.unlink()
        logged(["ruby", "asm.rb", str(ROOT / "benchmarks" / f"{name}.asm"), str(elf)],
               args.output / f"{name}-assemble.log", ROOT / "ruby-toy-asm")
        if not elf.is_file() or not elf.read_bytes().startswith(b"\x7fELF"):
            raise RuntimeError(f"Assembly failed: see {args.output / (name + '-assemble.log')}")
        print(f"Running {name}...", flush=True)
        for _ in range(args.warmup):
            for binary in binaries.values():
                execute(binary, elf, expected, args)
        samples = {mode: [] for mode in MODES}
        modes = list(MODES)
        for iteration in range(args.runs):
            # Rotate order to distribute effects of temperature and background work.
            offset = iteration % len(modes)
            for mode in modes[offset:] + modes[:offset]:
                samples[mode].append(execute(binaries[mode], elf, expected, args))
            print(f"  {iteration + 1}/{args.runs}", flush=True)
        baseline = statistics.median(samples["interpreter"])
        report[name] = {}
        for mode, values in samples.items():
            median = statistics.median(values)
            report[name][mode] = {"median_ms": median * 1000, "min_ms": min(values) * 1000,
                                  "speedup": baseline / median, "samples_seconds": values,
                                  "expected": expected}
            print(f"  {mode:12} {median * 1000:9.2f} ms  {baseline / median:.2f}x", flush=True)
        # Preserve completed measurements even if a later case fails.
        payload = {"platform": platform.platform(), "runs": args.runs, "warmup": args.warmup,
                   "threshold": args.threshold, "modes": MODES, "compile_commands": commands,
                   "timing": "Full process wall time; includes JIT compilation; excludes assembly/build",
                   "benchmarks": report}
        (args.output / "results.json").write_text(json.dumps(payload, indent=2) + "\n")
    with (args.output / "results.csv").open("w", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(["benchmark", "mode", "median_ms", "min_ms", "speedup_vs_interpreter"])
        for name, modes in report.items():
            for mode, values in modes.items():
                writer.writerow([name, mode, values["median_ms"], values["min_ms"], values["speedup"]])
    plot(report, args.output)
    print(f"Results and graphs: {args.output}", flush=True)


if __name__ == "__main__":
    main()
