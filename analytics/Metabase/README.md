# Metabase

An open-source business intelligence tool that lets you ask questions about your data and displays answers in formats that make sense, whether that's a bar chart or a detailed table. Metabase makes it easy for anyone in your organization to learn from data.

**Official Sites:**
- [Metabase](https://www.metabase.com/) | [Docker Hub](https://hub.docker.com/r/metabase/metabase)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f metabase.yaml up -d
```

## Services

### Metabase Application
- **URL**: http://localhost:3000
- **Container**: `metabase_app`
- **Note**: Create your admin account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `metabase_db`
- **Database**: `metabase`
- **Username**: `metabase`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure if needed
2. Start the services with `docker compose -f metabase.yaml up -d`
3. Wait for Metabase to initialize (first startup takes 1-2 minutes)
4. Navigate to http://localhost:3000
5. Complete the setup wizard:
   - Create your admin account
   - Add your first database connection
   - Set up your organization details

## Configuration

### Environment Variables (.env)

- `METABASE_PORT` - Web interface port (default: 3000)
- `MB_DB_HOST` - Database hostname (use container name)
- `MB_DB_DBNAME` - Database name
- `MB_DB_USER` - Database username
- `MB_DB_PASS` - Database password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Metabase supports many environment variables for advanced configuration. See the [official documentation](https://www.metabase.com/docs/latest/operations-guide/environment-variables) for all available options.

## Connecting to Databases

### From Metabase UI

1. Click "Settings" (gear icon) → "Admin" → "Databases"
2. Click "Add database"
3. Select your database type (PostgreSQL, MySQL, MongoDB, etc.)
4. Enter connection details:
   - **Host**: Use container name if database is in Docker
   - **Port**: Database port
   - **Database name**: Your database name
   - **Username/Password**: Database credentials

### Example: Connect to PostgreSQL in Docker

```yaml
Host: postgres_container
Port: 5432
Database: myapp
Username: myuser
Password: mypassword
```

## Volumes

- `metabase-data` - Application data and uploaded files
- `metabase-db-data` - PostgreSQL database files

## Common Tasks

### Create a Dashboard

1. Navigate to "Dashboards" in the main menu
2. Click "New dashboard"
3. Add questions (queries) to the dashboard
4. Arrange and resize cards as needed
5. Save and share with your team

### Create a Question (Query)

1. Click "New" → "Question"
2. Select your database and table
3. Use the visual query builder or write SQL
4. Visualize results as a chart or table
5. Save the question

### Backup Metabase Data

```bash
# Backup the PostgreSQL database
docker exec metabase_db pg_dump -U metabase metabase > metabase_backup.sql

# Backup application data
docker run --rm -v metabase-data:/data -v $(pwd):/backup alpine tar czf /backup/metabase-data.tar.gz -C /data .
```

### Restore Metabase Data

```bash
# Restore the PostgreSQL database
cat metabase_backup.sql | docker exec -i metabase_db psql -U metabase metabase

# Restore application data
docker run --rm -v metabase-data:/data -v $(pwd):/backup alpine tar xzf /backup/metabase-data.tar.gz -C /data
```

### Schedule Email Reports

1. Create or open a question/dashboard
2. Click the sharing icon
3. Select "Email it"
4. Configure recipients and schedule
5. Save the subscription

## Features

- **Visual Query Builder**: Build queries without writing SQL
- **SQL Editor**: Write custom SQL queries with autocomplete
- **Interactive Dashboards**: Create and share interactive dashboards
- **Automated Reports**: Schedule email reports and alerts
- **Data Visualization**: 15+ chart types including line, bar, pie, maps
- **User Management**: Role-based access control
- **Database Support**: PostgreSQL, MySQL, MongoDB, BigQuery, Snowflake, and 20+ more
- **Embedding**: Embed charts and dashboards in your applications
- **API Access**: REST API for programmatic access

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits or restarts repeatedly
- **Solution**: Check logs with `docker logs metabase_app`. Ensure database is running and accessible.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error during setup
- **Solution**: Verify MB_DB_HOST matches the database container name. Ensure database is ready before Metabase starts.

### Slow Performance

- **Symptoms**: Queries take a long time to run
- **Solution**: 
  - Enable query caching in Admin → Settings → Caching
  - Add database indexes on frequently queried columns
  - Increase container resources if needed

### Cannot Add Database

- **Symptoms**: "Connection failed" when adding a database
- **Solution**: 
  - Verify database is accessible from Metabase container
  - Check firewall rules and network configuration
  - Use container names for Docker-based databases

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change all default passwords
- Use HTTPS with a reverse proxy (nginx, Caddy)
- Enable SSL for database connections
- Restrict access with firewall rules
- Regular backups are essential
- Consider using Metabase Cloud for managed hosting

## Resources

- [Official Documentation](https://www.metabase.com/docs/latest/)
- [GitHub Repository](https://github.com/metabase/metabase)
- [Docker Hub](https://hub.docker.com/r/metabase/metabase)
- [Community Forum](https://discourse.metabase.com/)
