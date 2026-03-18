# Apache Superset

A modern data exploration and visualization platform. Superset is fast, lightweight, intuitive, and loaded with options that make it easy for users of all skill sets to explore and visualize their data, from simple line charts to highly detailed geospatial charts.

**Official Sites:**
- [Apache Superset](https://superset.apache.org/) | [Docker Hub](https://hub.docker.com/r/apache/superset)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially SECRET_KEY and admin password)

# Start the service
docker compose -f superset.yaml up -d
```

## Services

### Superset Application
- **URL**: http://localhost:8088
- **Container**: `superset_app`
- **Username**: `admin` (configurable via ADMIN_USERNAME)
- **Password**: `P@ss0rd123` (configurable via ADMIN_PASSWORD)

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `superset_db`
- **Database**: `superset`
- **Username**: `superset`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `superset_redis`

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Generate a secure SECRET_KEY (minimum 42 characters)
   - Set admin username and password
2. Start the services with `docker compose -f superset.yaml up -d`
3. Wait for initialization (first startup takes 2-3 minutes)
4. Navigate to http://localhost:8088
5. Log in with your admin credentials
6. Explore the example dashboards (if SUPERSET_LOAD_EXAMPLES=yes)

## Configuration

### Environment Variables (.env)

- `SUPERSET_PORT` - Web interface port (default: 8088)
- `SECRET_KEY` - Application secret key (minimum 42 characters, change for production)
- `ADMIN_USERNAME` - Initial admin username (default: admin)
- `ADMIN_PASSWORD` - Initial admin password (change for production)
- `ADMIN_EMAIL` - Admin email address
- `SUPERSET_LOAD_EXAMPLES` - Load example dashboards (yes/no)
- `DATABASE_HOST` - Database hostname (use container name)
- `DATABASE_DB` - Database name
- `DATABASE_USER` - Database username
- `DATABASE_PASSWORD` - Database password (change for production)
- `REDIS_HOST` - Redis hostname (use container name)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Generate Secure Secret Key

```bash
# Generate a secure secret key (minimum 42 characters)
openssl rand -base64 42
```

## Connecting to Databases

### From Superset UI

1. Click "Settings" → "Database Connections"
2. Click "+ Database"
3. Select your database type or use "Other" for custom connections
4. Enter connection details:
   - **Display Name**: Friendly name for the connection
   - **SQLAlchemy URI**: Connection string

### Example Connection Strings

**PostgreSQL**:
```
postgresql://username:password@hostname:5432/database
```

**MySQL**:
```
mysql://username:password@hostname:3306/database
```

**SQLite**:
```
sqlite:////path/to/database.db
```

**For Docker containers**, use container names as hostnames:
```
postgresql://myuser:mypass@postgres_container:5432/mydb
```

## Volumes

- `superset-data` - Application data, charts, and dashboards
- `superset-db-data` - PostgreSQL database files
- `superset-redis-data` - Redis cache data

## Common Tasks

### Create a Dashboard

1. Navigate to "Dashboards" in the main menu
2. Click "+ Dashboard"
3. Add charts to the dashboard
4. Arrange and resize charts
5. Save and publish

### Create a Chart

1. Click "Charts" → "+ Chart"
2. Select your dataset
3. Choose a visualization type
4. Configure the chart using the visual editor
5. Save the chart

### Add a Dataset

1. Click "Datasets" → "+ Dataset"
2. Select your database connection
3. Choose a table or write a SQL query
4. Configure columns and metrics
5. Save the dataset

### Backup Superset Data

```bash
# Backup the PostgreSQL database
docker exec superset_db pg_dump -U superset superset > superset_backup.sql

# Backup application data
docker run --rm -v superset-data:/data -v $(pwd):/backup alpine tar czf /backup/superset-data.tar.gz -C /data .
```

### Restore Superset Data

```bash
# Restore the PostgreSQL database
cat superset_backup.sql | docker exec -i superset_db psql -U superset superset

# Restore application data
docker run --rm -v superset-data:/data -v $(pwd):/backup alpine tar xzf /backup/superset-data.tar.gz -C /data
```

### Create Additional Admin Users

```bash
docker exec -it superset_app superset fab create-admin \
  --username newadmin \
  --firstname Admin \
  --lastname User \
  --email admin@example.com \
  --password SecurePassword123
```

## Features

- **Rich Visualizations**: 40+ chart types including maps, time series, and custom visualizations
- **SQL Lab**: Interactive SQL editor with query history and results export
- **Semantic Layer**: Define metrics and dimensions once, use everywhere
- **Dashboard Builder**: Drag-and-drop interface for creating dashboards
- **Security**: Row-level security and role-based access control
- **Caching**: Redis-based caching for improved performance
- **Alerts & Reports**: Schedule email reports and set up alerts
- **API Access**: REST API for programmatic access
- **Database Support**: PostgreSQL, MySQL, SQLite, BigQuery, Snowflake, Redshift, and 30+ more

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits or restarts repeatedly
- **Solution**: Check logs with `docker logs superset_app`. Ensure SECRET_KEY is at least 42 characters.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Verify DATABASE_HOST matches the database container name. Ensure database is ready before Superset starts.

### Cannot Log In

- **Symptoms**: Invalid credentials error
- **Solution**: 
  - Verify ADMIN_USERNAME and ADMIN_PASSWORD in .env file
  - Check logs for admin user creation errors
  - Recreate admin user using the command above

### Charts Not Loading

- **Symptoms**: Charts show loading spinner indefinitely
- **Solution**: 
  - Check Redis is running: `docker ps | grep superset_redis`
  - Verify database connection in Superset UI
  - Check browser console for errors

### Slow Performance

- **Symptoms**: Queries and dashboards load slowly
- **Solution**: 
  - Enable query caching in chart settings
  - Increase Redis memory if needed
  - Add database indexes on frequently queried columns
  - Increase worker count in docker-compose.yaml

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure SECRET_KEY (minimum 42 characters)
- Change all default passwords
- Use HTTPS with a reverse proxy (nginx, Caddy)
- Enable SSL for database connections
- Restrict access with firewall rules
- Regular backups are essential
- Configure proper authentication (LDAP, OAuth, etc.)
- Review and configure row-level security

## Resources

- [Official Documentation](https://superset.apache.org/docs/intro)
- [GitHub Repository](https://github.com/apache/superset)
- [Docker Hub](https://hub.docker.com/r/apache/superset)
- [Community Slack](https://superset.apache.org/community)
