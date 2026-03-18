# InfluxDB

InfluxDB is an open-source time series database designed to handle high write and query loads. It's ideal for storing and analyzing metrics, events, and real-time analytics data.

**Official Sites:**
- [InfluxDB](https://www.influxdata.com/) | [Docker Hub](https://hub.docker.com/_/influxdb)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f influxdb.yaml up -d
```

## Services

### InfluxDB
- **URL**: http://localhost:8086
- **Container**: `influxdb_container`
- **Username**: `admin`
- **Password**: `P@ss0rd123`
- **Organization**: `myorg`
- **Bucket**: `mybucket`
- **Admin Token**: `mytoken123456789`

## Initial Setup

1. Copy `.env.example` to `.env` and configure your settings
2. Generate a secure admin token (recommended for production)
3. Start the service with `docker compose -f influxdb.yaml up -d`
4. Navigate to http://localhost:8086
5. Login with the credentials configured in your `.env` file
6. The initial organization and bucket will be created automatically

## Configuration

### Environment Variables (.env)

- `INFLUXDB_PORT` - Web UI and API port (default: 8086)
- `INFLUXDB_INIT_MODE` - Initialization mode (default: setup)
- `INFLUXDB_INIT_USERNAME` - Initial admin username
- `INFLUXDB_INIT_PASSWORD` - Initial admin password (change for production)
- `INFLUXDB_INIT_ORG` - Initial organization name
- `INFLUXDB_INIT_BUCKET` - Initial bucket name
- `INFLUXDB_INIT_ADMIN_TOKEN` - Admin API token (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

For advanced configuration, you can mount a custom config file:

```yaml
volumes:
  - ./influxdb.conf:/etc/influxdb2/influxdb.conf
  - influxdb-data:/var/lib/influxdb2
```

## Connecting to InfluxDB

### From Host Machine (CLI)

```bash
# Using influx CLI
docker exec -it influxdb_container influx

# Or install influx CLI on host and connect
influx config create --config-name myconfig \
  --host-url http://localhost:8086 \
  --org myorg \
  --token mytoken123456789 \
  --active
```

### From Application (HTTP API)

```bash
# Write data
curl -XPOST "http://localhost:8086/api/v2/write?org=myorg&bucket=mybucket" \
  -H "Authorization: Token mytoken123456789" \
  -H "Content-Type: text/plain; charset=utf-8" \
  --data-binary "measurement,tag=value field=123 1234567890000000000"

# Query data (Flux)
curl -XPOST "http://localhost:8086/api/v2/query?org=myorg" \
  -H "Authorization: Token mytoken123456789" \
  -H "Content-Type: application/vnd.flux" \
  --data 'from(bucket:"mybucket") |> range(start:-1h)'
```

### From Python

```python
from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS

client = InfluxDBClient(
    url="http://localhost:8086",
    token="mytoken123456789",
    org="myorg"
)

# Write data
write_api = client.write_api(write_options=SYNCHRONOUS)
point = Point("measurement").tag("location", "server1").field("temperature", 25.3)
write_api.write(bucket="mybucket", record=point)

# Query data
query_api = client.query_api()
query = 'from(bucket:"mybucket") |> range(start:-1h)'
result = query_api.query(query=query)
```

## Volumes

- `influxdb-data` - Time series data storage
- `influxdb-config` - Configuration files and metadata

## Common Tasks

### Create a New Bucket

```bash
docker exec influxdb_container influx bucket create \
  -n newbucket \
  -o myorg \
  -t mytoken123456789
```

### Create an API Token

```bash
docker exec influxdb_container influx auth create \
  -o myorg \
  --read-bucket mybucket \
  --write-bucket mybucket \
  -t mytoken123456789
```

### Backup Database

```bash
# Backup all data
docker exec influxdb_container influx backup /tmp/backup -t mytoken123456789
docker cp influxdb_container:/tmp/backup ./influxdb_backup
```

### Restore Database

```bash
# Copy backup to container
docker cp ./influxdb_backup influxdb_container:/tmp/backup

# Restore data
docker exec influxdb_container influx restore /tmp/backup
```

### Access InfluxDB Shell

```bash
docker exec -it influxdb_container influx
```

### View Logs

```bash
docker logs influxdb_container
```

## Features

- **Time Series Optimized**: Purpose-built for time series data with high write and query performance
- **Flux Query Language**: Powerful functional query language for data analysis
- **Web UI**: Built-in web interface for data exploration and visualization
- **Retention Policies**: Automatic data retention and downsampling
- **Continuous Queries**: Automated data processing and aggregation
- **Telegraf Integration**: Native integration with Telegraf for metrics collection
- **Multi-tenancy**: Organizations and buckets for data isolation
- **API-First**: RESTful HTTP API for all operations

## Troubleshooting

### Container Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs influxdb_container`. Ensure the admin token is set and volumes have proper permissions.

### Cannot Access Web UI

- **Symptoms**: Connection refused on port 8086
- **Solution**: Verify the container is running with `docker ps`. Check that port 8086 is not in use by another service.

### Authentication Failed

- **Symptoms**: "unauthorized access" error
- **Solution**: Verify your username, password, and token are correct. Check that the initial setup completed successfully.

### High Memory Usage

- **Symptoms**: Container using excessive memory
- **Solution**: Configure memory limits in the compose file and adjust cache settings in the InfluxDB configuration.

### Data Not Persisting

- **Symptoms**: Data lost after container restart
- **Solution**: Ensure volumes are properly mounted. Check volume permissions with `docker volume inspect influxdb-data`.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure admin token using a cryptographically secure random string
- Change the default admin password
- Use HTTPS with a reverse proxy (nginx, Traefik, Caddy)
- Restrict network access with firewall rules
- Enable authentication and authorization
- Regular backups are essential for production data
- Consider using InfluxDB Enterprise for additional security features

## Resources

- [Official Documentation](https://docs.influxdata.com/influxdb/v2.7/)
- [Flux Query Language Guide](https://docs.influxdata.com/flux/v0.x/)
- [InfluxDB API Reference](https://docs.influxdata.com/influxdb/v2.7/api/)
- [Docker Hub](https://hub.docker.com/_/influxdb)
- [GitHub Repository](https://github.com/influxdata/influxdb)
