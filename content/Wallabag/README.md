# Wallabag

A self-hosted read-it-later application. Save web articles for offline reading with a clean, distraction-free interface.

**Official Sites:**
- [Wallabag](https://wallabag.org/) | [Docker Hub](https://hub.docker.com/r/wallabag/wallabag)

## Quick Start

```bash
cp .env.example .env
# Edit .env - change SECRET_KEY and passwords
docker compose -f wallabag.yaml up -d
```

## Access

- **URL**: http://localhost:8080
- **Default Username**: `wallabag`
- **Default Password**: `wallabag`

## Configuration

Environment variables in `.env`:
- `WALLABAG_PORT` - Web port (default: 8080)
- `POSTGRES_PASSWORD` - Database password
- `SECRET_KEY` - Application secret (change!)
- `DOMAIN_NAME` - Public URL

## Features

- Save articles for later
- Clean reading interface
- Tag and organize articles
- Full-text search
- Export to EPUB/PDF
- Browser extensions
- Mobile apps
- RSS feeds
- API access

## Resources

- [Official Site](https://wallabag.org/)
- [Documentation](https://doc.wallabag.org/)
- [GitHub](https://github.com/wallabag/wallabag)
