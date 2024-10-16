# Charmed Kafka snap repository.

[![Snapcraft Badge](https://snapcraft.io/charmed-kafka/badge.svg)](https://snapcraft.io/charmed-kafka)
[![Release](https://github.com/canonical/charmed-kafka-snap/actions/workflows/publish.yaml/badge.svg)](https://github.com/canonical/charmed-kafka-snap/actions/workflows/publish.yaml)

## Building

To build locally, use `snapcraft --debug`

## Using the snap

Install the snap (e.g. `sudo snap install ./charmed-kafka_3.6.0_amd64.snap --dangerous --devmode`
).

To run the snap, you will require a running Apache ZooKeeper service. You can use the following:

```bash
# installing zookeeper
sudo snap install charmed-zookeeper --channel 3/edge

# copying default config
sudo cp /snap/charmed-kafka/current/opt/kafka/config/server.properties /var/snap/charmed-kafka/current/etc/kafka/server.properties
sudo cp /snap/charmed-zookeeper/current/opt/zookeeper/conf/zoo_sample.cfg /var/snap/charmed-zookeeper/current/etc/zookeeper/zoo.cfg

# starting services
sudo snap start charmed-zookeeper.daemon
sleep 5
sudo snap start charmed-kafka.daemon
```

### Hello, Kafka

As per https://kafka.apache.org/quickstart run:

```
charmed-kafka.topics --create --topic quickstart-events --bootstrap-server localhost:9092
charmed-kafka.topics --describe --topic quickstart-events --bootstrap-server localhost:9092
charmed-kafka.console-producer --topic quickstart-events --bootstrap-server localhost:9092
```

Write any data to the topic, then halt with `ctrl-C`.

```
charmed-kafka.console-consumer --topic quickstart-events --from-beginning --bootstrap-server localhost:9092
```

Logs should be available at `/var/snap/charmed-kafka/common/var/log/kafka`.

### Configuration

Place your custom kafka configuration in the snap data directory at `/var/snap/charmed-kafka/current/etc/kafka/server.properties`.

If you want to use custom log4j properties, place your custom log4j properties file at the snap data directory at `/var/snap/charmed-kafka/etc/kafka/log4j.properties`.

### Cruise Control

To get started with Cruise Control, on a local system already running the Kafka and ZooKeeper services, you can use the following:

```bash
# copying necessary configuration files
sudo cp /snap/charmed-kafka/current/opt/cruise-control/config/cruisecontrol.properties /var/snap/charmed-kafka/current/etc/cruise-control
sudo cp /snap/charmed-kafka/current/opt/cruise-control/config/capacityJBOD.json /var/snap/charmed-kafka/current/etc/cruise-control

# overriding defaults
sudo sed -i -e 's/sample.store.topic.replication.factor=2/sample.store.topic.replication.factor=1/g' /var/snap/charmed-kafka/current/etc/cruise-control/cruisecontrol.properties
sudo sed -i -e 's|capacity.config.file=config/capacityJBOD.json|capacity.config.file=/var/snap/charmed-kafka/current/etc/cruise-control/capacityJBOD.json|g' /var/snap/charmed-kafka/current/etc/cruise-control/cruisecontrol.properties

# starting services
sudo snap start charmed-kafka.cruise-control
```

Then, after a little time, you can interact with the API webserver using the following:

```bash
curl http://localhost:9090/kafkacruisecontrol/state
```
