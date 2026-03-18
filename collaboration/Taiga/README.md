# Taiga

An open-source project management platform for agile teams. Taiga offers Scrum and Kanban boards, sprint planning, user stories, tasks, issues, and wikis. Built for cross-functional teams who need powerful agile project management.

**Official Sites:**
- [Taiga](https://www.taiga.io/) | [Docker Hub](https://hub.docker.com/u/taigaio)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially SECRET_KEY)

# Start the service
docker compose -f taiga.yaml up -d
```

## Services

### Taiga Gateway (Nginx)
- **URL**: http://localhost:9000
- **Container**: `taiga_gateway`
- **Note**: Reverse proxy for all Taiga services

### Taiga Backend
- **Container**: `taiga_back`
- **Note**: API and admin interface

### Taiga Frontend
- **Container**: `taiga_front`
- **Note**: Web interface

### Taiga Events
- **Container**: `taiga_events`
- **Note**: Real-time events via WebSockets

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `taiga_db`
- **Database**: `taiga`
- **Username**: `taiga`
- **Password**: `P@ss0rd123`

### RabbitMQ Message Queue
- **Port**: 5672 (internal)
- **Container**: `taiga_rabbitmq`
- **Username**: `taiga`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate a secure SECRET_KEY (minimum 50 characters, random string)
3. Start the service with `docker compose -f taiga.yaml up -d`
4. Wait for all services to initialize (check logs: `docker logs taiga_back`)
5. Navigate to http://localhost:9000
6. Create your admin account (first user becomes admin)
7. Create your first project

## Configuration

### Environment Variables (.env)

- `TAIGA_PORT` - Web interface port (default: 9000)
- `SECRET_KEY` - Secret key for sessions (minimum 50 characters)
- `SCHEME` - URL scheme (http or https)
- `DOMAIN` - Domain where Taiga is accessible
- `TAIGA_URL` - Full URL to Taiga
- `WEBSOCKETS_URL` - WebSocket URL for real-time updates
- `DB_HOST` - Database hostname (use container name)
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password (change for production)
- `RABBITMQ_USER` - RabbitMQ username
- `RABBITMQ_PASS` - RabbitMQ password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports or add environment variables. Modify `nginx.conf` for custom proxy settings. See the [official documentation](https://docs.taiga.io/) for all available options.

## Volumes

- `taiga-static` - Static files (CSS, JS, images)
- `taiga-media` - User uploads and attachments
- `taiga-db-data` - PostgreSQL database files
- `taiga-rabbitmq-data` - RabbitMQ message queue data

## Common Tasks

### Create a Project

1. Log in to Taiga
2. Click "Create Project"
3. Choose project template (Scrum or Kanban)
4. Enter project name and description
5. Configure project settings
6. Invite team members

### Create a User Story (Scrum)

1. Open a project
2. Go to "Backlog"
3. Click "New User Story"
4. Enter story title and description
5. Set story points and priority
6. Assign to team members

### Create a Sprint

1. Go to "Backlog"
2. Click "New Sprint"
3. Enter sprint name and dates
4. Drag user stories into the sprint
5. Click "Start Sprint"

### Create a Task

1. Open a user story or issue
2. Click "Add Task"
3. Enter task title
4. Assign to team member
5. Set task status

### Create an Issue

1. Go to "Issues"
2. Click "New Issue"
3. Enter issue title and description
4. Set priority, severity, and type
5. Assign to team member

### Backup Data

```bash
# Backup database
docker exec taiga_db pg_dump -U taiga taiga > taiga_backup.sql

# Backup media files
docker run --rm -v taiga-media:/data -v $(pwd):/backup alpine tar czf /backup/taiga_media.tar.gz /data
```

### Restore Database

```bash
cat taiga_backup.sql | docker exec -i taiga_db psql -U taiga taiga
```

### Update Taiga

```bash
# Pull the latest images
docker compose -f taiga.yaml pull

# Restart with new images
docker compose -f taiga.yaml up -d
```

## Features

- **Scrum Support**: Sprints, user stories, and backlog management
- **Kanban Boards**: Visual workflow management
- **User Stories**: Detailed story tracking with acceptance criteria
- **Tasks**: Break down stories into actionable tasks
- **Issues**: Bug tracking and issue management
- **Epics**: Group related user stories
- **Wiki**: Project documentation and knowledge base
- **Custom Fields**: Add custom attributes to stories and tasks
- **Time Tracking**: Track time spent on tasks
- **Burndown Charts**: Visualize sprint progress
- **Team Management**: Role-based access control
- **Integrations**: GitHub, GitLab, Slack, and more
- **Import/Export**: Import from Jira, Trello, Asana

## Agile Workflows

### Scrum Workflow

1. **Backlog**: Create and prioritize user stories
2. **Sprint Planning**: Select stories for the sprint
3. **Sprint Execution**: Team works on tasks
4. **Daily Standup**: Track progress and blockers
5. **Sprint Review**: Demo completed work
6. **Sprint Retrospective**: Improve team processes

### Kanban Workflow

1. **Backlog**: Add new work items
2. **To Do**: Ready to start
3. **In Progress**: Currently working
4. **Done**: Completed work
5. **Customize**: Add custom columns for your workflow

## Project Templates

Taiga includes templates for:

- **Scrum**: Sprint-based agile development
- **Kanban**: Continuous flow workflow
- **Bug Tracking**: Issue and bug management
- **Personal Project**: Individual task management

## Troubleshooting

### Application Won't Start

- **Symptoms**: Containers exit immediately
- **Solution**: Check logs with `docker logs taiga_back`. Ensure SECRET_KEY is at least 50 characters.

### Database Connection Failed

- **Symptoms**: "Cannot connect to database" error
- **Solution**: Verify database container is running. Check DB_HOST matches the database container name.

### Real-time Updates Not Working

- **Symptoms**: Changes don't appear in real-time
- **Solution**: Check taiga-events logs (`docker logs taiga_events`). Verify WebSocket URL is correct.

### Cannot Upload Files

- **Symptoms**: File upload fails
- **Solution**: Check volume permissions. Ensure media volume is writable.

### Nginx Gateway Errors

- **Symptoms**: 502 Bad Gateway errors
- **Solution**: Check that all backend services are running. Verify nginx.conf is correctly mounted.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure SECRET_KEY (minimum 50 characters, random string)
- Change all default passwords (database, RabbitMQ)
- Use HTTPS with a reverse proxy (update SCHEME and URLs)
- Restrict access with firewall rules
- Regular backups are essential
- Keep Taiga and all components updated
- Configure proper authentication (LDAP, SAML, OAuth)

## Resources

- [Official Documentation](https://docs.taiga.io/)
- [GitHub Repository](https://github.com/taigaio/taiga)
- [Community Forum](https://community.taiga.io/)
- [Docker Hub](https://hub.docker.com/u/taigaio)
