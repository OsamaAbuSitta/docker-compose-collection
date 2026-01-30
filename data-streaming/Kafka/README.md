# Apache Kafka with Kafka UI

This setup runs Apache Kafka with ZooKeeper and the Kafka UI web console.

## Quick Start

```bash
docker compose -f kafka-with-ui.yaml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| Kafka | 29093 | External listener for local clients. |
| ZooKeeper | 22182 | Internal ZooKeeper client port. |
| Kafka UI | 8086 | Web UI at http://localhost:8086 |

## Kafka UI Login

- **Username**: `root`
- **Password**: `P@ss0rd132`

## Connecting to Kafka

Use the external listener from your host machine:

```
Bootstrap servers: localhost:29093
```

## Notes

- The advertised listeners use `${DOCKER_HOST_IP:-127.0.0.1}`. Override `DOCKER_HOST_IP` if your host IP differs.
