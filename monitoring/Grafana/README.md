# Grafana

Grafana provides dashboards and visualizations for metrics.

**Official Sites:**
- [Grafana](https://grafana.com/) | [Docker Hub](https://hub.docker.com/r/grafana/grafana)

## Quick start

```bash
docker compose -f grafana.yaml up -d
```

## Access

- **URL:** http://localhost:3000

## Notes

- Update the mounted data path in `grafana.yaml` to match your local Grafana data directory.
