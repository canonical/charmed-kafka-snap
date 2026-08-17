"""Core models and data classes."""

import typing
from dataclasses import dataclass

from prometheus_client import Gauge
from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict

Substrates = typing.Literal["vm", "k8s"]


class Constants:
    """Constants definition."""

    SNAP = "charmed-kafka"
    CONF_DIR = "/var/snap/charmed-kafka/current/etc/kafka"


class Metrics:
    """Prometheus metrics definition."""

    CONSUMER_LAG = Gauge(
        "kafka_consumer_offset_lag_total",
        "Apache Kafka consumer lag",
        labelnames=["group", "topic", "partition"],
    )
    CONSUMER_CURRENT_OFFSET = Gauge(
        "kafka_consumer_offset_current",
        "Apache Kafka consumer current offset",
        labelnames=["group", "topic", "partition"],
    )
    CONSUMER_LOG_END_OFFSET = Gauge(
        "kafka_consumer_offset_log_end",
        "Apache Kafka consumer log end offset",
        labelnames=["group", "topic", "partition"],
    )


@dataclass
class ConsumerGroupState:
    """Data model for consumer group state."""

    group: str
    topic: str
    partition: int
    current_offset: int
    log_end_offset: int
    lag: int

    @classmethod
    def from_dict(cls, dict_: dict):
        """Factory method from a given dict."""
        return cls(
            group=dict_["GROUP"],
            topic=dict_["TOPIC"],
            partition=int(dict_["PARTITION"]),
            current_offset=int(dict_["CURRENT-OFFSET"]),
            log_end_offset=int(dict_["LOG-END-OFFSET"]),
            lag=int(dict_["LAG"]),
        )


class Config(BaseSettings):
    """Application config model."""

    PORT: int = Field(description="Prometheus exporter port", default=9110)
    CONFIG_FILE: str = Field(
        description="The client configuration file to use for Kafka bin commands",
        default="/var/snap/charmed-kafka/current/etc/kafka/client.properties",
    )
    BOOTSTRAP_SERVER: str = Field(description="Comma-separated Kafka bootstrap servers list")
    CYCLE: float = Field(description="Metric extraction cycle in seconds", default=60.0)
    SUBSTRATE: Substrates = Field(description="Workload substrate", default="vm")

    model_config = SettingsConfigDict(
        cli_parse_args=True,
        cli_kebab_case=True,
        env_file="/etc/environment",
        extra="ignore",
    )
