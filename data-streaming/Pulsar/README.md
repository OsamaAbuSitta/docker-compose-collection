# Apache Pulsar

A cloud-native, distributed messaging and streaming platform that provides multi-tenancy, geo-replication, and strong durability guarantees. Pulsar combines the best features of traditional messaging systems with streaming capabilities, offering both pub-sub and queue semantics.

**Official Sites:**
- [Apache Pulsar](https://pulsar.apache.org/) | [Docker Hub](https://hub.docker.com/r/apachepulsar/pulsar)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f pulsar.yaml up -d
```

## Services

### Pulsar Standalone
- **Binary Protocol Port**: 6650
- **HTTP Admin API**: http://localhost:8080
- **Admin Console**: http://localhost:8080/admin/
- **Container**: `pulsar`
- **Authentication**: None (default configuration)

## Initial Setup

1. Copy `.env.example` to `.env` and configure if needed
2. Start the service with `docker compose -f pulsar.yaml up -d`
3. Wait for Pulsar to initialize (check logs: `docker logs pulsar`)
4. Navigate to http://localhost:8080/admin/ for the admin console
5. Connect clients to `pulsar://localhost:6650`

## Configuration

### Environment Variables (.env)

- `PULSAR_PORT` - Binary protocol port for client connections (default: 6650)
- `PULSAR_HTTP_PORT` - HTTP admin API and web console port (default: 8080)
- `PULSAR_MEM` - JVM memory settings (default: -Xms512m -Xmx512m -XX:MaxDirectMemorySize=256m)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

For advanced configuration, you can mount custom configuration files:

```yaml
services:
  pulsar:
    volumes:
      - ./broker.conf:/pulsar/conf/broker.conf
      - ./standalone.conf:/pulsar/conf/standalone.conf
      - pulsar-data:/pulsar/data
      - pulsar-conf:/pulsar/conf
```

### Standalone Mode

This configuration runs Pulsar in standalone mode, which includes:
- Pulsar broker
- BookKeeper (for message storage)
- ZooKeeper (for metadata)

Standalone mode is ideal for development and testing. For production, use a full cluster deployment.

## Connecting to Pulsar

### From Host Machine

```bash
# Using Python client
import pulsar

client = pulsar.Client('pulsar://localhost:6650')
producer = client.create_producer('my-topic')
producer.send('Hello Pulsar!'.encode('utf-8'))

consumer = client.subscribe('my-topic', 'my-subscription')
msg = consumer.receive()
print(f"Received: {msg.data().decode('utf-8')}")
consumer.acknowledge(msg)

client.close()
```

### From Another Container

```yaml
services:
  your-app:
    environment:
      - PULSAR_SERVICE_URL=pulsar://pulsar:6650
      - PULSAR_WEB_SERVICE_URL=http://pulsar:8080
```

Connection strings:
- Binary protocol: `pulsar://pulsar:6650`
- HTTP API: `http://pulsar:8080`

## Volumes

- `pulsar-data` - Pulsar data directory containing messages, ledgers, and BookKeeper data
- `pulsar-conf` - Configuration files for Pulsar components

## Common Tasks

### Create a Topic

```bash
# Using pulsar-admin CLI
docker exec pulsar bin/pulsar-admin topics create persistent://public/default/my-topic
```

### List Topics

```bash
docker exec pulsar bin/pulsar-admin topics list public/default
```

### Produce Messages

```bash
# Using pulsar-client CLI
docker exec pulsar bin/pulsar-client produce my-topic --messages "Hello Pulsar"
```

### Consume Messages

```bash
docker exec pulsar bin/pulsar-client consume my-topic -s "my-subscription" -n 0
```

### Create a Namespace

```bash
docker exec pulsar bin/pulsar-admin namespaces create public/my-namespace
```

### List Namespaces

```bash
docker exec pulsar bin/pulsar-admin namespaces list public
```

### View Topic Stats

```bash
docker exec pulsar bin/pulsar-admin topics stats persistent://public/default/my-topic
```

### Create a Tenant

```bash
docker exec pulsar bin/pulsar-admin tenants create my-tenant
```

### List Subscriptions

```bash
docker exec pulsar bin/pulsar-admin topics subscriptions persistent://public/default/my-topic
```

### Delete a Topic

```bash
docker exec pulsar bin/pulsar-admin topics delete persistent://public/default/my-topic
```

### View Broker Stats

```bash
docker exec pulsar bin/pulsar-admin broker-stats monitoring-metrics
```

## Admin API Endpoints

The HTTP admin API (port 8080) provides REST endpoints for management:

- `/admin/v2/clusters` - Cluster management
- `/admin/v2/tenants` - Tenant management
- `/admin/v2/namespaces` - Namespace management
- `/admin/v2/persistent/{tenant}/{namespace}/{topic}` - Topic management
- `/admin/v2/brokers` - Broker information
- `/metrics` - Prometheus metrics

Example API call:
```bash
# List all topics in a namespace
curl http://localhost:8080/admin/v2/persistent/public/default
```

## Features

- **Multi-Tenancy**: Built-in support for multiple tenants with isolation
- **Geo-Replication**: Cross-datacenter replication for disaster recovery
- **Tiered Storage**: Offload old data to cheaper storage (S3, GCS, Azure)
- **Pub-Sub and Queuing**: Unified messaging model supporting both patterns
- **Message Retention**: Flexible retention policies (time, size, or both)
- **Guaranteed Ordering**: Per-key ordering guarantees
- **Exactly-Once Semantics**: Idempotent producers and effectively-once processing
- **Schema Registry**: Built-in schema management with evolution support
- **Functions**: Lightweight compute framework for stream processing
- **SQL**: Query streaming data with Pulsar SQL (Presto)
- **Connectors**: Built-in connectors for Kafka, Cassandra, Elasticsearch, and more
- **Multi-Protocol**: Native protocol, Kafka API compatibility, AMQP, MQTT
- **Horizontal Scalability**: Add brokers and BookKeeper nodes independently

## Troubleshooting

### Cannot Connect to Pulsar

- **Symptoms**: Connection refused on port 6650
- **Solution**: Ensure the container is running and healthy. Check logs with `docker logs pulsar`. Pulsar standalone can take 30-60 seconds to fully initialize.

### Admin Console Not Accessible

- **Symptoms**: Cannot access http://localhost:8080
- **Solution**: Verify the HTTP port is correctly mapped. Check that Pulsar has fully started by examining the logs for "messaging service is ready".

### Out of Memory Errors

- **Symptoms**: Container crashes or restarts frequently
- **Solution**: Increase memory allocation using the `PULSAR_MEM` environment variable. Standalone mode requires at least 512MB heap and 256MB direct memory.

### Topics Not Persisting

- **Symptoms**: Messages lost after restart
- **Solution**: Verify the data volume is properly mounted. Check BookKeeper logs within the container. Ensure sufficient disk space is available.

### Slow Performance

- **Symptoms**: High latency or low throughput
- **Solution**: For standalone mode, this is expected as all components run in one container. For production workloads, deploy a full cluster. Adjust memory settings and check disk I/O performance.

### Health Check Failing

- **Symptoms**: Container marked as unhealthy
- **Solution**: Check logs for errors. Ensure all Pulsar components (broker, BookKeeper, ZooKeeper) have started successfully. Verify network connectivity.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Enable authentication (JWT, Athenz, or custom)
- Enable authorization with role-based access control
- Use TLS/SSL for encrypted connections (both binary and HTTP)
- Restrict admin API access with firewall rules
- Enable audit logging for compliance
- Regular backups of BookKeeper data are essential
- Use separate clusters for different environments
- Implement network segmentation between components
- Monitor resource usage and set appropriate quotas
- Consider using a service mesh for additional security

### Enabling Authentication

Add to your custom `broker.conf`:

```properties
authenticationEnabled=true
authenticationProviders=org.apache.pulsar.broker.authentication.AuthenticationProviderToken
brokerClientAuthenticationPlugin=org.apache.pulsar.client.impl.auth.AuthenticationToken
brokerClientAuthenticationParameters=token:<your-token>
```

### Enabling TLS

```properties
tlsEnabled=true
tlsCertificateFilePath=/path/to/broker-cert.pem
tlsKeyFilePath=/path/to/broker-key.pem
tlsTrustCertsFilePath=/path/to/ca-cert.pem
```

## Resources

- [Official Documentation](https://pulsar.apache.org/docs/)
- [Getting Started Guide](https://pulsar.apache.org/docs/getting-started-standalone/)
- [Admin API Reference](https://pulsar.apache.org/admin-rest-api/)
- [Client Libraries](https://pulsar.apache.org/docs/client-libraries/)
- [Docker Hub](https://hub.docker.com/r/apachepulsar/pulsar)
- [Pulsar Functions](https://pulsar.apache.org/docs/functions-overview/)
- [Pulsar SQL](https://pulsar.apache.org/docs/sql-overview/)
- [Geo-Replication](https://pulsar.apache.org/docs/administration-geo/)
- [Tiered Storage](https://pulsar.apache.org/docs/tiered-storage-overview/)
- [Kafka Compatibility](https://pulsar.apache.org/docs/adaptors-kafka/)
