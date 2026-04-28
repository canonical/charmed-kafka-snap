"""Main module."""

import logging
import time

from prometheus_client import start_http_server

from ckp.cli import run_bin_command
from ckp.core import Config, Metrics
from ckp.utils import parse_consumer_groups_output, validate_config

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("charmed-kafka-prom")


def loop(config: Config):
    """Main metric extraction loop."""
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
    logger.info(parsed)
    for item in parsed:
        Metrics.CONSUMER_LAG.labels(item.group, item.topic, item.partition).set(item.lag)


if __name__ == "__main__":
    # if not snap.ensure(SNAP, snap.SnapState.Present.value):
    #     print(f"{SNAP} should be present.")
    #     sys.exit(1)

    config = validate_config()
    start_http_server(config.PORT)
    while 1:
        t0 = time.perf_counter()
        try:
            loop(config=config)
        except Exception as e:
            logger.error(f"Metric extraction failed: {e}")
        finally:
            took = time.perf_counter() - t0
            logger.info(f"Metrics extraction loop finished in {took} seconds")

        _sleep = max(config.CYCLE - took, 0.1)
        time.sleep(_sleep)
