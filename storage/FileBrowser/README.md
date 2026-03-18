# File Browser

A web-based file manager with a simple and intuitive interface. File Browser provides a clean way to browse, upload, download, and manage files on your server through a web interface.

**Official Sites:**
- [File Browser](https://filebrowser.org/) | [Docker Hub](https://hub.docker.com/r/filebrowser/filebrowser)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Create files directory
mkdir -p files

# Start the service
docker compose -f file-browser.yaml up -d
```

## Services

### File Browser
- **URL**: http://localhost:8080
- **Container**: `filebrowser`
- **Default Username**: `admin`
- **Default Password**: `admin`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Create the files directory: `mkdir -p files`
3. Start the service: `docker compose -f file-browser.yaml up -d`
4. Access at http://localhost:8080
5. Log in with default credentials (admin/admin)
6. **Important**: Change the default password immediately

## Configuration

### Environment Variables (.env)

- `FILEBROWSER_PORT` - Web interface port (default: 8080)
- `TZ` - Timezone (default: UTC)
- `FILES_DIR` - Root directory to serve (default: ./files)

## Features

- **File Management**: Upload, download, move, copy, delete files
- **User Management**: Multiple users with different permissions
- **File Sharing**: Share files with public links
- **File Editing**: Edit text files directly in the browser
- **Search**: Search for files and folders
- **Archive Support**: Create and extract ZIP archives
- **Preview**: Preview images, videos, and documents
- **Mobile Friendly**: Responsive design

## Common Tasks

### Change Admin Password

```bash
# Via web interface: Settings → User Management → Edit admin user
```

### Add Users

```bash
# Via web interface: Settings → User Management → New User
```

### Share Files

```bash
# Right-click file → Share → Generate link
```

## Security Notes

⚠️ **Important**: Change the default admin password immediately after first login!

## Resources

- [Official Documentation](https://filebrowser.org/configuration)
- [GitHub Repository](https://github.com/filebrowser/filebrowser)
