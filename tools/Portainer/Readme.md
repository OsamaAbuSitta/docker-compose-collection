# Portainer

Portainer provides a lightweight UI for managing Docker environments.

**Official Sites:**
- [Portainer](https://www.portainer.io/) | [Docker Hub](https://hub.docker.com/r/portainer/portainer-ce)

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **URL:** http://localhost:9000

## Notes

- Data is persisted to `./portainer-data`.
- Portainer connects to the local Docker socket mounted at `/var/run/docker.sock`.
