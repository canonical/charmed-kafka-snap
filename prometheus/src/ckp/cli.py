"""CLI utilities."""

import os
import subprocess

from .core import Constants


def execute(cmd, cwd: str | None = None, timeout: float = 10.0, env=None) -> str:
    """Execute a command using shell and raise on error."""
    return subprocess.check_output(
        cmd,
        shell=True,
        universal_newlines=True,
        stderr=subprocess.PIPE,
        cwd=cwd,
        env=env,
        timeout=timeout,
    )


def _run_bin_command_using_snap_app(
    bin_keyword: str, bin_args: list[str], opts: list[str] | None = None
) -> str:
    """Execute a Kafka bin command using charmed-kafka apps."""
    if opts is None:
        opts = []
    opts_str = " ".join(opts)
    bin_str = " ".join(bin_args)
    command = f"{opts_str} {Constants.SNAP}.{bin_keyword} {bin_str}"
    return execute(command)


def _run_bin_command_in_snap(
    bin_keyword: str, bin_args: list[str], opts: list[str] | None = None
) -> str:
    """Execute a Kafka bin command inside snap."""
    if opts is None:
        opts = []
    opts_str = " ".join(opts)
    bin_str = " ".join(bin_args)
    snap = os.environ.get("SNAP", "")
    command = f"{opts_str} {snap}/opt/kafka/bin/bin-wrapper.bash {bin_str}"
    return execute(command, env=os.environ | {"bin_script": f"kafka-{bin_keyword}.sh"})


def run_bin_command(bin_keyword: str, bin_args: list[str], opts: list[str] | None = None) -> str:
    """Execute a Kafka bin command."""
    if os.environ.get("SNAP"):
        return _run_bin_command_in_snap(bin_keyword, bin_args, opts=opts)

    return _run_bin_command_using_snap_app(bin_keyword, bin_args, opts=opts)
