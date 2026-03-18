# Paperless-ngx

A community-supported supercharged version of Paperless: scan, index, and archive all your physical documents. Paperless-ngx transforms your physical documents into a searchable online archive with powerful OCR capabilities, automatic tagging, and full-text search.

**Official Sites:**
- [Paperless-ngx](https://docs.paperless-ngx.com/) | [Docker Hub](https://github.com/paperless-ngx/paperless-ngx/pkgs/container/paperless-ngx)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially SECRET_KEY and passwords)

# Create required directories
mkdir -p consume export

# Start the service
docker compose -f paperless-ngx.yaml up -d
```

## Services

### Paperless-ngx
- **URL**: http://localhost:8000
- **Container**: `paperless-ngx`
- **Username**: `admin` (configurable)
- **Password**: `P@ss0rd123` (change in .env)

### PostgreSQL Database
- **Container**: `paperless_db`
- **Database**: `paperless`
- **Username**: `paperless`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Container**: `paperless_redis`
- **Description**: Caching and task queue

### Apache Tika
- **Container**: `paperless_tika`
- **Description**: Document parsing and text extraction

### Gotenberg
- **Container**: `paperless_gotenberg`
- **Description**: PDF conversion service

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Generate a secure `SECRET_KEY` (at least 32 characters)
   - Change `ADMIN_PASSWORD` to a strong password
   - Set your `ADMIN_MAIL` email address
   - Configure `OCR_LANGUAGE` for your documents (default: eng)

2. Create required directories:
   ```bash
   mkdir -p consume export
   ```

3. Start the services:
   ```bash
   docker compose -f paperless-ngx.yaml up -d
   ```

4. Wait for initialization (check logs):
   ```bash
   docker logs -f paperless-ngx
   ```

5. Access the web interface at http://localhost:8000

6. Log in with your admin credentials

## Configuration

### Environment Variables (.env)

- `PAPERLESS_PORT` - Web interface port (default: 8000)
- `TZ` - Timezone for the container (default: UTC)
- `SECRET_KEY` - Secret key for encryption (change for production!)
- `PAPERLESS_URL` - Public URL for the application
- `ADMIN_USER` - Admin username (default: admin)
- `ADMIN_PASSWORD` - Admin password (change for production!)
- `ADMIN_MAIL` - Admin email address
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production!)
- `POSTGRES_DB` - Database name
- `OCR_LANGUAGE` - OCR language code (eng, deu, fra, etc.)
- `EXPORT_DIR` - Directory for document exports
- `CONSUME_DIR` - Directory for document ingestion

### OCR Languages

Common language codes:
- `eng` - English
- `deu` - German
- `fra` - French
- `spa` - Spanish
- `ita` - Italian
- `nld` - Dutch
- `por` - Portuguese
- `rus` - Russian
- `chi_sim` - Chinese Simplified
- `jpn` - Japanese

Multiple languages: `eng+deu+fra`

## Using Paperless-ngx

### Adding Documents

**Method 1: Web Upload**
1. Click **Upload** in the web interface
2. Select files or drag and drop
3. Documents are automatically processed

**Method 2: Consume Directory**
1. Place documents in the `consume` directory
2. Paperless automatically detects and processes them
3. Original files are moved after processing

**Method 3: Email**
Configure email consumption in settings to forward documents via email

**Method 4: Mobile App**
Use the Paperless Mobile app to scan and upload documents

### Organizing Documents

- **Tags**: Create and assign tags for categorization
- **Correspondents**: Track document senders/recipients
- **Document Types**: Classify documents by type
- **Custom Fields**: Add metadata fields
- **Folders**: Organize with virtual folders

### Searching Documents

- **Full-text Search**: Search document content
- **Filters**: Filter by tags, dates, correspondents
- **Advanced Search**: Use query syntax for complex searches
- **Saved Views**: Save frequently used search queries

## Volumes

- `paperless-data` - Application data and configuration
- `paperless-media` - Processed documents and thumbnails
- `paperless-db-data` - PostgreSQL database files
- `paperless-redis-data` - Redis cache data
- `consume` - Directory for document ingestion (mounted from host)
- `export` - Directory for document exports (mounted from host)

## Common Tasks

### Backup Documents

```bash
# Export all documents
docker exec paperless-ngx document_exporter /usr/src/paperless/export

# Backup database
docker exec paperless_db pg_dump -U paperless paperless > paperless_backup.sql

# Backup media files
docker cp paperless-ngx:/usr/src/paperless/media ./media_backup
```

### Restore from Backup

```bash
# Restore database
docker exec -i paperless_db psql -U paperless paperless < paperless_backup.sql

# Restore media files
docker cp ./media_backup paperless-ngx:/usr/src/paperless/media
```

### Reprocess Documents

```bash
# Reprocess all documents (useful after OCR language changes)
docker exec paperless-ngx document_retagger --overwrite
```

### Check Processing Status

```bash
# View logs
docker logs -f paperless-ngx

# Check task queue
# Access the admin interface at http://localhost:8000/admin/
```

## Features

- **Powerful OCR**: Automatic text extraction from scanned documents
- **Full-text Search**: Find documents by content
- **Automatic Tagging**: ML-powered tag suggestions
- **Document Matching**: Auto-assign tags, correspondents, and types
- **Email Integration**: Import documents via email
- **Mobile Apps**: iOS and Android apps available
- **API**: RESTful API for automation
- **Multi-user**: User management and permissions
- **Workflows**: Automate document processing
- **Export**: Export documents with metadata
- **Versioning**: Track document changes
- **Encryption**: Secure document storage

## Integration

### Scanner Integration

Configure your scanner to save files to the `consume` directory:
- Network scanners: Mount consume directory as SMB/NFS share
- Local scanners: Save directly to consume directory

### Email Integration

1. Configure email settings in Paperless
2. Get your unique email address
3. Forward documents to that address
4. Documents are automatically imported

### API Usage

```bash
# Get API token from web interface (Settings → API Tokens)
# Example: List documents
curl -H "Authorization: Token YOUR_TOKEN" http://localhost:8000/api/documents/
```

## Troubleshooting

### OCR Not Working

- Check OCR language is installed
- Verify document quality (resolution, contrast)
- Check logs: `docker logs paperless-ngx`
- Try reprocessing: `docker exec paperless-ngx document_retagger`

### Documents Not Consuming

- Check consume directory permissions
- Verify files are supported formats (PDF, images, Office docs)
- Check logs for errors
- Ensure no file locks on documents

### Slow Performance

- Increase Redis memory
- Add more CPU/RAM to containers
- Optimize PostgreSQL settings
- Reduce concurrent processing tasks

### Database Connection Errors

- Ensure database container is running
- Check database credentials in .env
- Verify network connectivity
- Check PostgreSQL logs

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a strong, unique `SECRET_KEY` (at least 32 characters)
- Change all default passwords
- Use HTTPS with a reverse proxy (nginx, Traefik)
- Restrict access with firewall rules
- Enable two-factor authentication
- Regular backups are essential
- Keep the application updated
- Use strong admin passwords
- Consider encryption at rest

## Resources

- [Official Documentation](https://docs.paperless-ngx.com/)
- [GitHub Repository](https://github.com/paperless-ngx/paperless-ngx)
- [Community Forum](https://github.com/paperless-ngx/paperless-ngx/discussions)
- [API Documentation](https://docs.paperless-ngx.com/api/)
