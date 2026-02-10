# AppFlowy

An open-source alternative to Notion. AppFlowy is a privacy-first, flexible workspace for your notes, tasks, wikis, and databases. Built with Flutter and Rust, it offers a beautiful interface with powerful organization capabilities.

**Official Sites:**
- [AppFlowy](https://www.appflowy.io/) | [Docker Hub](https://hub.docker.com/r/appflowyinc/appflowy_cloud)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env and generate a secure JWT_SECRET

# Start the service
docker compose -f appflowy.yaml up -d
```

## Services

### AppFlowy Application
- **URL**: http://localhost:8080
- **Container**: `appflowy_app`
- **Note**: Create your account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `appflowy_db`
- **Database**: `appflowy`
- **Username**: `appflowy`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `appflowy_redis`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate a secure JWT secret:
   ```bash
   openssl rand -hex 32
   ```
3. Update `.env` with the generated JWT_SECRET
4. Start the service with `docker compose -f appflowy.yaml up -d`
5. Wait for the application to initialize (check logs: `docker logs appflowy_app`)
6. Navigate to http://localhost:8080
7. Create your account
8. Start creating workspaces and pages

## Configuration

### Environment Variables (.env)

- `APPFLOWY_PORT` - Web interface port (default: 8080)
- `JWT_SECRET` - JWT signing secret (generate with openssl rand -hex 32)
- `JWT_EXP` - JWT expiration time in seconds (default: 7200 = 2 hours)
- `RUST_LOG` - Logging level (debug, info, warn, error)
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production)
- `POSTGRES_DB` - Database name
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports, add environment variables, or configure additional settings. See the [official documentation](https://docs.appflowy.io/) for all available options.

## Workspace Setup

### Creating a Workspace

1. Click the workspace dropdown in the top-left
2. Select "Create new workspace"
3. Enter a workspace name
4. Choose workspace settings (private or shared)

### Creating Pages

1. Click the "+" button in the sidebar
2. Select page type:
   - **Blank Page**: Start with an empty page
   - **Grid**: Create a database/table view
   - **Board**: Kanban-style board
   - **Calendar**: Calendar view for dates
3. Add content using blocks (text, headings, lists, etc.)
4. Use `/` for slash commands to insert different block types

### Page Organization

- **Nested Pages**: Drag pages to create hierarchies
- **Favorites**: Star important pages for quick access
- **Recent**: Access recently viewed pages
- **Trash**: Deleted pages are moved to trash (recoverable)

## Features

- **Rich Text Editor**: Format text with markdown shortcuts
- **Database Views**: Grid, Board, Calendar, and Gallery views
- **Blocks**: Text, headings, lists, code blocks, images, and more
- **Templates**: Create and use page templates
- **Collaboration**: Share workspaces and pages with team members
- **Offline Support**: Work offline, sync when connected
- **Dark Mode**: Built-in dark theme
- **Mobile Apps**: iOS and Android apps available
- **Desktop Apps**: Windows, macOS, and Linux desktop applications
- **Privacy-First**: Self-hosted, your data stays with you

## Volumes

- `appflowy-data` - Application data and uploaded files
- `appflowy-db-data` - PostgreSQL database files
- `appflowy-redis-data` - Redis cache data

## Common Tasks

### Backup Database

```bash
docker exec appflowy_db pg_dump -U appflowy appflowy > appflowy_backup.sql
```

### Restore Database

```bash
cat appflowy_backup.sql | docker exec -i appflowy_db psql -U appflowy appflowy
```

### View Application Logs

```bash
docker logs appflowy_app
```

### Export Workspace

Use the export feature in the web UI:
1. Click workspace settings
2. Select "Export"
3. Choose format (Markdown, HTML, or AppFlowy format)

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check that JWT_SECRET is at least 32 characters. Verify database connection. Check logs with `docker logs appflowy_app`.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Ensure the database container is running and healthy. Check APPFLOWY_DATABASE_URL format is correct.

### Slow Performance

- **Symptoms**: Pages load slowly or lag when editing
- **Solution**: Check Redis is running. Increase container resources if needed. Check logs for errors.

### Cannot Upload Files

- **Symptoms**: File upload fails
- **Solution**: Check volume permissions. Ensure appflowy-data volume is writable.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure JWT_SECRET (at least 32 characters)
- Change the database password
- Use HTTPS with a reverse proxy
- Configure proper authentication and authorization
- Restrict access with firewall rules
- Regular backups are essential
- Keep the application updated

## Resources

- [Official Documentation](https://docs.appflowy.io/)
- [GitHub Repository](https://github.com/AppFlowy-IO/AppFlowy)
- [Docker Hub](https://hub.docker.com/r/appflowyinc/appflowy_cloud)
- [Community Forum](https://github.com/AppFlowy-IO/AppFlowy/discussions)
