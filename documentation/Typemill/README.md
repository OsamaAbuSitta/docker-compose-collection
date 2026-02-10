# Typemill

A flat-file CMS for simple, beautiful websites and documentation. Typemill is a lightweight, file-based content management system that stores content in Markdown files. Perfect for documentation, manuals, and simple websites.

**Official Sites:**
- [Typemill](https://typemill.net/) | [Docker Hub](https://hub.docker.com/r/typemill/typemill)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f typemill.yaml up -d
```

## Services

### Typemill Application
- **URL**: http://localhost:8080
- **Container**: `typemill_app`
- **Note**: Create admin account on first visit

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f typemill.yaml up -d`
3. Wait for the application to initialize (check logs: `docker logs typemill_app`)
4. Navigate to http://localhost:8080/setup
5. Complete the setup wizard:
   - Create admin account
   - Configure site settings
   - Choose a theme
6. Start creating content

## Configuration

### Environment Variables (.env)

- `TYPEMILL_PORT` - Web interface port (default: 8080)
- `PUID` - User ID for file permissions (default: 1000)
- `PGID` - Group ID for file permissions (default: 1000)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Most configuration is done through the web UI under Settings. You can configure:
- Site information (title, description, author)
- Theme selection and customization
- Navigation structure
- User accounts and permissions
- Plugins and extensions
- SEO settings

## Content Management

### Creating Pages

1. Log in to the admin panel at http://localhost:8080/tm/login
2. Click "Content" in the navigation
3. Click "Add Page" or "Add Folder"
4. Enter page title and content
5. Write content using Markdown or the visual editor
6. Click "Publish" to make the page live

### Content Organization

- **Folders**: Organize pages in a hierarchical folder structure
- **Navigation**: Drag and drop to reorder pages
- **Drafts**: Save pages as drafts before publishing
- **Metadata**: Add metadata to pages (author, date, description)

### Markdown Editing

Typemill supports standard Markdown:
- Headings (`#`, `##`, `###`)
- Bold (`**text**`) and italic (`*text*`)
- Lists (ordered and unordered)
- Links (`[text](url)`)
- Images (`![alt](url)`)
- Code blocks with syntax highlighting
- Tables
- Blockquotes

### Visual Editor

The visual editor provides:
- Block-based editing
- Drag and drop blocks
- Image upload
- Table creation
- Code blocks
- Custom blocks via plugins

## Features

- **Flat-File**: No database required, content stored in Markdown files
- **Fast**: Lightweight and fast page loading
- **Markdown**: Write content in Markdown
- **Visual Editor**: Optional visual block editor
- **Themes**: Multiple themes available
- **Plugins**: Extend functionality with plugins
- **SEO Friendly**: Built-in SEO optimization
- **Responsive**: Mobile-friendly themes
- **Version Control**: Content files can be version controlled with Git
- **Multi-User**: Support for multiple user accounts
- **Media Library**: Upload and manage images and files
- **Navigation**: Automatic navigation generation
- **Search**: Built-in search functionality

## Volumes

- `typemill-content` - Markdown content files
- `typemill-settings` - Configuration and settings
- `typemill-themes` - Installed themes
- `typemill-plugins` - Installed plugins
- `typemill-media` - Uploaded images and files

## Common Tasks

### Backup Content

```bash
# Backup all volumes
docker run --rm -v typemill-content:/content -v $(pwd):/backup alpine tar czf /backup/typemill-backup.tar.gz /content
```

### Restore Content

```bash
# Restore from backup
docker run --rm -v typemill-content:/content -v $(pwd):/backup alpine tar xzf /backup/typemill-backup.tar.gz -C /
```

### Install Theme

1. Log in to the admin panel
2. Go to Settings → Themes
3. Browse available themes
4. Click "Install" on desired theme
5. Activate the theme

### Install Plugin

1. Log in to the admin panel
2. Go to Settings → Plugins
3. Browse available plugins
4. Click "Install" on desired plugin
5. Configure plugin settings

### Export Content

Content is stored as Markdown files in the `typemill-content` volume. You can:
1. Access files directly from the volume
2. Use Git to version control the content
3. Export via FTP/SFTP if needed

### Create User Account

1. Log in as admin
2. Go to Settings → Users
3. Click "Add User"
4. Enter username, email, and password
5. Set user role (admin or editor)
6. Save user

## Troubleshooting

### Cannot Access Admin Panel

- **Symptoms**: 404 error when accessing /tm/login
- **Solution**: Ensure the application has initialized. Check logs with `docker logs typemill_app`. Try accessing /setup first.

### Permission Errors

- **Symptoms**: Cannot save content or upload files
- **Solution**: Check PUID and PGID match your user. Ensure volumes have correct permissions. Check container logs.

### Theme Not Displaying

- **Symptoms**: Site shows default theme instead of selected theme
- **Solution**: Clear cache in Settings → System. Ensure theme is properly installed. Check theme files in typemill-themes volume.

### Content Not Saving

- **Symptoms**: Changes to pages are not saved
- **Solution**: Check volume permissions. Ensure typemill-content volume is writable. Check for disk space issues.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Create a strong admin password during setup
- Use HTTPS with a reverse proxy
- Restrict access to the admin panel (/tm/)
- Regular backups are essential
- Keep the application updated
- Review user permissions regularly
- Consider using .htaccess for additional security

## Resources

- [Official Documentation](https://typemill.net/documentation)
- [GitHub Repository](https://github.com/typemill/typemill)
- [Docker Hub](https://hub.docker.com/r/typemill/typemill)
- [Themes](https://typemill.net/themes)
- [Plugins](https://typemill.net/plugins)
