# ELK Stack (Elasticsearch, Logstash, Kibana)

A powerful open-source log management and analytics platform. The ELK Stack combines Elasticsearch for search and analytics, Logstash for log ingestion and processing, and Kibana for visualization and dashboards.

**Official Sites:**
- [Elastic Stack](https://www.elastic.co/elastic-stack) | [Docker Hub](https://www.docker.elastic.co/)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the ELK stack
docker compose -f elk.yaml up -d
```

## Services

### Elasticsearch
- **URL**: http://localhost:9200
- **Container**: `elk_elasticsearch`
- **Transport Port**: 9300
- **Username**: `elastic` (if security enabled)
- **Password**: `P@ss0rd123` (if security enabled)

### Logstash
- **TCP/UDP Port**: 5000
- **Beats Port**: 5044
- **Container**: `elk_logstash`
- **Note**: Receives logs via TCP, UDP, or Beats protocol

### Kibana
- **URL**: http://localhost:5601
- **Container**: `elk_kibana`
- **Username**: `elastic` (if security enabled)
- **Password**: `P@ss0rd123` (if security enabled)

## Initial Setup

1. Copy `.env.example` to `.env` and configure settings
2. Start the stack with `docker compose -f elk.yaml up -d`
3. Wait for Elasticsearch to be healthy (check: `docker logs elk_elasticsearch`)
4. Navigate to http://localhost:5601 to access Kibana
5. Create index patterns in Kibana to view logs

## Log Ingestion

### Send Logs via TCP

```bash
# Send JSON log
echo '{"message":"Test log","level":"info"}' | nc localhost 5000

# Send from application
curl -X POST http://localhost:5000 -H "Content-Type: application/json" -d '{"message":"Application log","service":"myapp"}'
```

### Send Logs via UDP

```bash
# Send UDP log
echo '{"message":"UDP log","level":"warn"}' | nc -u localhost 5000
```

### Configure Application Logging

**Python Example:**
```python
import logging
from logstash_async.handler import AsynchronousLogstashHandler

logger = logging.getLogger('python-logstash-logger')
logger.setLevel(logging.INFO)
logger.addHandler(AsynchronousLogstashHandler('localhost', 5000, database_path=None))

logger.info('Test log message', extra={'service': 'myapp'})
```

**Node.js Example:**
```javascript
const winston = require('winston');
const LogstashTransport = require('winston-logstash/lib/winston-logstash-latest');

const logger = winston.createLogger({
  transports: [
    new LogstashTransport({
      port: 5000,
      host: 'localhost',
      node_name: 'myapp'
    })
  ]
});

logger.info('Test log message');
```

### Using Filebeat

```yaml
# filebeat.yml
filebeat.inputs:
  - type: log
    enabled: true
    paths:
      - /var/log/*.log

output.logstash:
  hosts: ["localhost:5044"]
```

## Kibana Dashboard Setup

### Create Index Pattern

1. Navigate to Kibana at http://localhost:5601
2. Go to "Management" → "Stack Management" → "Index Patterns"
3. Click "Create index pattern"
4. Enter pattern: `logstash-*`
5. Select `@timestamp` as the time field
6. Click "Create index pattern"

### View Logs

1. Go to "Analytics" → "Discover"
2. Select your index pattern
3. View and search logs in real-time

### Create Visualizations

1. Go to "Analytics" → "Visualizations"
2. Click "Create visualization"
3. Choose visualization type (bar chart, pie chart, etc.)
4. Select your index pattern and configure metrics
5. Save the visualization

### Build Dashboards

1. Go to "Analytics" → "Dashboard"
2. Click "Create dashboard"
3. Add saved visualizations
4. Arrange and save the dashboard

## Configuration

### Environment Variables (.env)

- `ELASTICSEARCH_PORT` - Elasticsearch HTTP port (default: 9200)
- `ELASTICSEARCH_TRANSPORT_PORT` - Elasticsearch transport port (default: 9300)
- `LOGSTASH_PORT` - Logstash TCP/UDP port (default: 5000)
- `LOGSTASH_BEATS_PORT` - Logstash Beats port (default: 5044)
- `KIBANA_PORT` - Kibana web interface port (default: 5601)
- `XPACK_SECURITY_ENABLED` - Enable X-Pack security (default: false)
- `ES_JAVA_OPTS` - Elasticsearch JVM options (default: -Xms512m -Xmx512m)
- `LS_JAVA_OPTS` - Logstash JVM options (default: -Xms256m -Xmx256m)
- `ELASTIC_PASSWORD` - Elasticsearch password (change for production)

### Custom Logstash Pipeline

Edit `logstash.conf` to customize log parsing:

```conf
input {
  # Add custom inputs
  file {
    path => "/var/log/myapp/*.log"
    start_position => "beginning"
  }
}

filter {
  # Add custom filters
  if [type] == "myapp" {
    grok {
      match => { "message" => "%{TIMESTAMP_ISO8601:timestamp} %{LOGLEVEL:level} %{GREEDYDATA:message}" }
    }
  }
}

output {
  # Outputs are already configured
}
```

### Memory Configuration

For production use, increase memory allocation:

```bash
# In .env file
ES_JAVA_OPTS=-Xms2g -Xmx2g
LS_JAVA_OPTS=-Xms1g -Xmx1g
```

## Volumes

- `elasticsearch-data` - Elasticsearch indices and data
- `logstash-data` - Logstash persistent queue and data
- `kibana-data` - Kibana saved objects and configuration

## Common Tasks

### Check Elasticsearch Health

```bash
curl http://localhost:9200/_cluster/health?pretty
```

### List Indices

```bash
curl http://localhost:9200/_cat/indices?v
```

### Delete Old Indices

```bash
# Delete indices older than 30 days
curl -X DELETE "http://localhost:9200/logstash-$(date -d '30 days ago' +%Y.%m.%d)"
```

### Backup Elasticsearch Data

```bash
# Create snapshot repository
curl -X PUT "http://localhost:9200/_snapshot/backup" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/usr/share/elasticsearch/backup"
  }
}'

# Create snapshot
curl -X PUT "http://localhost:9200/_snapshot/backup/snapshot_1?wait_for_completion=true"
```

### View Logstash Logs

```bash
docker logs elk_logstash
```

### Test Logstash Configuration

```bash
docker exec elk_logstash logstash -f /usr/share/logstash/pipeline/logstash.conf --config.test_and_exit
```

## Troubleshooting

### Elasticsearch Won't Start

- **Symptoms**: Container exits with "max virtual memory areas vm.max_map_count [65530] is too low"
- **Solution**: Increase vm.max_map_count on the host:
  ```bash
  # Linux
  sudo sysctl -w vm.max_map_count=262144
  
  # Make permanent
  echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
  
  # Windows (WSL2)
  wsl -d docker-desktop sysctl -w vm.max_map_count=262144
  ```

### Out of Memory Errors

- **Symptoms**: Services crash or become unresponsive
- **Solution**: Increase memory allocation in .env file or reduce heap size if system has limited RAM

### Logs Not Appearing in Kibana

- **Symptoms**: No data in Discover view
- **Solution**: 
  1. Check Logstash is receiving logs: `docker logs elk_logstash`
  2. Verify index pattern matches: `curl http://localhost:9200/_cat/indices`
  3. Ensure time range in Kibana covers log timestamps

### Connection Refused Errors

- **Symptoms**: Services cannot connect to Elasticsearch
- **Solution**: Wait for Elasticsearch to be fully healthy. Check health: `docker logs elk_elasticsearch`

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Enable X-Pack security (`XPACK_SECURITY_ENABLED=true`)
- Change all default passwords
- Use HTTPS with TLS certificates
- Configure authentication and role-based access control
- Restrict network access with firewall rules
- Enable audit logging
- Regular backups are essential

## Resources

- [Elasticsearch Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Logstash Documentation](https://www.elastic.co/guide/en/logstash/current/index.html)
- [Kibana Documentation](https://www.elastic.co/guide/en/kibana/current/index.html)
- [Elastic Stack Docker Images](https://www.docker.elastic.co/)
