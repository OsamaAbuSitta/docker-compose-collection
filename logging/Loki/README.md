# Loki with Grafana

A horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus. Loki is designed to be cost-effective and easy to operate, as it does not index the contents of logs but rather a set of labels for each log stream. Includes Grafana for visualization and Promtail for log collection.

**Official Sites:**
- [Grafana Loki](https://grafana.com/oss/loki/) | [Docker Hub](https://hub.docker.com/r/grafana/loki)
- [Grafana](https://grafana.com/) | [Docker Hub](https://hub.docker.com/r/grafana/grafana)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the Loki stack
docker compose -f loki.yaml up -d
```

## Services

### Loki
- **URL**: http://localhost:3100
- **Container**: `loki`
- **Note**: Log aggregation backend

### Promtail
- **Container**: `promtail`
- **Note**: Log collector that ships logs to Loki

### Grafana
- **URL**: http://localhost:3000
- **Container**: `loki_grafana`
- **Username**: `admin`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure settings
2. Start the stack with `docker compose -f loki.yaml up -d`
3. Wait for services to be healthy (check: `docker logs loki`)
4. Navigate to http://localhost:3000 to access Grafana
5. Log in with admin credentials
6. Loki datasource is pre-configured and ready to use

## Log Aggregation Setup

### View Logs in Grafana

1. Navigate to Grafana at http://localhost:3000
2. Go to "Explore" (compass icon in left sidebar)
3. Select "Loki" as the datasource
4. Use LogQL to query logs:
   ```logql
   {job="varlogs"}
   {job="containerlogs"}
   {container_name="myapp"}
   ```

### LogQL Query Examples

**View all logs:**
```logql
{job="varlogs"}
```

**Filter by container:**
```logql
{job="containerlogs", container_name="nginx"}
```

**Search for specific text:**
```logql
{job="varlogs"} |= "error"
```

**Exclude text:**
```logql
{job="varlogs"} != "debug"
```

**Regular expression filter:**
```logql
{job="varlogs"} |~ "error|warning"
```

**Count log lines:**
```logql
count_over_time({job="varlogs"}[5m])
```

**Rate of logs:**
```logql
rate({job="containerlogs"}[1m])
```

### Send Logs to Loki

**Using Promtail (included):**
Promtail automatically collects logs from:
- System logs in `/var/log/`
- Docker container logs

**Using HTTP API:**
```bash
curl -X POST http://localhost:3100/loki/api/v1/push \
  -H "Content-Type: application/json" \
  -d '{
    "streams": [
      {
        "stream": {
          "job": "myapp",
          "level": "info"
        },
        "values": [
          ["'$(date +%s)000000000'", "Test log message"]
        ]
      }
    ]
  }'
```

**Using Docker Logging Driver:**
```yaml
# In your docker-compose.yaml
services:
  myapp:
    image: myapp:latest
    logging:
      driver: loki
      options:
        loki-url: "http://localhost:3100/loki/api/v1/push"
        loki-batch-size: "400"
```

**Using Application Libraries:**

Python:
```python
import logging
import logging_loki

handler = logging_loki.LokiHandler(
    url="http://localhost:3100/loki/api/v1/push",
    tags={"application": "myapp"},
    version="1",
)

logger = logging.getLogger("my-logger")
logger.addHandler(handler)
logger.info("Test log message")
```

Node.js:
```javascript
const winston = require('winston');
const LokiTransport = require('winston-loki');

const logger = winston.createLogger({
  transports: [
    new LokiTransport({
      host: 'http://localhost:3100',
      labels: { app: 'myapp' }
    })
  ]
});

logger.info('Test log message');
```

## Grafana Dashboard Setup

### Create Log Dashboard

1. Go to "Dashboards" → "New Dashboard"
2. Click "Add visualization"
3. Select "Loki" as datasource
4. Enter LogQL query: `{job="containerlogs"}`
5. Choose visualization type (Logs, Time series, etc.)
6. Configure panel settings
7. Save the dashboard

### Pre-built Dashboards

Import community dashboards:
1. Go to "Dashboards" → "Import"
2. Enter dashboard ID or upload JSON
3. Popular Loki dashboards:
   - Dashboard ID 13639: Loki & Promtail
   - Dashboard ID 12019: Loki Dashboard

### Create Alerts

1. Go to "Alerting" → "Alert rules"
2. Click "New alert rule"
3. Define query: `count_over_time({job="varlogs"} |= "error" [5m]) > 10`
4. Set evaluation interval and conditions
5. Configure notification channels
6. Save the alert

## Configuration

### Environment Variables (.env)

- `LOKI_PORT` - Loki HTTP port (default: 3100)
- `GRAFANA_PORT` - Grafana web interface port (default: 3000)
- `GF_ADMIN_USER` - Grafana admin username (default: admin)
- `GF_ADMIN_PASSWORD` - Grafana admin password (change for production)
- `GF_ALLOW_SIGNUP` - Allow user registration (default: false)
- `GF_SERVER_ROOT_URL` - Grafana root URL
- `GF_INSTALL_PLUGINS` - Comma-separated list of plugins to install

### Custom Promtail Configuration

Edit `promtail-config.yaml` to add custom log sources:

```yaml
scrape_configs:
  - job_name: myapp
    static_configs:
      - targets:
          - localhost
        labels:
          job: myapp
          __path__: /var/log/myapp/*.log
```

### Loki Retention

By default, Loki keeps logs indefinitely. To configure retention, create a custom Loki config:

```yaml
# loki-config.yaml
limits_config:
  retention_period: 744h  # 31 days

table_manager:
  retention_deletes_enabled: true
  retention_period: 744h
```

Mount the config in the compose file:
```yaml
volumes:
  - ./loki-config.yaml:/etc/loki/local-config.yaml:ro
```

## Volumes

- `loki-data` - Loki log storage and indices
- `grafana-data` - Grafana dashboards, users, and configuration

## Common Tasks

### Check Loki Health

```bash
curl http://localhost:3100/ready
```

### Query Loki API

```bash
# Get labels
curl http://localhost:3100/loki/api/v1/labels

# Get label values
curl http://localhost:3100/loki/api/v1/label/job/values

# Query logs
curl -G -s "http://localhost:3100/loki/api/v1/query_range" \
  --data-urlencode 'query={job="varlogs"}' \
  --data-urlencode 'limit=10'
```

### View Promtail Logs

```bash
docker logs promtail
```

### Backup Grafana Dashboards

```bash
# Export all dashboards
docker exec loki_grafana grafana-cli admin export-dashboard > dashboards.json
```

### Install Grafana Plugins

```bash
# In .env file
GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource

# Or manually
docker exec loki_grafana grafana-cli plugins install grafana-clock-panel
docker restart loki_grafana
```

## Troubleshooting

### Loki Not Receiving Logs

- **Symptoms**: No logs appear in Grafana
- **Solution**: 
  1. Check Promtail is running: `docker logs promtail`
  2. Verify Promtail can reach Loki: `docker exec promtail wget -O- http://loki:3100/ready`
  3. Check Promtail configuration for correct paths

### Grafana Cannot Connect to Loki

- **Symptoms**: "Bad Gateway" or connection errors in Grafana
- **Solution**: 
  1. Verify Loki is healthy: `curl http://localhost:3100/ready`
  2. Check datasource URL uses container name: `http://loki:3100`
  3. Restart Grafana: `docker restart loki_grafana`

### Permission Denied Errors

- **Symptoms**: Promtail cannot read log files
- **Solution**: Ensure log files are readable. On Linux, you may need to run Promtail with appropriate permissions or adjust log file permissions.

### High Memory Usage

- **Symptoms**: Loki or Grafana consuming too much memory
- **Solution**: 
  1. Configure retention to delete old logs
  2. Limit query range in Grafana
  3. Increase Docker memory limits if needed

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the Grafana admin password
- Enable authentication for Loki API
- Use HTTPS with TLS certificates
- Configure role-based access control in Grafana
- Restrict network access with firewall rules
- Enable audit logging
- Regular backups are essential

## Resources

- [Loki Documentation](https://grafana.com/docs/loki/latest/)
- [Promtail Documentation](https://grafana.com/docs/loki/latest/clients/promtail/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [LogQL Query Language](https://grafana.com/docs/loki/latest/logql/)
- [Docker Hub - Loki](https://hub.docker.com/r/grafana/loki)
- [Docker Hub - Grafana](https://hub.docker.com/r/grafana/grafana)
