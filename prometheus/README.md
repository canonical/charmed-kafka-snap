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
  --cycle float         Metric extraction cycle in seconds (default: 15.0)
```

## Sample exporter results:

```text
# HELP python_gc_objects_collected_total Objects collected during gc
# TYPE python_gc_objects_collected_total counter
python_gc_objects_collected_total{generation="0"} 376.0
python_gc_objects_collected_total{generation="1"} 110.0
python_gc_objects_collected_total{generation="2"} 0.0
# HELP python_gc_objects_uncollectable_total Uncollectable objects found during GC
# TYPE python_gc_objects_uncollectable_total counter
python_gc_objects_uncollectable_total{generation="0"} 0.0
python_gc_objects_uncollectable_total{generation="1"} 0.0
python_gc_objects_uncollectable_total{generation="2"} 0.0
# HELP python_gc_collections_total Number of times this generation was collected
# TYPE python_gc_collections_total counter
python_gc_collections_total{generation="0"} 70.0
python_gc_collections_total{generation="1"} 6.0
python_gc_collections_total{generation="2"} 0.0
# HELP python_info Python platform information
# TYPE python_info gauge
python_info{implementation="CPython",major="3",minor="12",patchlevel="11",version="3.12.11"} 1.0
# HELP process_virtual_memory_bytes Virtual memory size in bytes.
# TYPE process_virtual_memory_bytes gauge
process_virtual_memory_bytes 2.2065152e+08
# HELP process_resident_memory_bytes Resident memory size in bytes.
# TYPE process_resident_memory_bytes gauge
process_resident_memory_bytes 3.7126144e+07
# HELP process_start_time_seconds Start time of the process since unix epoch in seconds.
# TYPE process_start_time_seconds gauge
process_start_time_seconds 1.77736584651e+09
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 0.2
# HELP process_open_fds Number of open file descriptors.
# TYPE process_open_fds gauge
process_open_fds 7.0
# HELP process_max_fds Maximum number of open file descriptors.
# TYPE process_max_fds gauge
process_max_fds 1024.0
# HELP kafka_consumer_lags Apache Kafka consumer lags
# TYPE kafka_consumer_lags gauge
kafka_consumer_lags{group="cg1",partition="0",topic="t1"} 351.0
kafka_consumer_lags{group="cg1",partition="1",topic="t1"} 229.0
kafka_consumer_lags{group="cg1",partition="2",topic="t1"} 320.0
kafka_consumer_lags{group="cg2",partition="0",topic="t1"} 0.0
kafka_consumer_lags{group="cg2",partition="1",topic="t1"} 0.0
kafka_consumer_lags{group="cg2",partition="2",topic="t1"} 0.0
kafka_consumer_lags{group="long-john-silver",partition="0",topic="t1"} 154.0
kafka_consumer_lags{group="long-john-silver",partition="1",topic="t1"} 180.0
kafka_consumer_lags{group="long-john-silver",partition="2",topic="t1"} 0.0
kafka_consumer_lags{group="iman",partition="0",topic="t1"} 0.0
kafka_consumer_lags{group="iman",partition="1",topic="t1"} 0.0
kafka_consumer_lags{group="iman",partition="2",topic="t1"} 0.0
```
