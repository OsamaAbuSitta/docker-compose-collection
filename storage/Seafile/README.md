# Seafile

An open-source cloud storage system with file encryption and group sharing. Seafile provides a reliable and high-performance file sync and share solution with advanced features like file locking, version control, and online collaboration.

**Official Sites:**
- [Seafile](https://www.seafile.com/) | [Docker Hub](https://hub.docker.com/r/seafileltd/seafile-mc)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially passwords)

# Start the service
docker compose -f seafile.yaml up -d
```

## Services

### Seafile
- **URL**: http://localhost
- **Container**: `seafile`
- **Email**: `admin@example.com` (configurable)
- **Password**: `P@ss0rd123` (change in .env)

### MariaDB Database
- **Container**: `seafile_db`
- **Root Password**: `P@ssw0rd@123`

### Memcached
- **Container**: `seafile_memcached`
- **Description**: Caching layer

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Change `ADMIN_EMAIL` to your email
   - Change `ADMIN_PASSWORD` to a strong password
   - Change `MYSQL_ROOT_PASSWORD` to a strong password
   - Set `SERVER_HOSTNAME` to your domain or IP

2. Start the services:
   ```bash
   docker compose -f seafile.yaml up -d
   ```

3. Wait for initialization (first start takes a few minutes):
   ```bash
   docker logs -f seafile
   ```

4. Access Seafile at http://localhost

5. Log in with your admin credentials

## Configuration

### Environment Variables (.env)

- `SEAFILE_PORT` - HTTP port (default: 80)
- `SEAFILE_HTTPS_PORT` - HTTPS port (default: 443)
- `TZ` - Timezone (default: UTC)
- `ADMIN_EMAIL` - Admin email address
- `ADMIN_PASSWORD` - Admin password (change for production!)
- `MYSQL_ROOT_PASSWORD` - Database root password (change for production!)
- `SERVER_HOSTNAME` - Server hostname or IP

## Using Seafile

### Libraries

Seafile organizes files into libraries (like repositories):
- **Create Library**: Click "New Library"
- **Share Library**: Right-click library → Share
- **Encrypt Library**: Enable encryption when creating
- **Sync Library**: Use desktop client to sync

### File Management

- **Upload**: Drag and drop files
- **Download**: Click file → Download
- **Share**: Right-click file → Share link
- **Version**: View file history and restore versions
- **Lock**: Lock files to prevent concurrent editing

### Collaboration

- **Groups**: Create groups for team collaboration
- **Permissions**: Set read/write permissions
- **Comments**: Add comments to files
- **Notifications**: Get notified of changes

## Desktop and Mobile Clients

### Desktop Clients
- **Windows**: Download from seafile.com
- **macOS**: Download from seafile.com
- **Linux**: Available in package managers

### Mobile Clients
- **Android**: Google Play Store
- **iOS**: Apple App Store

## Volumes

- `seafile-data` - Seafile data and configuration
- `seafile-db-data` - MariaDB database files

## Common Tasks

### Backup Data

```bash
# Backup database
docker exec seafile_db mysqldump -u root -pP@ssw0rd@123 --all-databases > seafile_backup.sql

# Backup data
docker cp seafile:/shared ./seafile_backup
```

### Restore from Backup

```bash
# Restore database
docker exec -i seafile_db mysql -u root -pP@ssw0rd@123 < seafile_backup.sql

# Restore data
docker cp ./seafile_backup seafile:/shared
```

### Reset Admin Password

```bash
# Access container
docker exec -it seafile bash

# Reset password
cd /opt/seafile/seafile-server-latest
./reset-admin.sh
```

## Features

- **File Sync and Share**: Automatic synchronization
- **File Encryption**: Client-side encryption
- **Version Control**: Keep file history
- **File Locking**: Prevent concurrent edits
- **Online Editing**: Edit documents in browser
- **Group Collaboration**: Team libraries and permissions
- **Mobile Access**: iOS and Android apps
- **WebDAV**: Standard protocol support
- **Two-Factor Authentication**: Enhanced security
- **Audit Logs**: Track file access and changes

## Troubleshooting

### Cannot Access Web Interface

- Check port 80 is not in use
- Verify container is running: `docker ps`
- Check logs: `docker logs seafile`
- Verify SERVER_HOSTNAME is correct

### Database Connection Errors

- Ensure database container is running
- Check database password in .env
- Verify network connectivity
- Check MariaDB logs

### Sync Issues

- Check desktop client logs
- Verify server URL is correct
- Ensure library is not encrypted (or you have the password)
- Check network connectivity

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change all default passwords
- Use HTTPS with valid SSL certificates
- Enable two-factor authentication
- Set strong admin password
- Restrict access with firewall rules
- Keep Seafile updated
- Regular backups are essential
- Use strong database passwords
- Consider enabling file encryption

## Resources

- [Official Documentation](https://manual.seafile.com/)
- [Admin Manual](https://manual.seafile.com/deploy/)
- [GitHub Repository](https://github.com/haiwen/seafile)
- [Community Forum](https://forum.seafile.com/)
