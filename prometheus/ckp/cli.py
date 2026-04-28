"""CLI utilities."""

import subprocess

from .core import Constants


def execute(cmd, cwd: str | None = None, timeout: float = 10.0) -> str:
    """Execute a command using shell and raise on error."""
    return subprocess.check_output(
        cmd,
        shell=True,
        universal_newlines=True,
        stderr=subprocess.PIPE,
        cwd=cwd,
        timeout=timeout,
    )


def run_bin_command(bin_keyword: str, bin_args: list[str], opts: list[str] | None = None) -> str:
    """Execute a Kafka bin command."""
    if opts is None:
        opts = []
    opts_str = " ".join(opts)
    bin_str = " ".join(bin_args)
    command = f"{opts_str} {Constants.SNAP}.{bin_keyword} {bin_str}"
    return execute(command)
