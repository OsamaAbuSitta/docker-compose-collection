# Vikunja

An open-source to-do app and task management solution. Vikunja helps you organize your life with lists, tasks, labels, and team collaboration. Features include CalDAV support, recurring tasks, and a clean, modern interface.

**Official Sites:**
- [Vikunja](https://vikunja.io/) | [Docker Hub](https://hub.docker.com/r/vikunja/vikunja)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially JWT_SECRET)

# Start the service
docker compose -f vikunja.yaml up -d
```

## Services

### Vikunja Application
- **URL**: http://localhost:3456
- **Container**: `vikunja_app`
- **Note**: Create your account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `vikunja_db`
- **Database**: `vikunja`
- **Username**: `vikunja`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate a secure JWT_SECRET (minimum 32 characters, random string)
3. Start the service with `docker compose -f vikunja.yaml up -d`
4. Wait for initialization (check logs: `docker logs vikunja_app`)
5. Navigate to http://localhost:3456
6. Create your account
7. Create your first list

## Configuration

### Environment Variables (.env)

- `VIKUNJA_PORT` - Web interface port (default: 3456)
- `JWT_SECRET` - JWT secret for authentication (minimum 32 characters)
- `FRONTEND_URL` - The URL where Vikunja is accessible
- `DB_HOST` - Database hostname (use container name)
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports or add environment variables. See the [official documentation](https://vikunja.io/docs/) for all available options.

## Volumes

- `vikunja-files` - Uploaded files and attachments
- `vikunja-db-data` - PostgreSQL database files

## Common Tasks

### Create a List

1. Log in to Vikunja
2. Click "New List" in the sidebar
3. Enter list name and description
4. Choose list color and icon
5. Click "Create"

### Create a Task

1. Open a list
2. Click "Add a new task" or press 'N'
3. Enter task title
4. Press Enter to create
5. Click task to add details (description, due date, labels, etc.)

### Add Labels

1. Go to Settings → Labels
2. Click "Create a new label"
3. Enter label name and choose color
4. Apply labels to tasks for organization

### Set Up Recurring Tasks

1. Open a task
2. Click "Repeat" section
3. Choose repeat pattern (daily, weekly, monthly, etc.)
4. Set repeat interval and end date
5. Save the task

### Share a List

1. Open a list
2. Click the share icon
3. Choose sharing method:
   - Share with users (by username or email)
   - Generate share link
   - Set permissions (read/write/admin)

### Backup Data

```bash
# Backup database
docker exec vikunja_db pg_dump -U vikunja vikunja > vikunja_backup.sql

# Backup files
docker run --rm -v vikunja-files:/data -v $(pwd):/backup alpine tar czf /backup/vikunja_files.tar.gz /data
```

### Restore Database

```bash
cat vikunja_backup.sql | docker exec -i vikunja_db psql -U vikunja vikunja
```

### Update Vikunja

```bash
# Pull the latest image
docker compose -f vikunja.yaml pull

# Restart with new image
docker compose -f vikunja.yaml up -d
```

## Features

- **Task Management**: Create, organize, and track tasks
- **Lists**: Organize tasks into lists and sub-lists
- **Labels**: Tag tasks with custom labels
- **Priorities**: Set task priorities (low, medium, high, urgent)
- **Due Dates**: Set deadlines and reminders
- **Recurring Tasks**: Automate repeating tasks
- **Attachments**: Add files to tasks
- **Comments**: Collaborate with task comments
- **Filters**: Create custom filters and saved views
- **CalDAV Support**: Sync with calendar apps
- **Team Collaboration**: Share lists with team members
- **Kanban Boards**: Visualize tasks in Kanban view
- **Gantt Charts**: Timeline view for project planning
- **Mobile Apps**: iOS and Android apps available

## Task Organization

### Namespaces

Organize lists into namespaces (workspaces):
1. Create a namespace for different areas (Work, Personal, etc.)
2. Add lists to namespaces
3. Share entire namespaces with teams

### Favorites

Mark important lists as favorites:
1. Click the star icon on a list
2. Favorites appear at the top of the sidebar
3. Quick access to frequently used lists

### Filters

Create custom filters to find tasks:
1. Go to Filters in the sidebar
2. Click "Create a new filter"
3. Set filter criteria (labels, due date, priority, etc.)
4. Save filter for quick access

## CalDAV Integration

Sync tasks with calendar applications:

1. Go to Settings → CalDAV
2. Copy the CalDAV URL
3. Add to your calendar app (Thunderbird, Apple Calendar, etc.)
4. Use your Vikunja credentials
5. Tasks appear as calendar events

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs vikunja_app`. Ensure JWT_SECRET is at least 32 characters.

### Database Connection Failed

- **Symptoms**: "Cannot connect to database" error
- **Solution**: Verify DB_HOST matches the database container name. Check database credentials.

### Cannot Upload Files

- **Symptoms**: File upload fails
- **Solution**: Check volume permissions. Ensure the files volume is writable.

### CalDAV Sync Not Working

- **Symptoms**: Tasks don't sync with calendar app
- **Solution**: Verify CalDAV URL is correct. Check credentials. Ensure calendar app supports CalDAV.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure JWT_SECRET (minimum 32 characters, random string)
- Change the database password
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential
- Keep Vikunja updated to the latest version

## Resources

- [Official Documentation](https://vikunja.io/docs/)
- [GitHub Repository](https://github.com/go-vikunja/vikunja)
- [Community Forum](https://community.vikunja.io/)
- [Docker Hub](https://hub.docker.com/r/vikunja/vikunja)
