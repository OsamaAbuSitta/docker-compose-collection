# Prometheus

Prometheus for metrics collection and alerting.

## Quick Start

```bash
docker compose -f docker-compose.yaml up -d
```

## Service

| Service | Port | Notes |
| --- | --- | --- |
| Prometheus | 9090 | Web UI at http://localhost:9090 |

## Notes

- Update the host volume path in `docker-compose.yaml` if you are not running on Windows.
- Prometheus uses `/etc/prometheus/config/prometheus.yml` inside the container for configuration.
