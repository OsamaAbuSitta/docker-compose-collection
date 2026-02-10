# Outline

A modern team knowledge base and wiki. Outline is a fast, collaborative, and beautiful wiki for your team. It features real-time collaboration, markdown support, document organization with collections, and powerful search capabilities.

**Official Sites:**
- [Outline](https://www.getoutline.com/) | [Docker Hub](https://hub.docker.com/r/outlinewiki/outline)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env and generate secure SECRET_KEY and UTILS_SECRET

# Start the service
docker compose -f outline.yaml up -d
```

## Services

### Outline Application
- **URL**: http://localhost:3000
- **Container**: `outline_app`
- **Note**: Authentication requires OAuth provider setup (Google, Slack, etc.)

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `outline_db`
- **Database**: `outline`
- **Username**: `outline`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `outline_redis`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate secure secrets:
   ```bash
   # Generate SECRET_KEY (at least 32 characters)
   openssl rand -hex 32
   
   # Generate UTILS_SECRET (at least 32 characters)
   openssl rand -hex 32
   ```
3. Update `.env` with the generated secrets
4. Configure an OAuth provider (Google, Slack, Azure, etc.) - see [Authentication Setup](#authentication-setup)
5. Start the service with `docker compose -f outline.yaml up -d`
6. Navigate to http://localhost:3000
7. Sign in with your configured OAuth provider

## Configuration

### Environment Variables (.env)

- `OUTLINE_PORT` - Web interface port (default: 3000)
- `SECRET_KEY` - Application secret key (generate with openssl rand -hex 32)
- `UTILS_SECRET` - Utility secret key (generate with openssl rand -hex 32)
- `OUTLINE_URL` - Public URL where Outline is accessible
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production)
- `POSTGRES_DB` - Database name
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Authentication Setup

Outline requires an OAuth provider for authentication. Add one of the following to your `.env` file:

**Google OAuth:**
```bash
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
```

**Slack OAuth:**
```bash
SLACK_CLIENT_ID=your_client_id
SLACK_CLIENT_SECRET=your_client_secret
```

**Azure AD:**
```bash
AZURE_CLIENT_ID=your_client_id
AZURE_CLIENT_SECRET=your_client_secret
AZURE_RESOURCE_APP_ID=your_resource_app_id
```

See the [official authentication documentation](https://docs.getoutline.com/s/hosting/doc/authentication-7ViKRmRY5o) for detailed setup instructions.

## Workspace Setup

### Creating Collections

1. Click the "+" button in the sidebar
2. Select "New collection"
3. Enter a name and description
4. Choose an icon and color
5. Set permissions (private, team, or public)

### Creating Documents

1. Navigate to a collection
2. Click "New doc" or press `N`
3. Write content using Markdown
4. Use `/` for slash commands (headings, lists, embeds, etc.)
5. Documents auto-save as you type

### Document Collaboration

- **Real-time editing**: Multiple users can edit simultaneously
- **Comments**: Add comments to any text selection
- **Mentions**: Use `@` to mention team members
- **Version history**: View and restore previous versions
- **Templates**: Create document templates for consistency

## Volumes

- `outline-data` - Uploaded files and attachments
- `outline-db-data` - PostgreSQL database files
- `outline-redis-data` - Redis cache data

## Common Tasks

### Backup Database

```bash
docker exec outline_db pg_dump -U outline outline > outline_backup.sql
```

### Restore Database

```bash
cat outline_backup.sql | docker exec -i outline_db psql -U outline outline
```

### View Application Logs

```bash
docker logs outline_app
```

### Import Documents

Outline supports importing from:
- Confluence
- Notion
- Google Docs
- Markdown files

Use the import feature in the web UI under Settings → Import.

## Features

- **Real-time Collaboration**: Multiple users can edit documents simultaneously
- **Markdown Support**: Write using familiar Markdown syntax with live preview
- **Collections**: Organize documents into collections with nested structure
- **Search**: Fast full-text search across all documents
- **Version History**: Track changes and restore previous versions
- **Templates**: Create reusable document templates
- **Integrations**: Connect with Slack, Figma, and other tools
- **API Access**: Programmatic access to documents and collections
- **Dark Mode**: Built-in dark theme support
- **Mobile Friendly**: Responsive design works on all devices

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Ensure SECRET_KEY and UTILS_SECRET are at least 32 characters. Check logs with `docker logs outline_app`.

### Cannot Sign In

- **Symptoms**: OAuth authentication fails
- **Solution**: Verify OAuth provider credentials are correct. Ensure OUTLINE_URL matches your actual URL. Check that redirect URIs are configured in your OAuth app.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Ensure the database container is running and healthy. Check DATABASE_URL format is correct.

### File Upload Errors

- **Symptoms**: Cannot upload images or attachments
- **Solution**: Check volume permissions. Ensure FILE_STORAGE_LOCAL_ROOT_DIR is writable.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate secure SECRET_KEY and UTILS_SECRET (at least 32 characters each)
- Change the database password
- Use HTTPS with a reverse proxy (set FORCE_HTTPS=true)
- Configure proper OAuth redirect URIs
- Restrict access with firewall rules
- Regular backups are essential
- Consider using S3 for file storage in production

## Resources

- [Official Documentation](https://docs.getoutline.com/)
- [GitHub Repository](https://github.com/outline/outline)
- [Docker Hub](https://hub.docker.com/r/outlinewiki/outline)
- [API Documentation](https://www.getoutline.com/developers)
