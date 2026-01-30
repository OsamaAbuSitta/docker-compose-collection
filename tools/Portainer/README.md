# Portainer

Portainer provides a lightweight UI for managing Docker environments.

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **URL:** http://localhost:9000

## Notes

- Data is persisted to `./portainer-data`.
- Portainer connects to the local Docker socket mounted at `/var/run/docker.sock`.
