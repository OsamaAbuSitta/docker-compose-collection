# HedgeDoc

The best platform to write and share markdown. HedgeDoc (formerly CodiMD) is a real-time collaborative markdown editor. It allows you to create and share notes, documentation, and presentations with your team.

**Official Sites:**
- [HedgeDoc](https://hedgedoc.org/) | [Docker Hub](https://quay.io/repository/hedgedoc/hedgedoc)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env and generate a secure CMD_SESSION_SECRET

# Start the service
docker compose -f hedgedoc.yaml up -d
```

## Services

### HedgeDoc Application
- **URL**: http://localhost:3000
- **Container**: `hedgedoc_app`
- **Note**: Anonymous access enabled by default

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `hedgedoc_db`
- **Database**: `hedgedoc`
- **Username**: `hedgedoc`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate a secure session secret:
   ```bash
   openssl rand -hex 32
   ```
3. Update `.env` with the generated CMD_SESSION_SECRET
4. Start the service with `docker compose -f hedgedoc.yaml up -d`
5. Wait for the application to initialize (check logs: `docker logs hedgedoc_app`)
6. Navigate to http://localhost:3000
7. Start creating notes immediately (no account required with default settings)

## Configuration

### Environment Variables (.env)

- `HEDGEDOC_PORT` - Web interface port (default: 3000)
- `CMD_DOMAIN` - Domain name where HedgeDoc is accessible
- `CMD_URL_ADDPORT` - Add port to URLs (true for development)
- `CMD_PROTOCOL_USESSL` - Use HTTPS (false for development, true for production)
- `CMD_SESSION_SECRET` - Session secret key (generate with openssl rand -hex 32)
- `CMD_ALLOW_ANONYMOUS` - Allow anonymous access (true/false)
- `CMD_ALLOW_ANONYMOUS_EDITS` - Allow anonymous users to edit (true/false)
- `CMD_ALLOW_FREEURL` - Allow custom note URLs (true/false)
- `CMD_DEFAULT_PERMISSION` - Default note permission (freely, editable, limited, locked, protected, private)
- `CMD_IMAGE_UPLOAD_TYPE` - Image storage (filesystem, s3, imgur, azure, etc.)
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password (change for production)
- `POSTGRES_DB` - Database name
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Authentication Configuration

HedgeDoc supports multiple authentication methods. Add to `.env`:

**Email/Password:**
```bash
CMD_EMAIL=true
CMD_ALLOW_EMAIL_REGISTER=true
```

**LDAP:**
```bash
CMD_LDAP_URL=ldap://ldap.example.com
CMD_LDAP_BINDDN=cn=admin,dc=example,dc=com
CMD_LDAP_BINDCREDENTIALS=password
CMD_LDAP_SEARCHBASE=ou=users,dc=example,dc=com
```

**OAuth (Google, GitHub, etc.):**
```bash
CMD_OAUTH2_CLIENT_ID=your_client_id
CMD_OAUTH2_CLIENT_SECRET=your_client_secret
```

See the [official documentation](https://docs.hedgedoc.org/configuration/) for all authentication options.

## Using HedgeDoc

### Creating Notes

1. Navigate to http://localhost:3000
2. Click "New note" or press `Ctrl+Alt+N`
3. Start writing in Markdown
4. Changes are saved automatically
5. Share the URL with collaborators

### Collaborative Editing

- **Real-time**: Multiple users can edit simultaneously
- **Cursors**: See other users' cursors and selections
- **User list**: View who's currently editing
- **Comments**: Add comments to discuss changes

### Markdown Features

HedgeDoc supports extended Markdown:
- Standard Markdown syntax
- Tables
- Task lists
- Emoji `:smile:`
- Code blocks with syntax highlighting
- Math equations (KaTeX)
- Diagrams (Mermaid, GraphViz, PlantUML)
- Embedded content (YouTube, Vimeo, etc.)
- Slide mode for presentations

### Note Permissions

Set permissions for each note:
- **Freely**: Anyone can edit
- **Editable**: Signed-in users can edit
- **Limited**: Signed-in users can edit, view link required
- **Locked**: Only owner can edit, others can view
- **Protected**: Only owner can edit, view link required
- **Private**: Only owner can view and edit

### Presentation Mode

Create presentations from your notes:
1. Use `---` to separate slides
2. Click the presentation icon
3. Use arrow keys to navigate
4. Press `Esc` to exit

## Features

- **Real-time Collaboration**: Multiple users editing simultaneously
- **Markdown Editor**: Split-screen editor with live preview
- **Syntax Highlighting**: Support for 100+ programming languages
- **Diagrams**: Mermaid, GraphViz, PlantUML, and more
- **Math**: KaTeX for mathematical equations
- **Presentations**: Create slides from Markdown
- **Export**: Export as Markdown, HTML, or PDF
- **Versioning**: View note history and revisions
- **Templates**: Create note templates
- **Bookmarks**: Bookmark frequently used notes
- **Tags**: Organize notes with tags
- **Search**: Full-text search across all notes
- **Mobile Friendly**: Responsive design

## Volumes

- `hedgedoc-uploads` - Uploaded images and files
- `hedgedoc-db-data` - PostgreSQL database files

## Common Tasks

### Backup Database

```bash
docker exec hedgedoc_db pg_dump -U hedgedoc hedgedoc > hedgedoc_backup.sql
```

### Restore Database

```bash
cat hedgedoc_backup.sql | docker exec -i hedgedoc_db psql -U hedgedoc hedgedoc
```

### View Application Logs

```bash
docker logs hedgedoc_app
```

### Export Note

Use the export feature in the note menu:
1. Open a note
2. Click the menu icon (...)
3. Select "Download"
4. Choose format (Markdown, HTML, or PDF)

### Create Note Template

1. Create a note with template content
2. Share the note URL
3. Users can duplicate the template to create new notes

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check that CMD_SESSION_SECRET is set. Verify database connection. Check logs with `docker logs hedgedoc_app`.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Ensure the database container is running and healthy. Verify CMD_DB_URL format is correct.

### Cannot Upload Images

- **Symptoms**: Image upload fails
- **Solution**: Check CMD_IMAGE_UPLOAD_TYPE is set correctly. Ensure hedgedoc-uploads volume is writable. Check volume permissions.

### Real-time Sync Not Working

- **Symptoms**: Changes don't appear for other users
- **Solution**: Check WebSocket connection. Ensure reverse proxy (if used) supports WebSockets. Check browser console for errors.

### Note Not Found

- **Symptoms**: "Note not found" error when accessing a note
- **Solution**: Check that the note URL is correct. Verify note permissions allow access. Check database for note existence.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure CMD_SESSION_SECRET (at least 32 characters)
- Change the database password
- Use HTTPS with a reverse proxy (set CMD_PROTOCOL_USESSL=true)
- Disable anonymous access if not needed (CMD_ALLOW_ANONYMOUS=false)
- Configure proper authentication (email, LDAP, OAuth)
- Restrict access with firewall rules
- Regular backups are essential
- Keep the application updated
- Review note permissions regularly

## Resources

- [Official Documentation](https://docs.hedgedoc.org/)
- [GitHub Repository](https://github.com/hedgedoc/hedgedoc)
- [Docker Hub](https://quay.io/repository/hedgedoc/hedgedoc)
- [Community Forum](https://community.hedgedoc.org/)
