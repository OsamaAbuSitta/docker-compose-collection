# Mattermost

An open-source, self-hosted Slack alternative. Mattermost is a secure collaboration platform that offers team messaging, file sharing, search, and integrations. Perfect for teams that need full control over their communication data.

**Official Sites:**
- [Mattermost](https://mattermost.com/) | [Docker Hub](https://hub.docker.com/r/mattermost/mattermost-team-edition)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f mattermost.yaml up -d
```

## Services

### Mattermost Application
- **URL**: http://localhost:8065
- **Container**: `mattermost_app`
- **Note**: Create your admin account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `mattermost_db`
- **Database**: `mattermost`
- **Username**: `mattermost`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f mattermost.yaml up -d`
3. Wait for initialization (check logs: `docker logs mattermost_app`)
4. Navigate to http://localhost:8065
5. Create your admin account (first user becomes admin)
6. Complete the setup wizard
7. Create your first team

## Configuration

### Environment Variables (.env)

- `MATTERMOST_PORT` - Web interface port (default: 8065)
- `SITE_URL` - The URL where Mattermost is accessible
- `DB_HOST` - Database hostname (use container name)
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports or add environment variables. Configuration can also be modified through the System Console in the web interface. See the [official documentation](https://docs.mattermost.com/) for all available options.

## Volumes

- `mattermost-config` - Configuration files
- `mattermost-data` - User data and uploads
- `mattermost-logs` - Application logs
- `mattermost-plugins` - Installed plugins
- `mattermost-client-plugins` - Client-side plugins
- `mattermost-db-data` - PostgreSQL database files

## Common Tasks

### Create a Team

1. Log in as admin
2. Click the team menu (top left)
3. Select "Create a Team"
4. Enter team name and URL
5. Invite team members via email or share the invite link

### Create a Channel

1. Click the "+" next to "Channels" in the sidebar
2. Select "Create New Channel"
3. Choose Public or Private
4. Enter channel name and description
5. Click "Create Channel"

### Install a Plugin

1. Navigate to System Console (gear icon)
2. Go to "Plugins" → "Plugin Management"
3. Upload plugin file or install from marketplace
4. Enable the plugin
5. Configure plugin settings if needed

### Backup Data

```bash
# Backup database
docker exec mattermost_db pg_dump -U mattermost mattermost > mattermost_backup.sql

# Backup data directory
docker run --rm -v mattermost-data:/data -v $(pwd):/backup alpine tar czf /backup/mattermost_data.tar.gz /data
```

### Restore Database

```bash
cat mattermost_backup.sql | docker exec -i mattermost_db psql -U mattermost mattermost
```

### Update Mattermost

```bash
# Pull the latest image
docker compose -f mattermost.yaml pull

# Restart with new image
docker compose -f mattermost.yaml up -d
```

## Features

- **Team Messaging**: Organized channels for team communication
- **Direct Messages**: One-on-one and group messaging
- **File Sharing**: Share files, images, and documents
- **Search**: Full-text search across messages and files
- **Integrations**: Webhooks, slash commands, and bot accounts
- **Mobile Apps**: iOS and Android apps available
- **Desktop Apps**: Windows, Mac, and Linux desktop clients
- **Plugins**: Extend functionality with plugins
- **Compliance**: Message retention and export features
- **Notifications**: Desktop, email, and mobile push notifications

## Integrations

Mattermost supports various integrations:

- **Incoming Webhooks**: Post messages from external applications
- **Outgoing Webhooks**: Trigger external applications from messages
- **Slash Commands**: Create custom commands
- **Bot Accounts**: Automated user accounts for integrations
- **OAuth 2.0**: Single sign-on with external providers
- **Plugins**: GitHub, Jira, Zoom, and many more

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs mattermost_app`. Ensure database is running and accessible.

### Database Connection Failed

- **Symptoms**: "Cannot connect to database" error
- **Solution**: Verify DB_HOST matches the database container name. Check database credentials.

### Cannot Upload Files

- **Symptoms**: File upload fails
- **Solution**: Check volume permissions. Ensure the data volume is writable.

### Email Notifications Not Working

- **Symptoms**: Users don't receive email notifications
- **Solution**: Configure SMTP settings in System Console → Environment → SMTP.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the database password
- Use HTTPS with a reverse proxy
- Configure SMTP for email notifications
- Set up proper authentication (LDAP, SAML, OAuth)
- Restrict access with firewall rules
- Regular backups are essential
- Enable rate limiting and security features in System Console

## Resources

- [Official Documentation](https://docs.mattermost.com/)
- [Plugin Marketplace](https://mattermost.com/marketplace/)
- [GitHub Repository](https://github.com/mattermost/mattermost-server)
- [Docker Hub](https://hub.docker.com/r/mattermost/mattermost-team-edition)
