# Redmine

A flexible project management web application written using Ruby on Rails. Redmine includes support for multiple projects, role-based access control, issue tracking, Gantt charts, calendars, wikis, forums, and time tracking.

**Official Sites:**
- [Redmine](https://www.redmine.org/) | [Docker Hub](https://hub.docker.com/_/redmine)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f redmine.yaml up -d
```

## Services

### Redmine Application
- **URL**: http://localhost:3000
- **Container**: `redmine_app`
- **Default Username**: `admin`
- **Default Password**: `admin`

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `redmine_db`
- **Database**: `redmine`
- **Username**: `redmine`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate a secure secret key base (minimum 30 characters)
3. Start the service with `docker compose -f redmine.yaml up -d`
4. Wait for initialization (check logs: `docker logs redmine_app`)
5. Navigate to http://localhost:3000
6. Log in with username `admin` and password `admin`
7. **Important**: Change the admin password immediately after first login

## Configuration

### Environment Variables (.env)

- `REDMINE_PORT` - Web interface port (default: 3000)
- `SECRET_KEY_BASE` - Secret key for sessions (minimum 30 characters)
- `DB_HOST` - Database hostname (use container name)
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports or add environment variables. See the [official documentation](https://www.redmine.org/projects/redmine/wiki/RedmineInstall) for all available options.

## Volumes

- `redmine-files` - Uploaded files and attachments
- `redmine-plugins` - Installed plugins
- `redmine-themes` - Custom themes
- `redmine-db-data` - PostgreSQL database files

## Common Tasks

### Install a Plugin

```bash
# Download plugin to the plugins volume
docker exec redmine_app bash -c "cd /usr/src/redmine/plugins && git clone <plugin-repo-url>"

# Install plugin dependencies
docker exec redmine_app bundle install

# Run database migrations
docker exec redmine_app bundle exec rake redmine:plugins:migrate RAILS_ENV=production

# Restart the container
docker restart redmine_app
```

### Create a New Project

1. Log in as admin
2. Click "Projects" in the top menu
3. Click "New project"
4. Fill in project details (name, identifier, description)
5. Select modules to enable (issue tracking, wiki, etc.)
6. Click "Create"

### Backup Database

```bash
docker exec redmine_db pg_dump -U redmine redmine > redmine_backup.sql
```

### Restore Database

```bash
cat redmine_backup.sql | docker exec -i redmine_db psql -U redmine redmine
```

### Update Redmine

```bash
# Pull the latest image
docker compose -f redmine.yaml pull

# Restart with new image
docker compose -f redmine.yaml up -d

# Run database migrations if needed
docker exec redmine_app bundle exec rake db:migrate RAILS_ENV=production
```

## Plugin Installation

Redmine supports a wide variety of plugins for extended functionality:

- **Agile Plugin**: Scrum and Kanban boards
- **Checklists**: Add checklists to issues
- **CRM**: Customer relationship management
- **Gantt**: Enhanced Gantt chart features
- **Time Tracking**: Advanced time tracking features

Plugins are installed in the `/usr/src/redmine/plugins` directory, which is mounted as a volume for persistence.

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs redmine_app`. Ensure SECRET_KEY_BASE is at least 30 characters.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Ensure the database container is running. Check DB_HOST matches the database container name.

### Plugin Installation Failed

- **Symptoms**: Plugin doesn't appear after installation
- **Solution**: Ensure you ran `bundle install` and `rake redmine:plugins:migrate`. Restart the container after installation.

### Permission Errors

- **Symptoms**: Cannot upload files or create issues
- **Solution**: Check volume permissions. The application may need write access to the files volume.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the default admin password immediately after first login
- Generate a secure SECRET_KEY_BASE (minimum 30 characters, random string)
- Change the database password
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential
- Keep Redmine and plugins updated

## Resources

- [Official Documentation](https://www.redmine.org/projects/redmine/wiki/Guide)
- [Plugin Directory](https://www.redmine.org/plugins)
- [GitHub Repository](https://github.com/redmine/redmine)
- [Docker Hub](https://hub.docker.com/_/redmine)
