"""Helpers and utility functions."""

import os
import sys

from pydantic import ValidationError

from .core import Config, ConsumerGroupState


def parse_consumer_groups_output(raw: str) -> list[ConsumerGroupState]:
    """Parse the `charmed-kafka.consumer-groups` command output."""
    lines = raw.split("\n")
    headers = []
    parsed = []
    for line in lines:
        if not line.strip():
            continue

        if line.lstrip().startswith("GROUP"):
            headers = line.split()
            continue

        parts = line.lstrip().split()
        if headers and len(parts) == len(headers):
            parsed.append(ConsumerGroupState.from_dict(dict(zip(headers, parts))))
    return parsed


def validate_config() -> Config:
    """Populate config from CLI and environment and ensure it is valid."""
    try:
        _config = Config()  # pyright: ignore[reportCallIssue]
    except ValidationError as e:
        print("Faulty configuration detected:")
        for error in e.errors():
            print(f"- {error['msg']}: {error['loc'][0]}")
        sys.exit(1)

    if not os.path.exists(_config.CONFIG_FILE):
        print(f"Provided config file does not exist: {_config.CONFIG_FILE}")
        sys.exit(2)

    try:
        with open(_config.CONFIG_FILE) as f:
            _ = f.read()
    except PermissionError:
        print("Can not access config file, permission denied.")
        sys.exit(4)

    return _config
