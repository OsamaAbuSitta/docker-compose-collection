# OnlyOffice Docs

An online office suite comprising viewers and editors for texts, spreadsheets, and presentations. OnlyOffice Docs provides powerful document editing capabilities with real-time collaboration, compatible with Microsoft Office formats.

**Official Sites:**
- [OnlyOffice](https://www.onlyoffice.com/) | [Docker Hub](https://hub.docker.com/r/onlyoffice/documentserver)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially JWT_SECRET and passwords)

# Start the service
docker compose -f onlyoffice-docs.yaml up -d
```

## Services

### OnlyOffice Document Server
- **URL**: http://localhost:8080
- **HTTPS URL**: https://localhost:8443
- **Container**: `onlyoffice-docs`
- **Description**: Document editing server

### PostgreSQL Database
- **Container**: `onlyoffice_db`
- **Database**: `onlyoffice`
- **Username**: `onlyoffice`
- **Password**: `P@ss0rd123`

### RabbitMQ
- **Container**: `onlyoffice_rabbitmq`
- **Description**: Message queue for document processing

### Redis
- **Container**: `onlyoffice_redis`
- **Description**: Caching layer

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Change `JWT_SECRET` to a secure random string
   - Change `POSTGRES_PASSWORD` to a strong password

2. Start the services:
   ```bash
   docker compose -f onlyoffice-docs.yaml up -d
   ```

3. Wait for initialization (this may take a few minutes):
   ```bash
   docker logs -f onlyoffice-docs
   ```

4. Access the document server at http://localhost:8080

5. The server is ready when you see "Document Server is running"

## Configuration

### Environment Variables (.env)

- `ONLYOFFICE_PORT` - HTTP port (default: 8080)
- `ONLYOFFICE_HTTPS_PORT` - HTTPS port (default: 8443)
- `TZ` - Timezone for the container (default: UTC)
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production!)
- `POSTGRES_DB` - Database name
- `JWT_ENABLED` - Enable JWT authentication (default: true)
- `JWT_SECRET` - JWT secret key (change for production!)

### JWT Configuration

JWT (JSON Web Token) is used to secure the document server. When integrating with applications:
- Set `JWT_ENABLED=true` for production
- Use the same `JWT_SECRET` in your application
- Include JWT token in document editor requests

## Using OnlyOffice Docs

### Integration with Applications

OnlyOffice Docs is designed to be integrated with other applications:

**Compatible Platforms:**
- Nextcloud
- ownCloud
- Seafile
- Alfresco
- Confluence
- SharePoint
- And many more...

### Standalone Testing

To test the document server:

1. Create a simple HTML file with the OnlyOffice API
2. Open documents using the JavaScript API
3. See the official documentation for examples

### Document Formats

**Supported Formats:**
- **Text Documents**: DOCX, DOC, ODT, TXT, PDF, HTML, EPUB
- **Spreadsheets**: XLSX, XLS, ODS, CSV
- **Presentations**: PPTX, PPT, ODP

**Editing Formats:**
- DOCX, XLSX, PPTX (native)
- Other formats converted on-the-fly

## Volumes

- `onlyoffice-data` - Document server data and cache
- `onlyoffice-logs` - Application logs
- `onlyoffice-db-data` - PostgreSQL database files
- `onlyoffice-rabbitmq-data` - RabbitMQ data
- `onlyoffice-redis-data` - Redis cache data

## Common Tasks

### Check Server Status

```bash
# View logs
docker logs -f onlyoffice-docs

# Check if server is ready
curl http://localhost:8080/healthcheck
```

### Backup Data

```bash
# Backup database
docker exec onlyoffice_db pg_dump -U onlyoffice onlyoffice > onlyoffice_backup.sql

# Backup document data
docker cp onlyoffice-docs:/var/www/onlyoffice/Data ./data_backup
```

### Restore from Backup

```bash
# Restore database
docker exec -i onlyoffice_db psql -U onlyoffice onlyoffice < onlyoffice_backup.sql

# Restore document data
docker cp ./data_backup onlyoffice-docs:/var/www/onlyoffice/Data
```

### Update OnlyOffice

```bash
# Pull latest image
docker compose -f onlyoffice-docs.yaml pull

# Restart services
docker compose -f onlyoffice-docs.yaml up -d
```

## Integration Examples

### Nextcloud Integration

1. Install OnlyOffice app in Nextcloud
2. Configure document server URL: `http://onlyoffice-docs:80`
3. Set JWT secret to match your configuration
4. Test connection

### Custom Application Integration

```javascript
// Example: Initialize document editor
new DocsAPI.DocEditor("placeholder", {
    "document": {
        "fileType": "docx",
        "key": "unique-document-key",
        "title": "Document.docx",
        "url": "https://example.com/document.docx"
    },
    "documentType": "word",
    "editorConfig": {
        "callbackUrl": "https://example.com/callback"
    },
    "token": "your-jwt-token"
});
```

## Features

- **Real-time Collaboration**: Multiple users editing simultaneously
- **Comments and Review**: Track changes and add comments
- **Version History**: View and restore previous versions
- **Plugins**: Extend functionality with plugins
- **Mobile Editing**: Responsive design for mobile devices
- **Format Conversion**: Convert between document formats
- **PDF Export**: Export documents to PDF
- **Mail Merge**: Create documents from templates
- **Macros**: Automate tasks with macros
- **Forms**: Create fillable forms
- **Digital Signatures**: Sign documents digitally

## Troubleshooting

### Server Not Starting

- Check logs: `docker logs onlyoffice-docs`
- Verify all dependencies are running
- Ensure sufficient resources (2GB+ RAM recommended)
- Check port conflicts

### Cannot Edit Documents

- Verify JWT configuration matches your application
- Check JWT_SECRET is the same in both systems
- Ensure document URLs are accessible from the server
- Check firewall settings

### Slow Performance

- Increase container resources (CPU/RAM)
- Check database performance
- Optimize Redis configuration
- Use SSD storage for better I/O

### Integration Issues

- Verify document server URL is correct
- Check JWT token generation
- Ensure callback URL is accessible
- Review application logs

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change `JWT_SECRET` to a strong, unique value
- Change all default passwords
- Use HTTPS with valid SSL certificates
- Restrict access with firewall rules
- Keep the application updated
- Regular backups are essential
- Use strong database passwords
- Enable JWT authentication
- Restrict network access to trusted sources

## Resources

- [Official Documentation](https://api.onlyoffice.com/editors/basic)
- [GitHub Repository](https://github.com/ONLYOFFICE/DocumentServer)
- [API Documentation](https://api.onlyoffice.com/)
- [Integration Examples](https://github.com/ONLYOFFICE/document-server-integration)
- [Docker Hub](https://hub.docker.com/r/onlyoffice/documentserver)
