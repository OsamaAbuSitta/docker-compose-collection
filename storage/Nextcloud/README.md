# Nextcloud

A self-hosted productivity platform that keeps you in control. Nextcloud provides file sync and share, online collaboration, calendar, contacts, mail, and much more - all in one place with complete privacy and security.

**Official Sites:**
- [Nextcloud](https://nextcloud.com/) | [Docker Hub](https://hub.docker.com/_/nextcloud)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially passwords)

# Create data directory
mkdir -p data

# Start the service
docker compose -f nextcloud.yaml up -d
```

## Services

### Nextcloud
- **URL**: http://localhost:8080
- **Container**: `nextcloud`
- **Username**: `admin` (configurable)
- **Password**: `P@ss0rd123` (change in .env)

### PostgreSQL Database
- **Container**: `nextcloud_db`
- **Database**: `nextcloud`
- **Username**: `nextcloud`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Container**: `nextcloud_redis`
- **Description**: Caching and file locking

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Change `ADMIN_PASSWORD` to a strong password
   - Change `POSTGRES_PASSWORD` to a strong password
   - Set `TRUSTED_DOMAINS` to your domain(s)

2. Create data directory:
   ```bash
   mkdir -p data
   ```

3. Start the services:
   ```bash
   docker compose -f nextcloud.yaml up -d
   ```

4. Wait for initialization (first start takes a few minutes):
   ```bash
   docker logs -f nextcloud
   ```

5. Access Nextcloud at http://localhost:8080

6. Log in with your admin credentials

7. Complete the setup wizard

## Configuration

### Environment Variables (.env)

- `NEXTCLOUD_PORT` - Web interface port (default: 8080)
- `TZ` - Timezone for the container (default: UTC)
- `ADMIN_USER` - Admin username (default: admin)
- `ADMIN_PASSWORD` - Admin password (change for production!)
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production!)
- `POSTGRES_DB` - Database name
- `TRUSTED_DOMAINS` - Trusted domains (comma-separated)
- `DATA_DIR` - Data directory path (default: ./data)

### Trusted Domains

Add your domain to trusted domains:
```bash
# In .env file
TRUSTED_DOMAINS=localhost,nextcloud.example.com,192.168.1.100
```

## Using Nextcloud

### File Management

- **Upload**: Drag and drop files or click the + button
- **Share**: Right-click files/folders and select Share
- **Sync**: Install desktop/mobile clients for automatic sync
- **Versions**: Access previous versions of files
- **Trash**: Recover deleted files from the trash

### Collaboration

- **Online Editing**: Edit documents directly in the browser
- **Comments**: Add comments to files
- **Notifications**: Get notified of changes
- **Activity**: Track file and folder activity

### Apps

Install apps from the Nextcloud App Store:
- **OnlyOffice**: Document editing
- **Collabora**: Alternative document editor
- **Calendar**: Manage calendars
- **Contacts**: Address book
- **Mail**: Email client
- **Talk**: Video calls and chat
- **Deck**: Kanban boards
- **Notes**: Note-taking
- **Tasks**: Task management

## Volumes

- `nextcloud-data` - Nextcloud application files
- `nextcloud-db-data` - PostgreSQL database files
- `nextcloud-redis-data` - Redis cache data
- `data` - User files and data (mounted from host)

## Common Tasks

### Install Apps

```bash
# Via web interface:
# 1. Click your profile icon
# 2. Select "Apps"
# 3. Browse and install apps

# Via command line:
docker exec -u www-data nextcloud php occ app:install app_name
```

### Add Users

```bash
# Via web interface:
# Settings → Users → Add user

# Via command line:
docker exec -u www-data nextcloud php occ user:add username
```

### Backup Data

```bash
# Backup database
docker exec nextcloud_db pg_dump -U nextcloud nextcloud > nextcloud_backup.sql

# Backup data directory
tar czf nextcloud_data_backup.tar.gz ./data

# Backup config
docker cp nextcloud:/var/www/html/config ./config_backup
```

### Restore from Backup

```bash
# Restore database
docker exec -i nextcloud_db psql -U nextcloud nextcloud < nextcloud_backup.sql

# Restore data
tar xzf nextcloud_data_backup.tar.gz

# Restore config
docker cp ./config_backup nextcloud:/var/www/html/config
```

### Run Maintenance

```bash
# Run maintenance mode
docker exec -u www-data nextcloud php occ maintenance:mode --on

# Update database indices
docker exec -u www-data nextcloud php occ db:add-missing-indices

# Scan files
docker exec -u www-data nextcloud php occ files:scan --all

# Exit maintenance mode
docker exec -u www-data nextcloud php occ maintenance:mode --off
```

### Update Nextcloud

```bash
# Via web interface:
# Settings → Overview → Update

# Via command line:
docker exec -u www-data nextcloud php occ upgrade
```

## Desktop and Mobile Clients

### Desktop Clients
- **Windows**: Download from nextcloud.com
- **macOS**: Download from nextcloud.com or App Store
- **Linux**: Available in most package managers

### Mobile Clients
- **Android**: Google Play Store
- **iOS**: Apple App Store

Configure clients with:
- Server URL: http://localhost:8080 (or your domain)
- Username and password

## Features

- **File Sync and Share**: Automatic synchronization across devices
- **Online Collaboration**: Real-time document editing
- **Calendar and Contacts**: CalDAV and CardDAV support
- **Mail**: IMAP email client
- **Video Calls**: Built-in video conferencing
- **End-to-End Encryption**: Secure your sensitive files
- **Two-Factor Authentication**: Enhanced security
- **External Storage**: Connect to external storage services
- **Versioning**: Keep file history
- **Activity Tracking**: Monitor file changes
- **Theming**: Customize appearance
- **Federation**: Share with other Nextcloud servers

## Integration

### WebDAV Access

```bash
# WebDAV URL
http://localhost:8080/remote.php/dav/files/USERNAME/

# Mount in file manager (Linux)
davs://localhost:8080/remote.php/dav/files/USERNAME/
```

### CalDAV/CardDAV

```bash
# Calendar URL
http://localhost:8080/remote.php/dav/calendars/USERNAME/

# Contacts URL
http://localhost:8080/remote.php/dav/addressbooks/users/USERNAME/
```

### API Access

```bash
# Example: Upload file via API
curl -u username:password -T file.txt \
  http://localhost:8080/remote.php/dav/files/username/file.txt
```

## Troubleshooting

### Cannot Access Web Interface

- Check port 8080 is not in use
- Verify container is running: `docker ps`
- Check logs: `docker logs nextcloud`
- Verify trusted domains configuration

### Database Connection Errors

- Ensure database container is running
- Check database credentials in .env
- Verify network connectivity
- Check PostgreSQL logs

### Slow Performance

- Increase PHP memory limit
- Enable Redis caching (already configured)
- Use SSD storage
- Increase container resources
- Enable APCu caching

### File Upload Issues

- Check PHP upload limits
- Verify disk space
- Check file permissions
- Review nginx/Apache configuration

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change all default passwords
- Use HTTPS with valid SSL certificates
- Enable two-factor authentication
- Set strong admin password
- Restrict access with firewall rules
- Keep Nextcloud updated
- Regular backups are essential
- Use strong database passwords
- Configure proper trusted domains
- Enable brute-force protection

## Resources

- [Official Documentation](https://docs.nextcloud.com/)
- [Admin Manual](https://docs.nextcloud.com/server/latest/admin_manual/)
- [User Manual](https://docs.nextcloud.com/server/latest/user_manual/)
- [App Store](https://apps.nextcloud.com/)
- [Community Forum](https://help.nextcloud.com/)
- [Docker Hub](https://hub.docker.com/_/nextcloud)
