# Joplin Server

Joplin Server is the sync server for Joplin, an open source note-taking and to-do application. It allows you to synchronize your notes across multiple devices with end-to-end encryption.

**Official Sites:**
- [Joplin](https://joplinapp.org/) | [Docker Hub](https://hub.docker.com/r/joplin/server)

## Quick Start

```bash
docker compose -f joplin-server.yaml up -d
```

## Services

### Joplin Server
- **URL**: http://localhost:22300
- **Container**: `joplin_server`
- **Note**: Create admin account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `joplin_db`
- **Database**: `joplin`
- **Username**: `joplin`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Start the services with `docker compose -f joplin-server.yaml up -d`
2. Navigate to http://localhost:22300
3. Create an admin account
4. Create user accounts for syncing
5. Configure Joplin clients to sync with this server

## Connecting Joplin Clients

### Desktop/Mobile App Configuration

1. Open Joplin application
2. Go to Settings > Synchronization
3. Select "Joplin Server" as sync target
4. Enter server details:
   - **URL**: http://localhost:22300
   - **Email**: Your user email
   - **Password**: Your user password
5. Click "Check synchronization configuration"
6. Start syncing

## Volumes

- `joplin-db-data` - PostgreSQL database files containing notes and sync data

## Common Tasks

### Create a New User

1. Log in to the admin panel at http://localhost:22300
2. Navigate to Users
3. Click "Add user"
4. Enter email and password
5. Provide credentials to the user for their Joplin client

### Backup Notes

```bash
# Backup the database
docker exec joplin_db pg_dump -U joplin joplin > joplin_backup.sql
```

### Restore Notes

```bash
# Restore from backup
cat joplin_backup.sql | docker exec -i joplin_db psql -U joplin joplin
```

### View Server Logs

```bash
docker logs joplin_server
```

## Configuration

### Environment Variables

- `APP_BASE_URL` - The URL where Joplin Server is accessible
- `APP_PORT` - Server port (default: 22300)
- `DB_CLIENT` - Database type (pg for PostgreSQL)
- `POSTGRES_HOST` - Database hostname
- `POSTGRES_DATABASE` - Database name
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password

### Custom Port

To change the port, modify both the ports mapping and APP_PORT:

```yaml
ports:
  - "8080:8080"
environment:
  - APP_PORT=8080
```

## Troubleshooting

### Cannot Access Admin Panel

- **Symptoms**: Browser cannot connect to http://localhost:22300
- **Solution**: Ensure the container is running. Check logs with `docker logs joplin_server`.

### Database Connection Failed

- **Symptoms**: Server shows database connection errors
- **Solution**: Verify the database container is running and healthy. Check POSTGRES_HOST matches the database container name.

### Sync Fails on Client

- **Symptoms**: Joplin client cannot sync
- **Solution**: Verify the server URL is correct and accessible from the client device. Check user credentials.

## Features

- **Multi-Device Sync**: Synchronize notes across desktop, mobile, and web
- **End-to-End Encryption**: Optional E2EE for maximum privacy
- **User Management**: Admin panel for managing users
- **Note Organization**: Notebooks, tags, and search
- **Attachments**: Support for images, PDFs, and other files
- **Markdown Support**: Rich text editing with Markdown

## Security Notes

⚠️ **Important**: The default credentials are for development only. For production use:
- Change the database password
- Use HTTPS with a reverse proxy
- Enable end-to-end encryption in Joplin clients
- Restrict access with firewall rules
- Use strong passwords for user accounts

## Resources

- [Official Documentation](https://joplinapp.org/help/)
- [Server Documentation](https://github.com/laurent22/joplin/blob/dev/readme/server.md)
- [GitHub Repository](https://github.com/laurent22/joplin)
- [Docker Hub](https://hub.docker.com/r/joplin/server)
