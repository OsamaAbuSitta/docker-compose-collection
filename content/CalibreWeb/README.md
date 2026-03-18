# Calibre-Web

A web app providing a clean interface for browsing, reading, and downloading eBooks using an existing Calibre database. Supports OPDS feeds for eReader integration.

**Official Sites:**
- [Calibre-Web](https://github.com/janeczku/calibre-web) | [Docker Hub](https://hub.docker.com/r/linuxserver/calibre-web)

## Quick Start

```bash
cp .env.example .env
mkdir -p books
docker compose -f calibre-web.yaml up -d
```

## Access

- **URL**: http://localhost:8083
- **Default Username**: `admin`
- **Default Password**: `admin123`

## Configuration

Environment variables in `.env`:
- `CALIBRE_PORT` - Web port (default: 8083)
- `PUID/PGID` - User/Group ID (default: 1000)
- `TZ` - Timezone
- `BOOKS_DIR` - Books directory (default: ./books)

## Features

- Browse and search eBook library
- Read books online
- Download in multiple formats
- OPDS feed for eReaders
- User management
- Send to Kindle
- Metadata editing

## Resources

- [GitHub](https://github.com/janeczku/calibre-web)
- [Documentation](https://github.com/janeczku/calibre-web/wiki)
