# Windows Containers

Windows runs a Windows VM using the `dockurr/windows` image.

**Official Sites:**
- [Dockur Windows](https://github.com/dockur/windows) | [Docker Hub](https://hub.docker.com/r/dockurr/windows)

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **Web UI:** https://localhost:8006
- **RDP:** localhost:3389

## Notes

- The VM storage lives in `./data` and `./shared/user`.
