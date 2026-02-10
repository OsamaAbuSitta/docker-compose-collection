# Redash

Make your company data-driven. Connect to any data source, easily visualize, dashboard and share your data. Redash helps you make sense of your data by making it easy to query, visualize, and share.

**Official Sites:**
- [Redash](https://redash.io/) | [Docker Hub](https://hub.docker.com/r/redash/redash)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially secret keys)

# Start the services
docker compose -f redash.yaml up -d

# Create the database schema (first time only)
docker exec redash_server ./manage.py database create_tables

# Create an admin user (first time only)
docker exec -it redash_server ./manage.py users create --admin --password P@ss0rd123 admin "Admin User" admin@example.com
```

## Services

### Redash Server
- **URL**: http://localhost:5000
- **Container**: `redash_server`
- **Note**: Create admin user using the command above

### Redash Scheduler
- **Container**: `redash_scheduler`
- **Purpose**: Handles scheduled query execution

### Redash Worker
- **Container**: `redash_worker`
- **Purpose**: Processes query execution jobs

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `redash_db`
- **Database**: `redash`
- **Username**: `redash`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `redash_redis`

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Generate secure secret keys (minimum 32 characters each)
   - Set database password
2. Start the services with `docker compose -f redash.yaml up -d`
3. Wait for all containers to be running
4. Create database tables: `docker exec redash_server ./manage.py database create_tables`
5. Create admin user: `docker exec -it redash_server ./manage.py users create --admin --password YourPassword admin "Admin User" admin@example.com`
6. Navigate to http://localhost:5000
7. Log in with your admin credentials

## Configuration

### Environment Variables (.env)

- `REDASH_PORT` - Web interface port (default: 5000)
- `REDASH_COOKIE_SECRET` - Cookie encryption key (minimum 32 characters, change for production)
- `REDASH_SECRET_KEY` - Application secret key (minimum 32 characters, change for production)
- `REDASH_WEB_WORKERS` - Number of web workers (default: 4)
- `WORKERS_COUNT` - Number of query workers (default: 2)
- `REDASH_LOG_LEVEL` - Logging level (INFO, DEBUG, WARNING, ERROR)
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production)
- `POSTGRES_DB` - Database name
- `REDIS_HOST` - Redis hostname (use container name)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Generate Secure Secret Keys

```bash
# Generate secure secret keys (minimum 32 characters)
openssl rand -base64 32
```

## Connecting to Data Sources

### From Redash UI

1. Click "Settings" → "Data Sources"
2. Click "New Data Source"
3. Select your data source type
4. Enter connection details

### Supported Data Sources

Redash supports 50+ data sources including:
- **Databases**: PostgreSQL, MySQL, MongoDB, SQLite, Oracle, SQL Server
- **Cloud Data Warehouses**: BigQuery, Snowflake, Redshift, Athena
- **NoSQL**: Cassandra, DynamoDB, Elasticsearch
- **APIs**: Google Analytics, Salesforce, Jira
- **And many more**

### Example Connection Strings

**PostgreSQL**:
```
Host: postgres_container
Port: 5432
Database: mydb
User: myuser
Password: mypassword
```

**MySQL**:
```
Host: mysql_container
Port: 3306
Database: mydb
User: myuser
Password: mypassword
```

**MongoDB**:
```
mongodb://username:password@mongodb_container:27017/database
```

## Volumes

- `redash-db-data` - PostgreSQL database files
- `redash-redis-data` - Redis cache data

## Common Tasks

### Create a Query

1. Click "Create" → "Query"
2. Select your data source
3. Write your SQL query
4. Click "Execute" to run the query
5. Save the query with a name

### Create a Visualization

1. Create or open a query
2. Click "+ New Visualization"
3. Select visualization type (Chart, Table, Map, etc.)
4. Configure the visualization
5. Save the visualization

### Create a Dashboard

1. Click "Create" → "Dashboard"
2. Add widgets (queries/visualizations)
3. Arrange and resize widgets
4. Add text boxes and filters
5. Save and publish the dashboard

### Schedule a Query

1. Open a query
2. Click "Schedule"
3. Set the refresh interval
4. Save the schedule

### Set Up Alerts

1. Create a query that returns a numeric value
2. Click "Alerts" → "New Alert"
3. Set the condition (e.g., value > 100)
4. Configure notification destination
5. Save the alert

### Backup Redash Data

```bash
# Backup the PostgreSQL database
docker exec redash_db pg_dump -U redash redash > redash_backup.sql
```

### Restore Redash Data

```bash
# Restore the PostgreSQL database
cat redash_backup.sql | docker exec -i redash_db psql -U redash redash
```

### Create Additional Users

```bash
# Create a regular user
docker exec -it redash_server ./manage.py users create username "Full Name" email@example.com

# Create an admin user
docker exec -it redash_server ./manage.py users create --admin username "Full Name" email@example.com
```

### Grant Admin Privileges

```bash
docker exec -it redash_server ./manage.py users grant_admin email@example.com
```

## Features

- **SQL Editor**: Write and execute SQL queries with autocomplete
- **Visualizations**: Charts, tables, maps, pivot tables, and more
- **Dashboards**: Combine multiple visualizations into dashboards
- **Scheduled Queries**: Automatically refresh queries on a schedule
- **Alerts**: Get notified when query results meet certain conditions
- **API Access**: REST API for programmatic access
- **Collaboration**: Share queries and dashboards with your team
- **Query Snippets**: Reusable SQL snippets
- **Parameters**: Dynamic queries with user-defined parameters
- **50+ Data Sources**: Connect to databases, APIs, and cloud services

## Troubleshooting

### Application Won't Start

- **Symptoms**: Containers exit or restart repeatedly
- **Solution**: Check logs with `docker logs redash_server`. Ensure secret keys are at least 32 characters.

### Database Tables Not Created

- **Symptoms**: "relation does not exist" errors
- **Solution**: Run `docker exec redash_server ./manage.py database create_tables`

### Cannot Create Admin User

- **Symptoms**: User creation command fails
- **Solution**: 
  - Ensure database tables are created first
  - Check database connection in logs
  - Verify PostgreSQL container is running

### Queries Not Executing

- **Symptoms**: Queries stay in "pending" state
- **Solution**: 
  - Check worker container is running: `docker ps | grep redash_worker`
  - Check worker logs: `docker logs redash_worker`
  - Verify Redis is running: `docker ps | grep redash_redis`

### Slow Query Performance

- **Symptoms**: Queries take a long time to execute
- **Solution**: 
  - Enable query result caching
  - Optimize your SQL queries
  - Add database indexes
  - Increase worker count in .env file

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate secure secret keys (minimum 32 characters each)
- Change all default passwords
- Use HTTPS with a reverse proxy (nginx, Caddy)
- Enable SSL for database connections
- Restrict access with firewall rules
- Regular backups are essential
- Configure proper authentication (LDAP, SAML, OAuth)
- Review and configure user permissions

## Resources

- [Official Documentation](https://redash.io/help/)
- [GitHub Repository](https://github.com/getredash/redash)
- [Docker Hub](https://hub.docker.com/r/redash/redash)
- [Community Forum](https://discuss.redash.io/)
