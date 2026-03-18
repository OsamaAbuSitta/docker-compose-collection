# Huginn

Create agents that monitor and act on your behalf. Huginn is a system for building agents that perform automated tasks for you online, similar to IFTTT or Zapier but self-hosted and more powerful.

**Official Sites:**
- [Huginn](https://github.com/huginn/huginn) | [Docker Hub](https://hub.docker.com/r/huginn/huginn)

## Quick Start

```bash
docker compose -f huginn.yaml up -d
```

## Services

### Huginn
- **URL**: http://localhost:3000
- **Container**: `huginn`
- **Default Username**: `admin`
- **Default Password**: `password`

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `huginn_db`
- **Database**: `huginn`
- **Username**: `huginn`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Start the services with `docker compose -f huginn.yaml up -d`
2. Wait for initialization (check logs: `docker logs huginn`)
3. Navigate to http://localhost:3000
4. Log in with default credentials (admin/password)
5. **Important**: Change the admin password immediately
6. Start creating agents and scenarios

## Volumes

- `huginn-data` - Agent data and configurations
- `huginn-db-data` - PostgreSQL database files

## Common Tasks

### Create Your First Agent

1. Click "Agents" in the navigation
2. Click "New Agent"
3. Choose an agent type (e.g., Website Agent, Email Agent)
4. Configure the agent:
   - Set schedule (how often it runs)
   - Configure options (URLs, selectors, etc.)
   - Set up events to emit
5. Save and enable the agent

### Build a Workflow (Scenario)

```bash
# Example: Monitor website and send email
# 1. Create Website Agent to scrape a page
# 2. Create Trigger Agent to filter results
# 3. Create Email Agent to send notifications
# 4. Connect agents in a scenario
```

### Example Agents

**RSS Feed Monitor**:
```json
{
  "expected_update_period_in_days": "2",
  "clean": "false",
  "url": "https://example.com/feed.xml"
}
```

**Website Scraper**:
```json
{
  "expected_update_period_in_days": "2",
  "url": "https://example.com",
  "type": "html",
  "mode": "on_change",
  "extract": {
    "title": {"css": "h1", "value": "string(.)"},
    "price": {"css": ".price", "value": "string(.)"}
  }
}
```

### Backup Agents and Data

```bash
# Backup the database
docker exec huginn_db pg_dump -U huginn huginn > huginn_backup.sql
```

### Restore Data

```bash
# Restore from backup
cat huginn_backup.sql | docker exec -i huginn_db psql -U huginn huginn
```

### View Agent Logs

```bash
# View Huginn logs
docker logs huginn

# View specific agent activity in the web UI
# Navigate to Agents > [Agent Name] > Events
```

## Configuration

### Environment Variables

**Database Configuration**:
- `DATABASE_HOST` - Database hostname
- `DATABASE_NAME` - Database name
- `DATABASE_USERNAME` - Database username
- `DATABASE_PASSWORD` - Database password

**Application Configuration**:
- `APP_SECRET_TOKEN` - Secret token for sessions (must be 32+ characters)
- `DOMAIN` - Domain where Huginn is accessible

**SMTP Configuration** (for email agents):
- `SMTP_SERVER` - SMTP server address
- `SMTP_PORT` - SMTP port (usually 587)
- `SMTP_USER_NAME` - SMTP username
- `SMTP_PASSWORD` - SMTP password
- `SMTP_DOMAIN` - Email domain

### Generate Secret Token

```bash
# Generate a secure secret token
openssl rand -hex 32
```

Replace `APP_SECRET_TOKEN` in the compose file with the generated value.

### Configure Email Notifications

1. Set SMTP environment variables in the compose file
2. Restart the container
3. Create Email Agent in the web UI
4. Configure recipient and message template

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:3000
- **Solution**: Wait for initialization to complete. Check logs with `docker logs huginn`.

### Database Connection Failed

- **Symptoms**: Huginn shows database errors
- **Solution**: Ensure the database container is running. Verify DATABASE_HOST matches the database container name.

### Agents Not Running

- **Symptoms**: Agents show as disabled or not executing
- **Solution**: Check agent schedule. Ensure agents are enabled. Review agent logs for errors.

### Email Notifications Not Sending

- **Symptoms**: Email agents don't send messages
- **Solution**: Verify SMTP configuration. Test SMTP credentials. Check email agent configuration.

## Agent Types

Huginn includes many built-in agent types:

- **Website Agent**: Scrape websites and extract data
- **RSS Agent**: Monitor RSS/Atom feeds
- **Email Agent**: Send email notifications
- **Trigger Agent**: Filter and transform events
- **Post Agent**: Make HTTP POST requests
- **Twitter Agent**: Monitor and post tweets
- **Webhook Agent**: Receive webhooks
- **Weather Agent**: Get weather forecasts
- **Peak Detector Agent**: Detect anomalies in data
- **JavaScript Agent**: Custom logic with JavaScript
- And many more...

## Use Cases

- **Price Monitoring**: Track product prices and get alerts
- **News Aggregation**: Collect news from multiple sources
- **Social Media Automation**: Auto-post to Twitter, etc.
- **Home Automation**: Integrate with IoT devices
- **Data Collection**: Scrape and aggregate data
- **Workflow Automation**: Chain multiple actions
- **API Integration**: Connect different services
- **Monitoring**: Track website changes and uptime

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the default admin password immediately
- Generate a secure APP_SECRET_TOKEN (32+ characters)
- Change the database password
- Configure SMTP for email notifications
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential

## Resources

- [Official Documentation](https://github.com/huginn/huginn/wiki)
- [Agent Types](https://github.com/huginn/huginn/wiki/Agent-Types)
- [GitHub Repository](https://github.com/huginn/huginn)
- [Docker Hub](https://hub.docker.com/r/huginn/huginn)
