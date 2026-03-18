# BookStack

A simple, self-hosted, easy-to-use platform for organizing and storing information. BookStack uses a hierarchical structure of Books, Chapters, and Pages to organize content, making it perfect for documentation, wikis, and knowledge bases.

**Official Sites:**
- [BookStack](https://www.bookstackapp.com/) | [Docker Hub](https://hub.docker.com/r/linuxserver/bookstack)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f bookstack.yaml up -d
```

## Services

### BookStack Application
- **URL**: http://localhost:6875
- **Container**: `bookstack_app`
- **Default Username**: `admin@admin.com`
- **Default Password**: `password`

### MySQL Database
- **Port**: 3306 (internal)
- **Container**: `bookstack_db`
- **Database**: `bookstack`
- **Username**: `bookstack`
- **Password**: `P@ss0rd123`
- **Root Password**: `P@ssw0rd@123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f bookstack.yaml up -d`
3. Wait for the application to initialize (check logs: `docker logs bookstack_app`)
4. Navigate to http://localhost:6875
5. Log in with default credentials:
   - Email: `admin@admin.com`
   - Password: `password`
6. **Important**: Change the admin password immediately
7. Configure your profile and settings

## Configuration

### Environment Variables (.env)

- `BOOKSTACK_PORT` - Web interface port (default: 6875)
- `APP_URL` - Public URL where BookStack is accessible
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password (change for production)
- `MYSQL_ROOT_PASSWORD` - MySQL root password (change for production)
- `PUID` - User ID for file permissions (default: 1000)
- `PGID` - Group ID for file permissions (default: 1000)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Mail Configuration (Optional)

Configure email settings in `.env` to enable notifications:
- `MAIL_DRIVER` - Mail driver (smtp, sendmail, etc.)
- `MAIL_HOST` - SMTP server hostname
- `MAIL_PORT` - SMTP server port
- `MAIL_FROM` - From email address
- `MAIL_FROM_NAME` - From name

### Custom Configuration

Edit the compose file to change ports or add environment variables. See the [official documentation](https://www.bookstackapp.com/docs/) for all available options.

## Content Organization

### Books, Chapters, and Pages Hierarchy

BookStack uses a three-level hierarchy:

1. **Books**: Top-level containers for related content
   - Create a book for each major topic or project
   - Books can contain chapters and pages

2. **Chapters**: Organize pages within a book
   - Group related pages together
   - Optional - pages can exist directly in books

3. **Pages**: Individual documents with content
   - Write content using the WYSIWYG editor or Markdown
   - Pages contain the actual documentation

### Creating Content

**Create a Book:**
1. Click "Books" in the top navigation
2. Click "Create New Book"
3. Enter name, description, and cover image
4. Set permissions

**Create a Chapter:**
1. Open a book
2. Click "New Chapter"
3. Enter chapter name and description

**Create a Page:**
1. Open a book or chapter
2. Click "New Page"
3. Enter page name
4. Write content using the editor
5. Save the page

## Features

- **WYSIWYG Editor**: Rich text editor with formatting options
- **Markdown Support**: Write pages in Markdown if preferred
- **Code Highlighting**: Syntax highlighting for code blocks
- **Image Management**: Upload and manage images
- **Attachments**: Attach files to pages
- **Search**: Full-text search across all content
- **Permissions**: Granular role-based access control
- **Revisions**: Track changes with page history
- **Templates**: Create page templates for consistency
- **Tags**: Organize content with tags
- **Comments**: Add comments to pages
- **Multi-Language**: Support for multiple languages
- **API**: RESTful API for automation
- **Export**: Export books, chapters, or pages as PDF, HTML, or Markdown

## Volumes

- `bookstack-config` - Application configuration and uploaded files
- `bookstack-db-data` - MySQL database files

## Common Tasks

### Change Admin Password

1. Log in as admin
2. Click your profile icon → "Edit Profile"
3. Click "Change Password"
4. Enter new password and save

### Create User Roles

1. Go to Settings → Roles
2. Click "Create New Role"
3. Set permissions for the role
4. Assign users to the role

### Backup Database

```bash
docker exec bookstack_db mysqldump -u bookstack -pP@ss0rd123 bookstack > bookstack_backup.sql
```

### Restore Database

```bash
cat bookstack_backup.sql | docker exec -i bookstack_db mysql -u bookstack -pP@ss0rd123 bookstack
```

### Export Content

Use the export feature in the web UI:
1. Open a book, chapter, or page
2. Click the "..." menu
3. Select "Export"
4. Choose format (PDF, HTML, Plain Text, or Markdown)

### Import Content

1. Create pages manually and paste content
2. Use the API for bulk imports
3. Import from Markdown files

## Troubleshooting

### Cannot Log In with Default Credentials

- **Symptoms**: Default admin credentials don't work
- **Solution**: The database may not have initialized properly. Check logs with `docker logs bookstack_app`. Try recreating the containers.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Ensure the database container is running and healthy. Check DB_HOST matches the database container name. Verify credentials are correct.

### Permission Errors

- **Symptoms**: Cannot upload files or save pages
- **Solution**: Check PUID and PGID match your user. Ensure volumes have correct permissions.

### Images Not Displaying

- **Symptoms**: Uploaded images show broken links
- **Solution**: Verify APP_URL is set correctly. Check that the bookstack-config volume is mounted properly.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- **Change default admin password immediately** (admin@admin.com / password)
- Change all database passwords
- Use HTTPS with a reverse proxy
- Configure proper authentication (LDAP, SAML, OAuth)
- Restrict access with firewall rules
- Regular backups are essential
- Keep the application updated
- Review and configure role permissions

## Resources

- [Official Documentation](https://www.bookstackapp.com/docs/)
- [GitHub Repository](https://github.com/BookStackApp/BookStack)
- [Docker Hub](https://hub.docker.com/r/linuxserver/bookstack)
- [API Documentation](https://demo.bookstackapp.com/api/docs)
