# Prometheus

Prometheus collects metrics and exposes the UI.

**Official Sites:**
- [Prometheus](https://prometheus.io/) | [Docker Hub](https://hub.docker.com/r/prom/prometheus)

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **URL:** http://localhost:9090

## Notes

- Update the mounted config path in `docker-compose.yaml` to match your local Prometheus configuration.
