# Windows Containers

Run a Windows VM/container using the `dockurr/windows` image.

## Quick Start

```bash
docker compose -f docker-compose.yaml up -d
```

## Service

| Service | Port | Notes |
| --- | --- | --- |
| Windows VM | 8006 | Web UI (noVNC). |
| Windows VM | 3389 | RDP (TCP/UDP). |

## Notes

- Requires KVM support (`/dev/kvm`) on the host.
- Adjust CPU, RAM, and disk size via environment variables in the compose file.
