# Plane

An open-source project management tool designed for modern teams. Plane offers issue tracking, project planning, cycles (sprints), modules, and views with a clean, intuitive interface. Built for software teams who need powerful project management without complexity.

**Official Sites:**
- [Plane](https://plane.so/) | [Docker Hub](https://hub.docker.com/u/makeplane)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially SECRET_KEY)

# Start the service
docker compose -f plane.yaml up -d
```

## Services

### Plane Web Interface
- **URL**: http://localhost:3000
- **Container**: `plane_web`
- **Note**: Create your account on first visit

### Plane API
- **Container**: `plane_api`
- **Note**: Backend API service

### Plane Worker
- **Container**: `plane_worker`
- **Note**: Background job processor

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `plane_db`
- **Database**: `plane`
- **Username**: `plane`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `plane_redis`

### MinIO Object Storage
- **API Port**: 9000
- **Console Port**: 9001
- **Container**: `plane_minio`
- **Console URL**: http://localhost:9001
- **Access Key**: `minioadmin`
- **Secret Key**: `minioadmin`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate a secure SECRET_KEY (minimum 50 characters, random string)
3. Start the service with `docker compose -f plane.yaml up -d`
4. Wait for all services to initialize (check logs: `docker logs plane_api`)
5. Navigate to http://localhost:3000
6. Create your account (first user becomes admin)
7. Create your first workspace
8. Set up your first project

## Configuration

### Environment Variables (.env)

- `PLANE_PORT` - Web interface port (default: 3000)
- `SECRET_KEY` - Secret key for sessions (minimum 50 characters)
- `DB_HOST` - Database hostname (use container name)
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password (change for production)
- `REDIS_HOST` - Redis hostname (use container name)
- `MINIO_ACCESS_KEY` - MinIO access key
- `MINIO_SECRET_KEY` - MinIO secret key (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports or add environment variables. See the [official documentation](https://docs.plane.so/) for all available options.

## Volumes

- `plane-logs` - Application logs
- `plane-db-data` - PostgreSQL database files
- `plane-redis-data` - Redis cache data
- `plane-minio-data` - File attachments and uploads

## Common Tasks

### Create a Workspace

1. Log in to Plane
2. Click "Create Workspace" on the dashboard
3. Enter workspace name and URL slug
4. Invite team members via email

### Create a Project

1. Select your workspace
2. Click "New Project"
3. Enter project name, identifier, and description
4. Choose project lead and default assignee
5. Click "Create Project"

### Create an Issue

1. Navigate to your project
2. Click "New Issue" or press 'C'
3. Enter issue title and description
4. Set priority, assignee, and labels
5. Click "Create Issue"

### Set Up Cycles (Sprints)

1. Go to your project
2. Click "Cycles" in the sidebar
3. Click "Create Cycle"
4. Set cycle name, start date, and end date
5. Add issues to the cycle

### Backup Data

```bash
# Backup database
docker exec plane_db pg_dump -U plane plane > plane_backup.sql

# Backup MinIO data
docker run --rm -v plane-minio-data:/data -v $(pwd):/backup alpine tar czf /backup/plane_minio.tar.gz /data
```

### Restore Database

```bash
cat plane_backup.sql | docker exec -i plane_db psql -U plane plane
```

### Update Plane

```bash
# Pull the latest images
docker compose -f plane.yaml pull

# Restart with new images
docker compose -f plane.yaml up -d
```

## Features

- **Issue Tracking**: Create, assign, and track issues with custom fields
- **Project Planning**: Organize work with projects and modules
- **Cycles**: Sprint planning and tracking
- **Views**: Custom views with filters and grouping
- **Pages**: Documentation and knowledge base
- **Inbox**: Triage and prioritize incoming issues
- **Analytics**: Project insights and metrics
- **Integrations**: GitHub, Slack, and more
- **API**: Full REST API for automation
- **Mobile Apps**: iOS and Android apps available

## Project Management

### Modules

Organize issues into modules (features, epics):
1. Go to "Modules" in your project
2. Click "Create Module"
3. Add issues to the module
4. Track module progress

### Labels

Create custom labels for categorization:
1. Go to Project Settings → Labels
2. Click "Add Label"
3. Set label name and color
4. Apply labels to issues

### States

Customize workflow states:
1. Go to Project Settings → States
2. Add custom states (e.g., In Review, Testing)
3. Define state transitions
4. Issues move through states in your workflow

## Troubleshooting

### Application Won't Start

- **Symptoms**: Containers exit immediately
- **Solution**: Check logs with `docker logs plane_api`. Ensure SECRET_KEY is at least 50 characters.

### Database Connection Failed

- **Symptoms**: "Cannot connect to database" error
- **Solution**: Verify database container is running. Check DB_HOST matches the database container name.

### File Upload Failed

- **Symptoms**: Cannot upload attachments
- **Solution**: Check MinIO is running (`docker logs plane_minio`). Verify MinIO credentials are correct.

### Worker Not Processing Jobs

- **Symptoms**: Background tasks not completing
- **Solution**: Check worker logs (`docker logs plane_worker`). Ensure Redis is running.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure SECRET_KEY (minimum 50 characters, random string)
- Change the database password
- Change MinIO access and secret keys
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential
- Keep Plane updated to the latest version

## Resources

- [Official Documentation](https://docs.plane.so/)
- [GitHub Repository](https://github.com/makeplane/plane)
- [Community Discord](https://discord.com/invite/plane)
- [Docker Hub](https://hub.docker.com/u/makeplane)
