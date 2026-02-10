# Standard Notes

A free, open-source, and completely encrypted notes app. Standard Notes provides a simple and private way to keep notes, thoughts, and life's work safe and easy to access.

**Official Sites:**
- [Standard Notes](https://standardnotes.com/) | [Docker Hub](https://hub.docker.com/r/standardnotes/server)

## Quick Start

```bash
docker compose -f standard-notes.yaml up -d
```

## Services

### Standard Notes Server
- **URL**: http://localhost:3000
- **Container**: `standardnotes_server`
- **Note**: Register account through Standard Notes client

### MySQL Database
- **Port**: 3306 (internal)
- **Container**: `standardnotes_db`
- **Database**: `standardnotes`
- **Username**: `standardnotes`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `standardnotes_redis`

## Initial Setup

1. Start the services with `docker compose -f standard-notes.yaml up -d`
2. Download Standard Notes client:
   - Desktop: https://standardnotes.com/download
   - Mobile: iOS App Store or Google Play
   - Web: https://app.standardnotes.com
3. In the client, go to Account > Advanced Options
4. Set "Sync Server" to http://localhost:3000
5. Register a new account
6. Start taking notes with end-to-end encryption

## Connecting Clients

### Desktop/Mobile App Configuration

1. Open Standard Notes application
2. Click "Sign In" or "Register"
3. Click "Advanced Options"
4. Enter custom sync server: http://localhost:3000
5. Complete registration or sign in
6. Your notes will sync to your self-hosted server

## Volumes

- `standardnotes-db-data` - MySQL database files containing encrypted notes

## Common Tasks

### Create a New Note

1. Click "New Note" in the client
2. Start typing (notes auto-save)
3. Add tags for organization
4. Notes are automatically encrypted

### Backup Notes

```bash
# Backup the database
docker exec standardnotes_db mysqldump -u standardnotes -pP@ss0rd123 standardnotes > standardnotes_backup.sql
```

### Restore Notes

```bash
# Restore from backup
cat standardnotes_backup.sql | docker exec -i standardnotes_db mysql -u standardnotes -pP@ss0rd123 standardnotes
```

### View Server Logs

```bash
docker logs standardnotes_server
```

### Install Extensions

Standard Notes supports extensions for enhanced functionality:
1. Open Settings in the client
2. Navigate to Extensions
3. Install editors, themes, and tools
4. Extensions work with self-hosted servers

## Configuration

### Environment Variables

**Required Secrets** (must be at least 32 characters):
- `AUTH_JWT_SECRET` - JWT authentication secret
- `ENCRYPTION_SERVER_KEY` - Server-side encryption key
- `VALET_TOKEN_SECRET` - Valet token secret

**Database Configuration**:
- `DB_HOST` - Database hostname
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password

**Redis Configuration**:
- `REDIS_URL` - Redis connection URL

### Generate Secure Secrets

```bash
# Generate random 32-character secrets
openssl rand -hex 32
```

Replace the default secrets in the compose file with generated values.

### Custom Port

To change the port, modify both the ports mapping and PORT environment variable:

```yaml
ports:
  - "8080:8080"
environment:
  - PORT=8080
```

## Troubleshooting

### Cannot Connect to Server

- **Symptoms**: Client shows "Could not connect to server"
- **Solution**: Verify the server is running and accessible. Check the sync server URL in client settings.

### Database Connection Failed

- **Symptoms**: Server logs show database connection errors
- **Solution**: Ensure the database container is running. Verify DB_HOST matches the database container name.

### Notes Not Syncing

- **Symptoms**: Changes don't appear on other devices
- **Solution**: Check that all clients are configured with the same server URL. Verify network connectivity.

### Authentication Errors

- **Symptoms**: Cannot sign in or register
- **Solution**: Ensure AUTH_JWT_SECRET is set and at least 32 characters. Check server logs for details.

## Features

- **End-to-End Encryption**: All notes encrypted on device
- **Cross-Platform**: Desktop, mobile, and web clients
- **Extensions**: Editors, themes, and productivity tools
- **Tags**: Organize notes with tags
- **Search**: Full-text search (on encrypted data)
- **Markdown**: Rich text editing with Markdown
- **Code Editor**: Syntax highlighting for code notes
- **Offline Access**: Work without internet connection
- **Version History**: Access previous versions of notes
- **Two-Factor Auth**: Additional security layer

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate secure secrets (32+ characters) for all secret environment variables
- Change all database passwords
- Use HTTPS with a reverse proxy
- Enable two-factor authentication
- Restrict access with firewall rules
- Regular backups are essential
- Keep the server updated

## Resources

- [Official Documentation](https://docs.standardnotes.com/)
- [Self-Hosting Guide](https://docs.standardnotes.com/self-hosting/docker)
- [GitHub Repository](https://github.com/standardnotes/server)
- [Docker Hub](https://hub.docker.com/r/standardnotes/server)
