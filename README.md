# charmed-kafka-snap

Charmed Kafka snap repository.

This snap is based on the kafka snap: https://git.launchpad.net/kafka-snap/

## Building

To build locally, use `snapcraft --debug`

## Using the snap

Install the snap (e.g. `sudo snap install ./kafka_3.3.2_amd64.snap --dangerous`
--devmode).

To run the snap, you will require a running Apache ZooKeeper service. You can use the following:

```bash
# installing zookeeper
sudo snap install charmed-zookeeper --channel 3/edge

# copying default config
sudo cp /snap/charmed-kafka/current/config/server.properties /var/snap/charmed-kafka/current/etc/kafka
sudo cp /snap/charmed-zookeeper/current/conf/zoo_sample.cfg /var/snap/charmed-zookeeper/current/etc/zookeeper/zoo.cfg

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

Logs should be available at `/var/snap/charmed-kafka/common/log`.

### Configuration

Place your custom kafka configuration in the snap data directory at `/var/snap/charmed-kafka/current/etc/kafka/server.properties`.

If you want to use custom log4j properties, place your custom log4j properties file at the snap data directory at `/var/snap/charmed-kafka/etc/kafka/log4j.properties`.
