# GitLab

GitLab is a complete DevOps platform delivered as a single application, providing Git repository management, CI/CD pipelines, issue tracking, code review, and more. This configuration includes GitLab Community Edition with PostgreSQL and Redis backends.

**Official Sites:**
- [GitLab](https://about.gitlab.com/) | [Docker Hub](https://hub.docker.com/r/gitlab/gitlab-ce)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start GitLab
docker compose -f gitlab.yaml up -d
```

## Services

### GitLab CE
- **HTTP URL**: http://localhost:8929
- **HTTPS URL**: https://localhost:8943
- **SSH Port**: 2222
- **Container**: `gitlab_container`
- **Username**: `root`
- **Password**: `P@ssw0rd@123` (configured in .env)

### PostgreSQL Database
- **Port**: 5432 (internal only)
- **Container**: `gitlab_postgres`
- **Database**: `gitlabhq_production`
- **Username**: `gitlab`
- **Password**: `P@ssw0rd@123`

### Redis Cache
- **Port**: 6379 (internal only)
- **Container**: `gitlab_redis`

## Initial Setup

1. Copy `.env.example` to `.env` and configure your settings
2. **Important**: Change `GITLAB_ROOT_PASSWORD` to a secure password
3. Start the services with `docker compose -f gitlab.yaml up -d`
4. Wait 5-10 minutes for GitLab to initialize (first startup is slow)
5. Check initialization progress: `docker logs -f gitlab_container`
6. Navigate to http://localhost:8929 (or your configured port)
7. Log in with username `root` and your configured password
8. Complete the initial setup wizard

## Configuration

### Environment Variables (.env)

- `GITLAB_HTTP_PORT` - HTTP web interface port (default: 8929)
- `GITLAB_HTTPS_PORT` - HTTPS web interface port (default: 8943)
- `GITLAB_SSH_PORT` - SSH Git operations port (default: 2222)
- `GITLAB_HOSTNAME` - GitLab hostname (default: gitlab.local)
- `GITLAB_ROOT_PASSWORD` - Initial root user password (change for production)
- `POSTGRES_USER` - PostgreSQL username (default: gitlab)
- `POSTGRES_PASSWORD` - PostgreSQL password (change for production)
- `POSTGRES_DB` - PostgreSQL database name (default: gitlabhq_production)
- `TZ` - Timezone (default: UTC)

### Custom Configuration

GitLab can be further configured by modifying the `GITLAB_OMNIBUS_CONFIG` environment variable in the compose file. See the [GitLab Omnibus documentation](https://docs.gitlab.com/omnibus/settings/) for available options.

## Connecting to GitLab

### HTTP/HTTPS Access
```
http://localhost:8929
https://localhost:8943
```

### SSH Git Operations
```bash
# Clone a repository via SSH
git clone ssh://git@localhost:2222/username/repository.git

# Configure SSH for custom port
# Add to ~/.ssh/config:
Host gitlab.local
  HostName localhost
  Port 2222
  User git
```

### From Application
```yaml
# GitLab CI/CD configuration example
variables:
  GITLAB_URL: "http://gitlab_container"
```

## Volumes

- `gitlab-config` - GitLab configuration files (/etc/gitlab)
- `gitlab-logs` - GitLab log files (/var/log/gitlab)
- `gitlab-data` - GitLab data including repositories (/var/opt/gitlab)
- `gitlab-postgres-data` - PostgreSQL database files
- `gitlab-redis-data` - Redis cache data

## Common Tasks

### Create a New Project
1. Log in to GitLab web interface
2. Click "New project" button
3. Choose "Create blank project"
4. Enter project name and visibility level
5. Click "Create project"

### Configure CI/CD Pipeline
1. Create `.gitlab-ci.yml` in your repository root
2. Define stages, jobs, and scripts
3. Commit and push to trigger the pipeline
4. View pipeline status in the CI/CD section

### Add SSH Key
1. Generate SSH key: `ssh-keygen -t ed25519 -C "your_email@example.com"`
2. Copy public key: `cat ~/.ssh/id_ed25519.pub`
3. In GitLab, go to User Settings > SSH Keys
4. Paste the public key and click "Add key"

### Configure GitLab Runner
```bash
# Register a runner
docker exec -it gitlab_container gitlab-runner register

# Follow the prompts:
# - GitLab URL: http://gitlab_container
# - Registration token: (from GitLab Admin > Runners)
# - Description: My Runner
# - Tags: docker, linux
# - Executor: docker
# - Default image: alpine:latest
```

### Backup GitLab
```bash
# Create a backup
docker exec -it gitlab_container gitlab-backup create

# Backups are stored in /var/opt/gitlab/backups
# Access them from the gitlab-data volume
```

### Restore from Backup
```bash
# Copy backup file to container
docker cp backup_file.tar gitlab_container:/var/opt/gitlab/backups/

# Stop services
docker exec -it gitlab_container gitlab-ctl stop puma
docker exec -it gitlab_container gitlab-ctl stop sidekiq

# Restore
docker exec -it gitlab_container gitlab-backup restore BACKUP=timestamp

# Restart GitLab
docker exec -it gitlab_container gitlab-ctl restart
```

## Features

- **Git Repository Management**: Host unlimited Git repositories
- **CI/CD Pipelines**: Automated testing and deployment
- **Issue Tracking**: Built-in issue and project management
- **Code Review**: Merge requests with inline comments
- **Wiki**: Project documentation
- **Container Registry**: Docker image registry
- **Package Registry**: npm, Maven, PyPI, and more
- **Security Scanning**: SAST, DAST, dependency scanning
- **Auto DevOps**: Automated CI/CD configuration

## Troubleshooting

### GitLab Takes Long to Start
- **Symptoms**: Container starts but web interface not accessible
- **Solution**: GitLab initialization takes 5-10 minutes on first start. Check logs: `docker logs -f gitlab_container`

### Cannot Connect via SSH
- **Symptoms**: SSH connection refused on port 2222
- **Solution**: Ensure `GITLAB_SSH_PORT` is correctly configured and not blocked by firewall. Verify SSH is enabled in GitLab settings.

### Database Connection Errors
- **Symptoms**: GitLab fails to start with database errors
- **Solution**: Ensure PostgreSQL container is healthy. Check credentials match between GitLab and PostgreSQL configuration.

### Out of Memory Errors
- **Symptoms**: GitLab crashes or becomes unresponsive
- **Solution**: GitLab requires at least 4GB RAM. Increase Docker memory limit or add swap space.

### 502 Bad Gateway
- **Symptoms**: Web interface shows 502 error
- **Solution**: GitLab services may still be starting. Wait a few minutes and refresh. Check logs for specific errors.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the root password immediately after first login
- Generate and use strong passwords for all accounts
- Configure HTTPS with valid SSL certificates
- Set up regular automated backups
- Enable two-factor authentication for all users
- Configure firewall rules to restrict access
- Use a proper domain name instead of localhost
- Review and harden GitLab security settings
- Keep GitLab updated to the latest version
- Configure email notifications for security events

## Resources

- [GitLab Documentation](https://docs.gitlab.com/)
- [GitLab CI/CD Documentation](https://docs.gitlab.com/ee/ci/)
- [GitLab Omnibus Configuration](https://docs.gitlab.com/omnibus/settings/)
- [Docker Hub](https://hub.docker.com/r/gitlab/gitlab-ce)
- [GitLab Runner Documentation](https://docs.gitlab.com/runner/)
