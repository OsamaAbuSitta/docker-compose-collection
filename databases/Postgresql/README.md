# PostgreSQL with pgAdmin

PostgreSQL is a powerful, open-source object-relational database system with a strong reputation for reliability, feature robustness, and performance.

## Quick Start

```bash
docker compose -f postgresql.yaml up -d
```

## Services

### PostgreSQL Database
- **Port**: 5432
- **Container**: `postgresql-db_container`
- **Username**: `postgres`
- **Password**: `P@ss0rd123`

### pgAdmin 4
- **URL**: http://localhost:8888
- **Container**: `pgadmin4_container`
- **Email**: `postgres@domain.com`
- **Password**: `P@ss0rd123`

## Connecting to PostgreSQL

### From Host Machine

```bash
psql -h localhost -p 5432 -U postgres
```

### From pgAdmin

1. Open http://localhost:8888
2. Login with credentials above
3. Right-click "Servers" → "Register" → "Server"
4. General tab: Name = "Local PostgreSQL"
5. Connection tab:
   - Host: `postgresql-db` (container name) or `host.docker.internal` (from host)
   - Port: `5432`
   - Username: `postgres`
   - Password: `P@ss0rd123`

### From Application

```
Host: localhost
Port: 5432
Database: postgres
Username: postgres
Password: P@ss0rd123
```

## Volumes

- `pgdata` - PostgreSQL data directory
- `pgadmin-data` - pgAdmin configuration and settings

## Common Tasks

### Create a New Database

```sql
CREATE DATABASE myapp;
```

### Backup Database

```bash
docker exec postgresql-db_container pg_dump -U postgres myapp > backup.sql
```

### Restore Database

```bash
docker exec -i postgresql-db_container psql -U postgres myapp < backup.sql
```

### Access PostgreSQL Shell

```bash
docker exec -it postgresql-db_container psql -U postgres
```

## Configuration

### Change Password

Edit the `POSTGRES_PASSWORD` environment variable in the compose file.

### Custom Configuration

Mount a custom `postgresql.conf`:

```yaml
volumes:
  - ./postgresql.conf:/etc/postgresql/postgresql.conf
  - pgdata:/var/lib/postgresql/data
command: postgres -c config_file=/etc/postgresql/postgresql.conf
```

## Troubleshooting

### Connection Refused

- Ensure container is running: `docker compose ps`
- Check logs: `docker compose logs postgresql-db`
- Verify port is not in use: `netstat -an | grep 5432`

### pgAdmin Can't Connect

- Use `postgresql-db` as hostname (container name)
- Or use `host.docker.internal` to connect to host machine

### Permission Denied

- Check volume permissions
- Ensure PostgreSQL user owns data directory

## Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [pgAdmin Documentation](https://www.pgadmin.org/docs/)
- [PostgreSQL Docker Hub](https://hub.docker.com/_/postgres)
