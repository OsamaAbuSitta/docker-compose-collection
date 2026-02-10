# Focalboard

An open-source alternative to Trello, Notion, and Asana. Focalboard helps teams stay aligned with project boards, task management, and collaboration features. Built by Mattermost, it offers a clean interface for organizing work.

**Official Sites:**
- [Focalboard](https://www.focalboard.com/) | [Docker Hub](https://hub.docker.com/r/mattermost/focalboard)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f focalboard.yaml up -d
```

## Services

### Focalboard Application
- **URL**: http://localhost:8000
- **Container**: `focalboard_app`
- **Note**: Create your account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `focalboard_db`
- **Database**: `focalboard`
- **Username**: `focalboard`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f focalboard.yaml up -d`
3. Wait for initialization (check logs: `docker logs focalboard_app`)
4. Navigate to http://localhost:8000
5. Create your account (first user becomes admin)
6. Create your first board

## Configuration

### Environment Variables (.env)

- `FOCALBOARD_PORT` - Web interface port (default: 8000)
- `SERVER_ROOT` - The URL where Focalboard is accessible
- `DB_HOST` - Database hostname (use container name)
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports or add environment variables. See the [official documentation](https://www.focalboard.com/docs/) for all available options.

## Volumes

- `focalboard-files` - Uploaded files and attachments
- `focalboard-db-data` - PostgreSQL database files

## Common Tasks

### Create a Board

1. Log in to Focalboard
2. Click "Create new board" or "+" button
3. Choose a template (Kanban, Table, Gallery, Calendar)
4. Enter board name
5. Start adding cards

### Create a Card

1. Open a board
2. Click "New" or "+" in a column
3. Enter card title
4. Add description, properties, and attachments
5. Assign to team members

### Add Properties to Cards

1. Open a card
2. Click "Add a property"
3. Choose property type (Select, Multi-select, Date, Person, etc.)
4. Set property value
5. Properties appear in board views

### Share a Board

1. Open a board
2. Click "Share" button
3. Choose sharing options:
   - Share with team members
   - Generate public link
   - Set permissions (view/edit)

### Backup Data

```bash
# Backup database
docker exec focalboard_db pg_dump -U focalboard focalboard > focalboard_backup.sql

# Backup files
docker run --rm -v focalboard-files:/data -v $(pwd):/backup alpine tar czf /backup/focalboard_files.tar.gz /data
```

### Restore Database

```bash
cat focalboard_backup.sql | docker exec -i focalboard_db psql -U focalboard focalboard
```

### Update Focalboard

```bash
# Pull the latest image
docker compose -f focalboard.yaml pull

# Restart with new image
docker compose -f focalboard.yaml up -d
```

## Features

- **Multiple Views**: Kanban, Table, Gallery, and Calendar views
- **Custom Properties**: Add custom fields to cards
- **Templates**: Pre-built templates for common workflows
- **Card Management**: Rich text editing, checklists, and attachments
- **Filtering**: Filter cards by properties and values
- **Sorting**: Sort cards by any property
- **Grouping**: Group cards by properties
- **Comments**: Collaborate with team comments
- **Notifications**: Stay updated on board changes
- **Import/Export**: Import from Trello, Asana, Notion

## Board Templates

Focalboard includes templates for:

- **Project Tasks**: Kanban board for project management
- **Roadmap**: Timeline view for product planning
- **Meeting Agenda**: Organize meeting topics and notes
- **Personal Goals**: Track personal objectives
- **Content Calendar**: Plan content publishing
- **Sprint Planning**: Agile sprint management

## Card Properties

Available property types:

- **Text**: Single-line text field
- **Number**: Numeric values
- **Select**: Single choice from options
- **Multi-select**: Multiple choices from options
- **Date**: Date picker
- **Person**: Assign to team members
- **Checkbox**: Boolean value
- **URL**: Web links
- **Email**: Email addresses
- **Phone**: Phone numbers

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs focalboard_app`. Ensure database is running and accessible.

### Database Connection Failed

- **Symptoms**: "Cannot connect to database" error
- **Solution**: Verify DB_HOST matches the database container name. Check database credentials.

### Cannot Upload Files

- **Symptoms**: File upload fails
- **Solution**: Check volume permissions. Ensure the files volume is writable.

### Board Not Loading

- **Symptoms**: Board shows loading spinner indefinitely
- **Solution**: Check browser console for errors. Clear browser cache and reload.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the database password
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential
- Keep Focalboard updated to the latest version
- Configure proper authentication if needed

## Resources

- [Official Documentation](https://www.focalboard.com/docs/)
- [GitHub Repository](https://github.com/mattermost/focalboard)
- [Community Forum](https://forum.mattermost.com/c/focalboard)
- [Docker Hub](https://hub.docker.com/r/mattermost/focalboard)
