# Custom Prometheus Exporter for Charmed Apache Kafka

This utility will periodically produce consumer lag metrics from `charmed-kafka.consumer-groups` command output.

## Sample usage:

```bash
sudo python3 main.py --bootstrap-server host1:9092,host2:9092 --config-file /path/to/config
```

Full list of CLI options are available by passing `-h` or `--help` flags.

```bash
usage: main.py [-h] [--port int] [--config-file str] [--bootstrap-server str] [--cycle float]

Application config model.

options:
  -h, --help            show this help message and exit
  --port int            Prometheus exporter port (default: 9110)
  --config-file str     The client configuration file to use for Kafka bin commands (default: /var/snap/charmed-kafka/current/etc/kafka/client.properties)
  --bootstrap-server str
                        Comma-separated Kafka bootstrap servers list (required)
  --cycle float         Metric extraction cycle in seconds (default: 60.0)
  --substrate {vm,k8s}  Workload substrate (default: vm)
```

## Sample exporter results:

```text
# HELP python_gc_objects_collected_total Objects collected during gc
# TYPE python_gc_objects_collected_total counter
python_gc_objects_collected_total{generation="0"} 413.0
python_gc_objects_collected_total{generation="1"} 7.0
python_gc_objects_collected_total{generation="2"} 0.0
# HELP python_gc_objects_uncollectable_total Uncollectable objects found during GC
# TYPE python_gc_objects_uncollectable_total counter
python_gc_objects_uncollectable_total{generation="0"} 0.0
python_gc_objects_uncollectable_total{generation="1"} 0.0
python_gc_objects_uncollectable_total{generation="2"} 0.0
# HELP python_gc_collections_total Number of times this generation was collected
# TYPE python_gc_collections_total counter
python_gc_collections_total{generation="0"} 82.0
python_gc_collections_total{generation="1"} 7.0
python_gc_collections_total{generation="2"} 0.0
# HELP python_info Python platform information
# TYPE python_info gauge
python_info{implementation="CPython",major="3",minor="10",patchlevel="12",version="3.10.12"} 1.0
# HELP process_virtual_memory_bytes Virtual memory size in bytes.
# TYPE process_virtual_memory_bytes gauge
process_virtual_memory_bytes 2.10878464e+08
# HELP process_resident_memory_bytes Resident memory size in bytes.
# TYPE process_resident_memory_bytes gauge
process_resident_memory_bytes 3.4246656e+07
# HELP process_start_time_seconds Start time of the process since unix epoch in seconds.
# TYPE process_start_time_seconds gauge
process_start_time_seconds 1.77916835186e+09
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 0.94
# HELP process_open_fds Number of open file descriptors.
# TYPE process_open_fds gauge
process_open_fds 6.0
# HELP process_max_fds Maximum number of open file descriptors.
# TYPE process_max_fds gauge
process_max_fds 65536.0
# HELP kafka_consumer_offset_lag_total Apache Kafka consumer lag
# TYPE kafka_consumer_offset_lag_total gauge
kafka_consumer_offset_lag_total{group="laggy",partition="0",topic="test"} 544.0
kafka_consumer_offset_lag_total{group="speedy",partition="0",topic="test"} 0.0
# HELP kafka_consumer_offset_current Apache Kafka consumer current offset
# TYPE kafka_consumer_offset_current gauge
kafka_consumer_offset_current{group="laggy",partition="0",topic="test"} 456.0
kafka_consumer_offset_current{group="speedy",partition="0",topic="test"} 1000.0
# HELP kafka_consumer_offset_log_end Apache Kafka consumer log end offset
# TYPE kafka_consumer_offset_log_end gauge
kafka_consumer_offset_log_end{group="laggy",partition="0",topic="test"} 1000.0
kafka_consumer_offset_log_end{group="speedy",partition="0",topic="test"} 1000.0
```
