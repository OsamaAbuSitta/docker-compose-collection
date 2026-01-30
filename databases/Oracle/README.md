# Oracle Database XE

Oracle Database Express Edition (XE) for local development.

## Quick Start

```bash
docker compose -f docker-compose.yaml up -d
```

## Service

| Service | Port | Notes |
| --- | --- | --- |
| Oracle XE | 9445 | Maps to Oracle listener port 1521 in the container. |

## Default Credentials

- **SID**: `XE`
- **Password**: `P@ssw0rd`

## Notes

- You may need to log in to the Oracle Container Registry before pulling the image.
