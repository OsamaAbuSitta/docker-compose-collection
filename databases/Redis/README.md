# Redis with Redis Commander

Redis with the Redis Commander web UI for browsing keys.

## Quick Start

```bash
docker compose -f Redis.yaml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| Redis | 6379 | Redis server. |
| Redis Commander | 8081 | Web UI at http://localhost:8081 |

## Default Credentials

**Redis**
- **Password**: `P@ssw0rd123`

**Redis Commander**
- **Username**: `root`
- **Password**: `root`
