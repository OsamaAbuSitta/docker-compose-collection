# Actual Budget

A local-first personal finance tool based on zero-based budgeting. Actual Budget is a super fast and privacy-focused app for managing your finances with a beautiful interface and powerful features.

**Official Sites:**
- [Actual Budget](https://actualbudget.org/) | [Docker Hub](https://hub.docker.com/r/actualbudget/actual-server)

## Quick Start

```bash
docker compose -f actual-budget.yaml up -d
```

## Services

### Actual Budget Server
- **URL**: http://localhost:5006
- **Container**: `actual_budget`
- **Note**: No authentication required by default (local-first design)

## Initial Setup

1. Start the service with `docker compose -f actual-budget.yaml up -d`
2. Navigate to http://localhost:5006
3. Create your first budget file
4. Set up your accounts and categories
5. Start tracking your transactions

## Volumes

- `actual-data` - Budget files and application data

## Common Tasks

### Create a New Budget

1. Click "Create new file" on the home screen
2. Name your budget
3. Set up your accounts (checking, savings, credit cards, etc.)
4. Create budget categories
5. Start entering transactions

### Import Transactions

```bash
# Use the web UI to import transactions
# Supports OFX, QFX, and CSV formats
# Navigate to Account > Import transactions
```

### Backup Budget Files

```bash
# Backup the data volume
docker run --rm -v actual-data:/data -v $(pwd):/backup alpine tar czf /backup/actual-backup.tar.gz /data
```

### Restore Budget Files

```bash
# Restore from backup
docker run --rm -v actual-data:/data -v $(pwd):/backup alpine tar xzf /backup/actual-backup.tar.gz -C /
```

### Sync Across Devices

Actual Budget supports end-to-end encrypted sync. Configure sync in the application settings to access your budget from multiple devices.

## Configuration

### Environment Variables

- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Port

To change the port, modify the ports section in the compose file:

```yaml
ports:
  - "8080:5006"  # Access on port 8080 instead
```

### Enable Password Protection

For additional security, you can set up a reverse proxy with authentication or use Actual's built-in password protection feature (configure in the web UI).

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:5006
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### Budget File Not Saving

- **Symptoms**: Changes are lost after restart
- **Solution**: Verify the volume is properly mounted. Check container logs with `docker logs actual_budget`.

### Sync Not Working

- **Symptoms**: Cannot sync between devices
- **Solution**: Ensure the server is accessible from all devices. Check firewall rules and network configuration.

## Features

- **Zero-Based Budgeting**: Assign every dollar a job
- **Local-First**: Your data stays on your device
- **Fast Performance**: Instant updates and calculations
- **Bank Sync**: Import transactions from your bank (via SimpleFIN)
- **Reports**: Visualize your spending with charts and graphs
- **Multi-Device Sync**: End-to-end encrypted synchronization
- **Mobile Apps**: Available for iOS and Android

## Security Notes

⚠️ **Important**: Actual Budget is designed for local use. For production/remote access:
- Use a reverse proxy with HTTPS
- Enable password protection in the application
- Restrict access with firewall rules
- Consider using a VPN for remote access

## Resources

- [Official Documentation](https://actualbudget.org/docs/)
- [GitHub Repository](https://github.com/actualbudget/actual)
- [Docker Hub](https://hub.docker.com/r/actualbudget/actual-server)
- [Community Forum](https://actualbudget.org/community/)
