# Grafana

Grafana for dashboards and metrics visualization.

## Quick Start

```bash
docker compose -f grafana.yaml up -d
```

## Service

| Service | Port | Notes |
| --- | --- | --- |
| Grafana | 3000 | Web UI at http://localhost:3000 |

## Default Credentials

- **Username**: `admin`
- **Password**: `admin` (you will be prompted to change it on first login)

## Notes

- Update the host volume path in `grafana.yaml` if you are not running on Windows.
