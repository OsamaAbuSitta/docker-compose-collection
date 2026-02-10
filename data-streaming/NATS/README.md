# NATS

A high-performance, cloud-native messaging system that provides simple, secure, and scalable messaging for distributed systems. NATS supports pub/sub, request/reply, and queue groups, with JetStream providing persistence and streaming capabilities.

**Official Sites:**
- [NATS](https://nats.io/) | [Docker Hub](https://hub.docker.com/_/nats)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f nats.yaml up -d
```

## Services

### NATS Server
- **Client Port**: 4222
- **HTTP Monitoring**: http://localhost:8222
- **Container**: `nats`
- **Authentication**: None (default configuration)

## Initial Setup

1. Copy `.env.example` to `.env` and configure if needed
2. Start the service with `docker compose -f nats.yaml up -d`
3. Wait for NATS to initialize (check logs: `docker logs nats`)
4. Navigate to http://localhost:8222 for monitoring endpoints
5. Connect clients to `nats://localhost:4222`

## Configuration

### Environment Variables (.env)

- `NATS_PORT` - Client connection port (default: 4222)
- `NATS_HTTP_PORT` - HTTP monitoring port (default: 8222)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

For advanced configuration, you can mount a custom `nats.conf` file:

```yaml
services:
  nats:
    command: "--config /etc/nats/nats.conf"
    volumes:
      - ./nats.conf:/etc/nats/nats.conf
      - nats-data:/data
```

### JetStream Configuration

This configuration enables JetStream by default with the `--jetstream` flag. JetStream provides:
- Message persistence
- Stream processing
- Exactly-once delivery
- Message replay

## Connecting to NATS

### From Host Machine

```bash
# Using Go client
import "github.com/nats-io/nats.go"

nc, err := nats.Connect("nats://localhost:4222")
if err != nil {
    log.Fatal(err)
}
defer nc.Close()

# Publish a message
nc.Publish("subject", []byte("Hello NATS!"))

# Subscribe to a subject
nc.Subscribe("subject", func(m *nats.Msg) {
    fmt.Printf("Received: %s\n", string(m.Data))
})
```

### From Another Container

```yaml
services:
  your-app:
    environment:
      - NATS_URL=nats://nats:4222
```

Connection string: `nats://nats:4222`

## Volumes

- `nats-data` - JetStream data directory containing persistent streams and messages

## Common Tasks

### Publish a Message

```bash
# Using nats CLI (install from https://github.com/nats-io/natscli)
nats pub subject "Hello World"
```

### Subscribe to a Subject

```bash
nats sub subject
```

### Create a JetStream Stream

```bash
nats stream add mystream \
  --subjects "orders.*" \
  --storage file \
  --retention limits \
  --max-msgs=-1 \
  --max-age=1y
```

### List Streams

```bash
nats stream ls
```

### View Stream Info

```bash
nats stream info mystream
```

### Create a Consumer

```bash
nats consumer add mystream myconsumer \
  --filter orders.new \
  --ack explicit \
  --pull \
  --deliver all
```

### Monitor Server Status

```bash
# View server info via HTTP
curl http://localhost:8222/varz

# View connections
curl http://localhost:8222/connz

# View subscriptions
curl http://localhost:8222/subsz

# View JetStream info
curl http://localhost:8222/jsz
```

## Monitoring Endpoints

The HTTP monitoring port (8222) provides several endpoints:

- `/varz` - General server information
- `/connz` - Connection information
- `/routez` - Route information
- `/subsz` - Subscription information
- `/jsz` - JetStream information
- `/healthz` - Health check endpoint

## Features

- **High Performance**: Millions of messages per second
- **Lightweight**: Small memory footprint
- **Simple Protocol**: Easy to implement clients
- **Pub/Sub**: Traditional publish-subscribe messaging
- **Request/Reply**: Synchronous request-response pattern
- **Queue Groups**: Load balancing across subscribers
- **JetStream**: Persistence, streaming, and exactly-once delivery
- **Clustering**: High availability and horizontal scaling
- **Security**: TLS, authentication, and authorization
- **Multi-tenancy**: Account-based isolation
- **WebSocket Support**: Browser-based clients
- **MQTT Support**: IoT device connectivity

## Troubleshooting

### Cannot Connect to NATS

- **Symptoms**: Connection refused on port 4222
- **Solution**: Ensure the container is running and healthy. Check logs with `docker logs nats`. Verify firewall rules and port mappings.

### Monitoring Port Not Accessible

- **Symptoms**: Cannot access http://localhost:8222
- **Solution**: Verify the HTTP monitoring port is enabled with the `--http_port` flag. Check that the port mapping is correct in the compose file.

### JetStream Not Working

- **Symptoms**: Cannot create streams or consumers
- **Solution**: Ensure JetStream is enabled with the `--jetstream` flag. Check that the data directory is writable and has sufficient disk space.

### Messages Not Persisting

- **Symptoms**: Messages lost after restart
- **Solution**: Verify JetStream is enabled and the volume is properly mounted. Check stream configuration for retention policies.

### High Memory Usage

- **Symptoms**: NATS consuming excessive memory
- **Solution**: Check the number of active subscriptions and connections. Review JetStream stream limits and retention policies. Consider adjusting max payload size.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Enable authentication with users and passwords or tokens
- Use TLS/SSL for encrypted connections
- Implement authorization with permissions
- Restrict monitoring port access with firewall rules
- Use accounts for multi-tenancy and isolation
- Regular backups of JetStream data are essential
- Monitor resource usage and set appropriate limits
- Consider using NATS with a service mesh for additional security

### Enabling Authentication

Add to your custom `nats.conf`:

```
authorization {
  users = [
    {user: "myuser", password: "mypassword"}
  ]
}
```

Or use token-based authentication:

```
authorization {
  token: "mysecrettoken"
}
```

## Resources

- [Official Documentation](https://docs.nats.io/)
- [JetStream Guide](https://docs.nats.io/nats-concepts/jetstream)
- [NATS CLI](https://github.com/nats-io/natscli)
- [Docker Hub](https://hub.docker.com/_/nats)
- [Client Libraries](https://nats.io/download/)
- [NATS by Example](https://natsbyexample.com/)
- [Clustering Guide](https://docs.nats.io/running-a-nats-service/configuration/clustering)
