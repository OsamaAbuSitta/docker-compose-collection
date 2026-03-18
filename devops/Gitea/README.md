# Gitea

Gitea is a painless self-hosted Git service written in Go. It's a lightweight alternative to GitLab and GitHub, providing Git repository hosting, code review, team collaboration, and package registry features with minimal resource requirements.

**Official Sites:**
- [Gitea](https://gitea.io/) | [Docker Hub](https://hub.docker.com/r/gitea/gitea)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start Gitea
docker compose -f gitea.yaml up -d
```

## Services

### Gitea
- **URL**: http://localhost:3000
- **SSH Port**: 2223
- **Container**: `gitea_container`
- **Initial Setup**: Complete via web interface on first access

### PostgreSQL Database
- **Port**: 5432 (internal only)
- **Container**: `gitea_db`
- **Database**: `gitea`
- **Username**: `gitea`
- **Password**: `P@ssw0rd@123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure your settings
2. **Important**: Generate secure keys for production:
   ```bash
   # Generate SECRET_KEY (64+ characters)
   openssl rand -base64 48
   
   # Generate INTERNAL_TOKEN
   docker run --rm gitea/gitea:latest gitea generate secret INTERNAL_TOKEN
   ```
3. Update `GITEA_SECRET_KEY` and `GITEA_INTERNAL_TOKEN` in `.env`
4. Start the services with `docker compose -f gitea.yaml up -d`
5. Navigate to http://localhost:3000
6. Complete the installation wizard:
   - Database settings are pre-configured
   - Set up the administrator account
   - Configure server and optional settings
7. After setup, set `GITEA_INSTALL_LOCK=true` in `.env` and restart

## Configuration

### Environment Variables (.env)

- `GITEA_HTTP_PORT` - HTTP web interface port (default: 3000)
- `GITEA_SSH_PORT` - SSH Git operations port (default: 2223)
- `GITEA_DOMAIN` - Gitea domain name (default: localhost)
- `USER_UID` - User ID for file permissions (default: 1000)
- `USER_GID` - Group ID for file permissions (default: 1000)
- `GITEA_SECRET_KEY` - Secret key for encryption (change for production, min 64 chars)
- `GITEA_INTERNAL_TOKEN` - Internal API token (change for production)
- `GITEA_INSTALL_LOCK` - Prevent reinstallation (set to true after setup)
- `POSTGRES_USER` - PostgreSQL username (default: gitea)
- `POSTGRES_PASSWORD` - PostgreSQL password (change for production)
- `POSTGRES_DB` - PostgreSQL database name (default: gitea)
- `TZ` - Timezone (default: UTC)

### Custom Configuration

Advanced configuration can be done by editing the `app.ini` file in the Gitea data volume or through the web interface admin panel. See the [Gitea Configuration Cheat Sheet](https://docs.gitea.io/en-us/config-cheat-sheet/) for available options.

## Connecting to Gitea

### HTTP Access
```
http://localhost:3000
```

### SSH Git Operations
```bash
# Clone a repository via SSH
git clone ssh://git@localhost:2223/username/repository.git

# Configure SSH for custom port
# Add to ~/.ssh/config:
Host gitea.local
  HostName localhost
  Port 2223
  User git
```

### From Application
```yaml
# API access example
api_url: "http://gitea_container:3000/api/v1"
```

## Volumes

- `gitea-data` - Gitea application data including repositories, configuration, and uploads
- `gitea-db-data` - PostgreSQL database files

## Common Tasks

### Create a New Repository
1. Log in to Gitea web interface
2. Click the "+" icon in the top right
3. Select "New Repository"
4. Enter repository name and settings
5. Click "Create Repository"

### Add SSH Key
1. Generate SSH key: `ssh-keygen -t ed25519 -C "your_email@example.com"`
2. Copy public key: `cat ~/.ssh/id_ed25519.pub`
3. In Gitea, go to Settings > SSH / GPG Keys
4. Click "Add Key"
5. Paste the public key and click "Add Key"

### Create Organization
1. Click the "+" icon in the top right
2. Select "New Organization"
3. Enter organization name and settings
4. Click "Create Organization"

### Set Up Webhooks
1. Go to repository Settings > Webhooks
2. Click "Add Webhook"
3. Select webhook type (Gitea, Slack, Discord, etc.)
4. Enter payload URL and configure settings
5. Click "Add Webhook"

### Enable Actions (CI/CD)
1. Go to Site Administration > Configuration
2. Enable "Enable Repository Actions"
3. Create `.gitea/workflows/` directory in your repository
4. Add workflow YAML files
5. Push to trigger workflows

### Backup Gitea
```bash
# Create a backup
docker exec -u git gitea_container gitea dump -c /data/gitea/conf/app.ini

# Backup file will be created in /data/gitea-dump-*.zip
# Copy from container to host
docker cp gitea_container:/data/gitea-dump-*.zip ./backup/
```

### Restore from Backup
```bash
# Stop Gitea
docker compose -f gitea.yaml down

# Extract backup to data volume
docker run --rm -v gitea-data:/data -v $(pwd):/backup alpine sh -c "cd /data && unzip /backup/gitea-dump-*.zip"

# Start Gitea
docker compose -f gitea.yaml up -d
```

## Features

- **Git Repository Hosting**: Unlimited repositories with full Git support
- **Code Review**: Pull requests with inline comments
- **Issue Tracking**: Built-in issue management
- **Wiki**: Repository wikis with markdown support
- **Organizations**: Team and organization management
- **Package Registry**: Docker, npm, Maven, PyPI, and more
- **Actions**: Built-in CI/CD (similar to GitHub Actions)
- **Webhooks**: Integration with external services
- **API**: RESTful API for automation
- **Lightweight**: Low resource requirements (runs on Raspberry Pi)
- **Migration**: Import from GitHub, GitLab, and other services

## Troubleshooting

### Cannot Access Web Interface
- **Symptoms**: Connection refused or timeout
- **Solution**: Ensure container is running: `docker ps`. Check logs: `docker logs gitea_container`

### SSH Connection Issues
- **Symptoms**: SSH connection refused on port 2223
- **Solution**: Verify `GITEA_SSH_PORT` is correctly configured. Ensure port is not blocked by firewall.

### Database Connection Errors
- **Symptoms**: Gitea fails to start with database errors
- **Solution**: Ensure PostgreSQL container is healthy. Verify credentials match between Gitea and PostgreSQL configuration.

### Permission Denied Errors
- **Symptoms**: Cannot write to repositories or upload files
- **Solution**: Check `USER_UID` and `USER_GID` match your host user. Fix permissions: `docker exec gitea_container chown -R git:git /data`

### Installation Wizard Reappears
- **Symptoms**: Setup wizard shows after initial configuration
- **Solution**: Set `GITEA_INSTALL_LOCK=true` in `.env` and restart the container.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate and use secure SECRET_KEY (minimum 64 characters)
- Generate and use secure INTERNAL_TOKEN
- Change all default passwords
- Set `GITEA_INSTALL_LOCK=true` after initial setup
- Configure HTTPS with valid SSL certificates
- Set up regular automated backups
- Enable two-factor authentication for all users
- Configure firewall rules to restrict access
- Use a proper domain name instead of localhost
- Review and harden Gitea security settings
- Keep Gitea updated to the latest version
- Disable user registration if not needed

## Resources

- [Gitea Documentation](https://docs.gitea.io/)
- [Configuration Cheat Sheet](https://docs.gitea.io/en-us/config-cheat-sheet/)
- [API Documentation](https://docs.gitea.io/en-us/api-usage/)
- [Docker Hub](https://hub.docker.com/r/gitea/gitea)
- [Gitea Actions Documentation](https://docs.gitea.io/en-us/usage/actions/overview/)
