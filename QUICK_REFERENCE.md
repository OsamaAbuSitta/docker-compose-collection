# Quick Reference Guide

## Common Commands

### Starting Services

```bash
# Start service in detached mode
docker compose up -d

# Start with specific file
docker compose -f postgresql.yaml up -d

# Start and rebuild
docker compose up -d --build

# View startup logs
docker compose up
```

### Stopping Services

```bash
# Stop services
docker compose down

# Stop and remove volumes (⚠️ deletes data)
docker compose down -v

# Stop specific service
docker compose stop service-name
```

### Viewing Information

```bash
# List running containers
docker compose ps

# View logs
docker compose logs

# Follow logs in real-time
docker compose logs -f

# View logs for specific service
docker compose logs service-name

# View last 100 lines
docker compose logs --tail=100
```

### Managing Containers

```bash
# Restart service
docker compose restart service-name

# Execute command in container
docker exec -it container-name bash

# View container stats
docker stats

# Inspect container
docker inspect container-name
```

### Cleaning Up

```bash
# Remove stopped containers
docker container prune

# Remove unused images
docker image prune

# Remove unused volumes
docker volume prune

# Remove everything unused
docker system prune -a
```

## Port Reference

| Service | Port(s) | Protocol |
|---------|---------|----------|
| PostgreSQL | 5432 | TCP |
| pgAdmin | 8888 | HTTP |
| MySQL | 3306 | TCP |
| MS SQL Server | 1431 | TCP |
| MongoDB | 27017 | TCP |
| Redis | 6379 | TCP |
| Elasticsearch | 9200, 9300 | HTTP, TCP |
| Kafka | 9092 | TCP |
| Portainer | 9000 | HTTP |
| Grafana | 3000 | HTTP |
| Prometheus | 9090 | HTTP |
| SonarQube | 9000 | HTTP |
| Keycloak | 8080 | HTTP |

## Default Credentials Reference

⚠️ **Security Warning**: These are development credentials only!

### Databases

**PostgreSQL**
- User: `postgres`
- Password: `P@ss0rd123`

**MySQL**
- User: `root`
- Password: Check compose file

**MS SQL Server**
- User: `sa`
- Password: `P@ssw0rd`

**MongoDB**
- User: Check compose file
- Password: Check compose file

### Tools

**Portainer**
- Set on first login
- Reference: `P@ssw0rd@123`

**pgAdmin**
- Email: `postgres@domain.com`
- Password: `P@ss0rd123`

**Grafana**
- User: `admin`
- Password: Check compose file

## Troubleshooting Quick Fixes

### Port Already in Use

```bash
# Find process using port (Linux/Mac)
lsof -i :PORT

# Find process using port (Windows)
netstat -ano | findstr :PORT

# Change port in compose file
ports:
  - "NEW_PORT:CONTAINER_PORT"
```

### Container Won't Start

```bash
# Check logs
docker compose logs service-name

# Check container status
docker compose ps

# Remove and recreate
docker compose down
docker compose up -d
```

### Permission Denied

```bash
# Fix volume permissions (Linux/Mac)
sudo chown -R $USER:$USER ./volume-directory

# Run with sudo (not recommended)
sudo docker compose up -d
```

### Out of Disk Space

```bash
# Check disk usage
docker system df

# Clean up
docker system prune -a --volumes
```

### Cannot Connect to Service

1. Check container is running: `docker compose ps`
2. Check logs: `docker compose logs`
3. Verify port mapping: `docker port container-name`
4. Test connection: `telnet localhost PORT`
5. Check firewall settings

## Environment Variables

### Common Variables

```yaml
environment:
  # Database
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: password
  POSTGRES_DB: database_name
  
  # Timezone
  TZ: America/New_York
  
  # Memory
  JAVA_OPTS: "-Xmx2g -Xms512m"
```

### Using .env File

Create `.env` file:
```
DB_PASSWORD=mysecretpassword
DB_USER=admin
```

Reference in compose:
```yaml
environment:
  POSTGRES_PASSWORD: ${DB_PASSWORD}
  POSTGRES_USER: ${DB_USER}
```

## Volume Management

### Backup Volume

```bash
# Create backup
docker run --rm -v volume-name:/data -v $(pwd):/backup ubuntu tar czf /backup/backup.tar.gz /data

# Restore backup
docker run --rm -v volume-name:/data -v $(pwd):/backup ubuntu tar xzf /backup/backup.tar.gz -C /
```

### List Volumes

```bash
docker volume ls
```

### Inspect Volume

```bash
docker volume inspect volume-name
```

### Remove Volume

```bash
docker volume rm volume-name
```

## Network Management

### List Networks

```bash
docker network ls
```

### Inspect Network

```bash
docker network inspect network-name
```

### Connect Container to Network

```bash
docker network connect network-name container-name
```

## Health Checks

### Add Health Check to Compose

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 40s
```

### Check Container Health

```bash
docker inspect --format='{{.State.Health.Status}}' container-name
```