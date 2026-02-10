# n8n

A powerful workflow automation tool that lets you connect anything to everything. n8n is a free and open-source alternative to Zapier with a fair-code license, allowing you to self-host and customize your automation workflows.

**Official Sites:**
- [n8n](https://n8n.io/) | [Docker Hub](https://hub.docker.com/r/n8nio/n8n)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially ENCRYPTION_KEY)

# Start the services
docker compose -f n8n.yaml up -d
```

## Services

### n8n Application
- **URL**: http://localhost:5678
- **Container**: `n8n_app`
- **Note**: Create your admin account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `n8n_db`
- **Database**: `n8n`
- **Username**: `n8n`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. **Important**: Generate a secure 32-character encryption key:
   ```bash
   # Linux/Mac
   openssl rand -hex 16
   
   # Windows PowerShell
   -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | % {[char]$_})
   ```
3. Update `ENCRYPTION_KEY` in `.env` with the generated key
4. Start the services with `docker compose -f n8n.yaml up -d`
5. Wait for initialization (check logs: `docker logs n8n_app`)
6. Navigate to http://localhost:5678
7. Create your admin account
8. Start building workflows!

## Configuration

### Environment Variables (.env)

- `N8N_PORT` - Web interface port (default: 5678)
- `N8N_HOST` - Hostname for n8n (default: localhost)
- `N8N_PROTOCOL` - Protocol (http or https)
- `WEBHOOK_URL` - Base URL for webhooks (important for external integrations)
- `ENCRYPTION_KEY` - Encryption key for credentials (must be 32 characters)
- `SAVE_ON_ERROR` - Save execution data on error (all, none)
- `SAVE_ON_SUCCESS` - Save execution data on success (all, none)
- `SAVE_MANUAL` - Save manual execution data (true, false)
- `METRICS_ENABLED` - Enable Prometheus metrics (true, false)
- `DB_HOST` - PostgreSQL hostname (use container name)
- `DB_DATABASE` - Database name (default: n8n)
- `DB_USERNAME` - Database username (default: n8n)
- `DB_PASSWORD` - Database password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Webhook Configuration

For webhooks to work with external services, set `WEBHOOK_URL` to your public URL:
```bash
WEBHOOK_URL=https://your-domain.com/
```

## Creating Workflows

### Basic Workflow Structure

1. **Trigger Node**: Starts the workflow (webhook, schedule, manual)
2. **Action Nodes**: Perform operations (HTTP request, database query, etc.)
3. **Logic Nodes**: Control flow (IF, Switch, Merge)
4. **Output Nodes**: Send results (email, Slack, database)

### Example: Simple HTTP Webhook

1. Add a **Webhook** trigger node
2. Set the webhook path (e.g., `/webhook/test`)
3. Add an **HTTP Request** node
4. Configure the HTTP request
5. Add a **Respond to Webhook** node
6. Activate the workflow
7. Test with: `curl -X POST http://localhost:5678/webhook/test`

### Example: Scheduled Task

1. Add a **Schedule Trigger** node
2. Set the cron expression (e.g., `0 9 * * *` for daily at 9 AM)
3. Add action nodes for your task
4. Activate the workflow

### Example: Database to Slack

1. Add a **Schedule Trigger** node
2. Add a **Postgres** node to query data
3. Add an **IF** node to check conditions
4. Add a **Slack** node to send notifications
5. Activate the workflow

## Workflow Features

### Credentials Management

n8n securely stores credentials for various services:
- Navigate to **Credentials** in the menu
- Click **Add Credential**
- Select the service type
- Enter credentials
- Use in workflow nodes

### Error Handling

Add error workflows to handle failures:
1. Click on a node
2. Go to **Settings** → **Error Workflow**
3. Select or create an error workflow
4. The error workflow receives error details

### Workflow Variables

Use expressions to access data:
- `{{ $json.fieldName }}` - Access JSON data
- `{{ $node["NodeName"].json }}` - Access specific node output
- `{{ $now }}` - Current timestamp
- `{{ $env.VARIABLE }}` - Environment variables

### Sub-workflows

Break complex workflows into reusable sub-workflows:
1. Create a workflow with **Execute Workflow Trigger**
2. In main workflow, add **Execute Workflow** node
3. Select the sub-workflow
4. Pass data between workflows

## Integrations

n8n supports 350+ integrations including:

**Communication**: Slack, Discord, Telegram, Email, SMS
**Databases**: PostgreSQL, MySQL, MongoDB, Redis
**Cloud Storage**: Google Drive, Dropbox, AWS S3
**CRM**: Salesforce, HubSpot, Pipedrive
**Development**: GitHub, GitLab, Jira, Jenkins
**Marketing**: Mailchimp, SendGrid, Google Analytics
**Productivity**: Google Sheets, Notion, Airtable

## Webhooks

### Production Webhook URL

For production, configure a reverse proxy (nginx, Traefik) and set:
```bash
N8N_PROTOCOL=https
WEBHOOK_URL=https://your-domain.com/
```

### Testing Webhooks Locally

Use tools like ngrok for local testing:
```bash
ngrok http 5678
# Update WEBHOOK_URL with ngrok URL
```

## Volumes

- `n8n-data` - Workflow data, credentials, and settings
- `n8n-db-data` - PostgreSQL database files

## Common Tasks

### Export Workflows

```bash
# From the UI: Settings → Workflows → Export
# Or via CLI
docker exec n8n_app n8n export:workflow --all --output=/home/node/.n8n/workflows.json
```

### Import Workflows

```bash
# From the UI: Settings → Workflows → Import
# Or via CLI
docker exec n8n_app n8n import:workflow --input=/home/node/.n8n/workflows.json
```

### View Execution History

Navigate to **Executions** in the menu to view:
- Execution status (success, error, waiting)
- Execution time and duration
- Input and output data
- Error messages

### Backup Database

```bash
docker exec n8n_db pg_dump -U n8n n8n > n8n_backup.sql
```

### Restore Database

```bash
cat n8n_backup.sql | docker exec -i n8n_db psql -U n8n n8n
```

### Enable Metrics

Set `METRICS_ENABLED=true` in `.env` and restart. Metrics available at:
```
http://localhost:5678/metrics
```

## API Access

n8n provides a REST API for programmatic access:

### Enable API

Set in `.env`:
```bash
N8N_API_KEY=your-api-key
```

### API Endpoints

```bash
# List workflows
curl -H "X-N8N-API-KEY: your-api-key" http://localhost:5678/api/v1/workflows

# Execute workflow
curl -X POST -H "X-N8N-API-KEY: your-api-key" \
  http://localhost:5678/api/v1/workflows/1/execute

# Get execution
curl -H "X-N8N-API-KEY: your-api-key" \
  http://localhost:5678/api/v1/executions/1
```

## Troubleshooting

### Workflow Not Triggering

- **Symptoms**: Scheduled workflows don't run
- **Solution**: Ensure the workflow is activated (toggle in top-right). Check timezone settings match your expectations.

### Webhook Not Accessible

- **Symptoms**: External services can't reach webhooks
- **Solution**: Verify `WEBHOOK_URL` is set correctly. For production, use a reverse proxy with a public domain.

### Database Connection Failed

- **Symptoms**: "Connection refused" errors on startup
- **Solution**: Wait for PostgreSQL to fully initialize. Check database credentials match in both services.

### Credentials Not Saving

- **Symptoms**: Credentials disappear after restart
- **Solution**: Ensure `ENCRYPTION_KEY` is set and doesn't change between restarts. The key must be exactly 32 characters.

### High Memory Usage

- **Symptoms**: Container using excessive memory
- **Solution**: Limit execution data retention with `SAVE_ON_SUCCESS=none` or configure execution data pruning in settings.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure 32-character encryption key
- Change the PostgreSQL password
- Use HTTPS with a reverse proxy (nginx, Traefik, Caddy)
- Implement authentication (n8n supports basic auth, LDAP, SAML)
- Restrict access with firewall rules
- Enable webhook authentication for sensitive endpoints
- Regular backups are essential
- Keep n8n updated for security patches

### Enable Basic Authentication

Set in `.env`:
```bash
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=secure_password
```

### Webhook Security

Add authentication to webhook nodes:
1. In webhook node settings
2. Enable **Authentication**
3. Choose method (Header Auth, Basic Auth, etc.)
4. Configure credentials

## Resources

- [Official Documentation](https://docs.n8n.io/)
- [Community Forum](https://community.n8n.io/)
- [Workflow Templates](https://n8n.io/workflows/)
- [GitHub Repository](https://github.com/n8n-io/n8n)
- [YouTube Tutorials](https://www.youtube.com/c/n8n-io)
