# Apache Kafka

Kafka is deployed with Zookeeper and Kafka UI.

**Official Sites:**
- [Apache Kafka](https://kafka.apache.org/) | [Docker Hub](https://hub.docker.com/r/confluentinc/cp-kafka)
- [Kafka UI](https://github.com/provectus/kafka-ui) | [Docker Hub](https://hub.docker.com/r/provectuslabs/kafka-ui)

## Quick start

```bash
docker compose -f kafka-with-ui.yaml up -d
```

## Access

- **Kafka UI:** http://localhost:8086

## Default credentials

- **Username:** root
- **Password:** P@ss0rd132

## Notes

- Kafka listens on `29093` for external connections.
