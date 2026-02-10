# Docspell

A personal document organizer and archive. Docspell helps you organize and archive your documents with automatic tagging, full-text search, and powerful organization features. It's designed for personal use and small teams.

**Official Sites:**
- [Docspell](https://docspell.org/) | [Docker Hub](https://hub.docker.com/r/docspell/restserver)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially ADMIN_SECRET and passwords)

# Start the service
docker compose -f docspell.yaml up -d
```

## Services

### Docspell REST Server
- **URL**: http://localhost:7880
- **Container**: `docspell_restserver`
- **Description**: Main web interface and API

### Docspell Joex
- **Container**: `docspell_joex`
- **Description**: Job executor for document processing

### PostgreSQL Database
- **Container**: `docspell_db`
- **Database**: `docspell`
- **Username**: `docspell`
- **Password**: `P@ss0rd123`

### Apache Solr
- **Container**: `docspell_solr`
- **Description**: Full-text search engine

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Change `ADMIN_SECRET` to a secure value
   - Change `POSTGRES_PASSWORD` to a strong password

2. Start the services:
   ```bash
   docker compose -f docspell.yaml up -d
   ```

3. Wait for initialization (check logs):
   ```bash
   docker logs -f docspell_restserver
   ```

4. Access the web interface at http://localhost:7880

5. Create your first user account:
   - Click "Register" or "Sign Up"
   - Enter your details
   - Log in with your credentials

## Configuration

### Environment Variables (.env)

- `DOCSPELL_PORT` - Web interface port (default: 7880)
- `TZ` - Timezone for the container (default: UTC)
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production!)
- `POSTGRES_DB` - Database name
- `ADMIN_SECRET` - Admin endpoint secret (change for production!)

### Custom Configuration

Advanced configuration can be done through configuration files. See the official documentation for details.

## Using Docspell

### Adding Documents

**Method 1: Web Upload**
1. Log in to the web interface
2. Click the upload button
3. Select files or drag and drop
4. Documents are automatically processed

**Method 2: Email**
Configure email integration to forward documents via email

**Method 3: Scanner Integration**
Set up your scanner to send documents to Docspell

**Method 4: Mobile App**
Use the mobile app to scan and upload documents

### Organizing Documents

- **Tags**: Create and assign tags for categorization
- **Correspondents**: Track document senders/recipients
- **Concerning Persons**: Link documents to people
- **Equipment**: Associate documents with equipment/assets
- **Folders**: Organize with virtual folders
- **Custom Fields**: Add metadata fields

### Searching Documents

- **Full-text Search**: Search document content
- **Filters**: Filter by tags, dates, correspondents
- **Advanced Search**: Complex queries with multiple criteria
- **Saved Searches**: Save frequently used searches

### Processing Documents

Docspell automatically:
- Extracts text via OCR
- Analyzes content
- Suggests tags and metadata
- Detects dates and correspondents
- Creates thumbnails

## Volumes

- `docspell-db-data` - PostgreSQL database files
- `docspell-solr-data` - Solr search index

## Common Tasks

### Backup Documents

```bash
# Backup database
docker exec docspell_db pg_dump -U docspell docspell > docspell_backup.sql

# Backup Solr index
docker exec docspell_solr tar czf /tmp/solr_backup.tar.gz /var/solr
docker cp docspell_solr:/tmp/solr_backup.tar.gz ./solr_backup.tar.gz
```

### Restore from Backup

```bash
# Restore database
docker exec -i docspell_db psql -U docspell docspell < docspell_backup.sql

# Restore Solr index
docker cp ./solr_backup.tar.gz docspell_solr:/tmp/
docker exec docspell_solr tar xzf /tmp/solr_backup.tar.gz -C /
```

### Reindex Documents

```bash
# Trigger full reindex via admin endpoint
curl -X POST http://localhost:7880/api/v1/admin/reindex \
  -H "Docspell-Admin-Secret: your-admin-secret"
```

### Check Processing Status

```bash
# View REST server logs
docker logs -f docspell_restserver

# View job executor logs
docker logs -f docspell_joex
```

## Features

- **Automatic OCR**: Extract text from scanned documents
- **Full-text Search**: Find documents by content
- **Automatic Tagging**: ML-powered tag suggestions
- **Multi-user**: User management and permissions
- **Email Integration**: Import documents via email
- **Mobile Apps**: iOS and Android apps available
- **API**: RESTful API for automation
- **Custom Fields**: Flexible metadata
- **Workflows**: Automate document processing
- **Notifications**: Email notifications for events
- **Multi-language**: Support for multiple languages
- **Dark Mode**: Easy on the eyes

## Integration

### Email Integration

1. Configure email settings in Docspell
2. Get your unique email address
3. Forward documents to that address
4. Documents are automatically imported

### Scanner Integration

Configure your scanner to:
- Send files via email to Docspell
- Save to a watched folder
- Use the Docspell API

### API Usage

```bash
# Get API token from web interface
# Example: Upload document
curl -X POST http://localhost:7880/api/v1/sec/upload \
  -H "X-Docspell-Auth: YOUR_TOKEN" \
  -F "file=@document.pdf"
```

## Troubleshooting

### OCR Not Working

- Check job executor logs: `docker logs docspell_joex`
- Verify document quality
- Ensure sufficient resources (CPU/RAM)
- Check Tesseract installation

### Search Not Working

- Verify Solr is running: `docker ps`
- Check Solr health: `docker logs docspell_solr`
- Trigger reindex if needed
- Check Solr connection in logs

### Slow Performance

- Increase container resources
- Optimize PostgreSQL settings
- Check disk I/O performance
- Reduce concurrent processing

### Cannot Access Web Interface

- Verify port 7880 is not in use
- Check firewall settings
- Ensure container is running: `docker ps`
- Check logs: `docker logs docspell_restserver`

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change `ADMIN_SECRET` to a strong, unique value
- Change all default passwords
- Use HTTPS with a reverse proxy (nginx, Traefik)
- Restrict access with firewall rules
- Enable two-factor authentication if available
- Regular backups are essential
- Keep the application updated
- Use strong user passwords

## Resources

- [Official Documentation](https://docspell.org/docs/)
- [GitHub Repository](https://github.com/eikek/docspell)
- [Community Forum](https://github.com/eikek/docspell/discussions)
- [API Documentation](https://docspell.org/openapi/docspell-openapi.html)
