# Wiki.js

A modern and powerful wiki app built on Node.js. Wiki.js features a beautiful interface, powerful search, and supports multiple authentication methods. It's perfect for documentation, knowledge bases, and team wikis.

**Official Sites:**
- [Wiki.js](https://js.wiki/) | [Docker Hub](https://hub.docker.com/r/requarks/wiki)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f wikijs.yaml up -d
```

## Services

### Wiki.js Application
- **URL**: http://localhost:3000
- **Container**: `wikijs_app`
- **Note**: Create admin account during initial setup

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `wikijs_db`
- **Database**: `wikijs`
- **Username**: `wikijs`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f wikijs.yaml up -d`
3. Wait for the application to initialize (check logs: `docker logs wikijs_app`)
4. Navigate to http://localhost:3000
5. Complete the setup wizard:
   - Set administrator email and password
   - Configure site URL
   - Choose authentication method
   - Select storage target (local or cloud)
6. Start creating pages

## Configuration

### Environment Variables (.env)

- `WIKIJS_PORT` - Web interface port (default: 3000)
- `DB_USER` - Database username
- `DB_PASS` - Database password (change for production)
- `DB_NAME` - Database name
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Most configuration is done through the web UI under Administration. You can configure:
- Authentication providers (Local, LDAP, OAuth, SAML)
- Storage targets (Local, Git, S3, Azure, etc.)
- Rendering engines (Markdown, HTML, etc.)
- Search engines (Database, Elasticsearch, Algolia)
- Themes and appearance

## Wiki Setup

### Creating Pages

1. Click the "New Page" button (+ icon)
2. Choose a path for the page (URL structure)
3. Select an editor:
   - **Markdown**: Write in Markdown syntax
   - **Visual Editor**: WYSIWYG editor
   - **Code**: Raw HTML/CSS
4. Write your content
5. Click "Create" to save

### Page Organization

- **Folders**: Organize pages in a hierarchical folder structure
- **Tags**: Add tags to pages for categorization
- **Navigation**: Configure sidebar navigation in Administration
- **Home Page**: Set a default home page for your wiki

### Markdown Editing

Wiki.js supports standard Markdown plus extensions:
- Tables
- Task lists
- Emoji
- Footnotes
- Code blocks with syntax highlighting
- Math equations (KaTeX)
- Diagrams (Mermaid, PlantUML)

## Features

- **Multiple Editors**: Markdown, Visual, Code, and more
- **Version Control**: Track changes with Git integration
- **Search**: Powerful full-text search
- **Authentication**: Support for LDAP, OAuth, SAML, and more
- **Permissions**: Granular page-level permissions
- **Themes**: Multiple themes and customization options
- **Localization**: Support for 50+ languages
- **API**: GraphQL API for automation
- **Storage**: Local, Git, S3, Azure, and more
- **Analytics**: Built-in analytics and Google Analytics integration
- **Comments**: Page comments and discussions
- **Export**: Export pages as PDF or HTML
- **Mobile Friendly**: Responsive design

## Volumes

- `wikijs-data` - Application data and uploaded files
- `wikijs-db-data` - PostgreSQL database files

## Common Tasks

### Backup Database

```bash
docker exec wikijs_db pg_dump -U wikijs wikijs > wikijs_backup.sql
```

### Restore Database

```bash
cat wikijs_backup.sql | docker exec -i wikijs_db psql -U wikijs wikijs
```

### View Application Logs

```bash
docker logs wikijs_app
```

### Configure Git Storage

1. Go to Administration → Storage
2. Click "Git" and configure:
   - Repository URL
   - Branch
   - Authentication credentials
3. Set sync schedule
4. Save configuration

### Enable LDAP Authentication

1. Go to Administration → Authentication
2. Click "LDAP / Active Directory"
3. Configure LDAP settings:
   - Server URL
   - Bind DN and password
   - Search base
   - User attributes
4. Test connection and save

### Export Pages

Use the export feature in the page menu:
1. Open a page
2. Click the page actions menu (...)
3. Select "Export"
4. Choose format (PDF or HTML)

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check database connection. Ensure database is initialized. Check logs with `docker logs wikijs_app`.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Ensure the database container is running and healthy. Verify DB_HOST, DB_USER, and DB_PASS are correct.

### Cannot Create Pages

- **Symptoms**: "Permission denied" when creating pages
- **Solution**: Check user permissions in Administration → Users & Groups. Ensure user has write permissions.

### Search Not Working

- **Symptoms**: Search returns no results
- **Solution**: Rebuild search index in Administration → Search Engine. Check that search engine is configured properly.

### Git Sync Failing

- **Symptoms**: Git storage sync errors
- **Solution**: Verify Git credentials are correct. Check repository URL and branch. Ensure Wiki.js has network access to Git server.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the database password
- Use HTTPS with a reverse proxy
- Configure proper authentication (LDAP, OAuth, SAML)
- Set up regular backups
- Restrict access with firewall rules
- Keep the application updated
- Review and configure page permissions
- Enable two-factor authentication for admin accounts

## Resources

- [Official Documentation](https://docs.requarks.io/)
- [GitHub Repository](https://github.com/requarks/wiki)
- [Docker Hub](https://hub.docker.com/r/requarks/wiki)
- [Community Forum](https://github.com/requarks/wiki/discussions)
