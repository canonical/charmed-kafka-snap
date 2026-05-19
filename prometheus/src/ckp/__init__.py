"""Main module."""

import logging
import time

from prometheus_client import start_http_server

from .cli import run_bin_command
from .core import Config, Metrics
from .utils import parse_consumer_groups_output, validate_config

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("charmed-kafka-prom")


def iterate(config: Config):
    """Main metric extraction iteration."""
    raw = run_bin_command(
        "consumer-groups",
        [
            "--bootstrap-server",
            config.BOOTSTRAP_SERVER,
            "--command-config",
            config.CONFIG_FILE,
            "--all-groups",
            "--all-topics",
            "--describe",
        ],
    )
    parsed = parse_consumer_groups_output(raw)
    logger.debug(parsed)
    for item in parsed:
        Metrics.CONSUMER_LAG.labels(item.group, item.topic, item.partition).set(item.lag)
        Metrics.CONSUMER_CURRENT_OFFSET.labels(item.group, item.topic, item.partition).set(
            item.current_offset
        )
        Metrics.CONSUMER_LOG_END_OFFSET.labels(item.group, item.topic, item.partition).set(
            item.log_end_offset
        )


def main():
    """Main entrypoint."""
    config = validate_config()
    start_http_server(config.PORT)
    while 1:
        t0 = time.perf_counter()
        try:
            iterate(config=config)
        except Exception as e:
            extended_msg = f"{getattr(e, 'stdout', '')} {getattr(e, 'stderr', '')}"
            logger.error(f"Metric extraction failed: {e} {extended_msg}")
        finally:
            took = time.perf_counter() - t0
            logger.info(f"Metrics extraction finished in {took} seconds")

        _sleep = max(config.CYCLE - took, 0.1)
        time.sleep(_sleep)
