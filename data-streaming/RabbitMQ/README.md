# RabbitMQ

A robust, open-source message broker that supports multiple messaging protocols. RabbitMQ is lightweight, easy to deploy, and supports distributed and federated configurations to meet high-scale, high-availability requirements.

**Official Sites:**
- [RabbitMQ](https://www.rabbitmq.com/) | [Docker Hub](https://hub.docker.com/_/rabbitmq)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f rabbitmq.yaml up -d
```

## Services

### RabbitMQ Server
- **AMQP Port**: 5672
- **Management UI**: http://localhost:15672
- **Container**: `rabbitmq`
- **Username**: `guest`
- **Password**: `guest`

## Initial Setup

1. Copy `.env.example` to `.env` and configure if needed
2. Start the service with `docker compose -f rabbitmq.yaml up -d`
3. Wait for RabbitMQ to initialize (check logs: `docker logs rabbitmq`)
4. Navigate to http://localhost:15672 for the management UI
5. Log in with the default credentials (guest/guest)

## Configuration

### Environment Variables (.env)

- `RABBITMQ_PORT` - AMQP protocol port (default: 5672)
- `RABBITMQ_MANAGEMENT_PORT` - Management UI port (default: 15672)
- `RABBITMQ_DEFAULT_USER` - Default username (default: guest)
- `RABBITMQ_DEFAULT_PASS` - Default password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

For advanced configuration, you can mount a custom `rabbitmq.conf` file:

```yaml
volumes:
  - ./rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf
  - rabbitmq-data:/var/lib/rabbitmq
```

## Connecting to RabbitMQ

### From Host Machine

```bash
# Using Python (pika library)
import pika

connection = pika.BlockingConnection(
    pika.ConnectionParameters('localhost', 5672, '/', 
    pika.PlainCredentials('guest', 'guest'))
)
channel = connection.channel()
```

### From Another Container

```yaml
services:
  your-app:
    environment:
      - RABBITMQ_HOST=rabbitmq
      - RABBITMQ_PORT=5672
      - RABBITMQ_USER=guest
      - RABBITMQ_PASS=guest
```

Connection string: `amqp://guest:guest@rabbitmq:5672/`

## Volumes

- `rabbitmq-data` - RabbitMQ data directory containing message queues, exchanges, and configuration

## Common Tasks

### Create a Queue

```bash
# Using rabbitmqadmin (available in management container)
docker exec rabbitmq rabbitmqadmin declare queue name=my_queue durable=true
```

### List Queues

```bash
docker exec rabbitmq rabbitmqctl list_queues
```

### Create a User

```bash
docker exec rabbitmq rabbitmqctl add_user myuser mypassword
docker exec rabbitmq rabbitmqctl set_user_tags myuser administrator
docker exec rabbitmq rabbitmqctl set_permissions -p / myuser ".*" ".*" ".*"
```

### Delete a Queue

```bash
docker exec rabbitmq rabbitmqadmin delete queue name=my_queue
```

### View Cluster Status

```bash
docker exec rabbitmq rabbitmqctl cluster_status
```

### Enable Plugins

```bash
# Enable additional plugins (e.g., STOMP, MQTT)
docker exec rabbitmq rabbitmq-plugins enable rabbitmq_stomp
docker exec rabbitmq rabbitmq-plugins enable rabbitmq_mqtt
```

## Features

- **Multiple Messaging Protocols**: AMQP 0-9-1, AMQP 1.0, STOMP, MQTT
- **Management UI**: Web-based interface for monitoring and management
- **Clustering**: Support for high availability and load distribution
- **Flexible Routing**: Topic exchanges, direct exchanges, fanout exchanges
- **Message Persistence**: Durable queues and persistent messages
- **Dead Letter Exchanges**: Handle failed message processing
- **Priority Queues**: Message prioritization support
- **Publisher Confirms**: Reliable message publishing
- **Consumer Acknowledgments**: Reliable message consumption

## Troubleshooting

### Cannot Access Management UI

- **Symptoms**: Management UI not accessible at port 15672
- **Solution**: Ensure the container is running and the management plugin is enabled (it's included in the `rabbitmq:3-management` image)

### Connection Refused

- **Symptoms**: Applications cannot connect to port 5672
- **Solution**: Check that the container is running and healthy. Verify firewall rules and port mappings.

### Authentication Failed

- **Symptoms**: "ACCESS_REFUSED" error when connecting
- **Solution**: Verify username and password. The default `guest` user can only connect from localhost in production mode.

### Disk Space Issues

- **Symptoms**: RabbitMQ stops accepting messages
- **Solution**: RabbitMQ has a disk space alarm. Check available disk space and clear old messages or increase storage.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the default username and password
- The `guest` user should be disabled or restricted to localhost only
- Use TLS/SSL for encrypted connections
- Restrict management UI access with firewall rules
- Enable authentication and authorization plugins
- Regular backups of the data volume are essential
- Consider using a reverse proxy with authentication for the management UI

## Resources

- [Official Documentation](https://www.rabbitmq.com/documentation.html)
- [Management Plugin Guide](https://www.rabbitmq.com/management.html)
- [AMQP Concepts](https://www.rabbitmq.com/tutorials/amqp-concepts.html)
- [Docker Hub](https://hub.docker.com/_/rabbitmq)
- [Clustering Guide](https://www.rabbitmq.com/clustering.html)
