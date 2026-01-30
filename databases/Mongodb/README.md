# MongoDB with Mongo Express

MongoDB with a Mongo Express web UI for quick administration.

## Quick Start

```bash
docker compose -f docker-compose.yaml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| MongoDB | 27017 | Database port. |
| Mongo Express | 8081 | Web UI at http://localhost:8081 |

## Default Credentials

**MongoDB**
- **Username**: `root`
- **Password**: `test1234`
- **Database**: `admin`

**Mongo Express**
- **Username**: `admin`
- **Password**: `admin`
