# Miniflux

A minimalist and opinionated RSS feed reader. Fast, simple, and focused on reading.

**Official Sites:**
- [Miniflux](https://miniflux.app/) | [Docker Hub](https://hub.docker.com/r/miniflux/miniflux)

## Quick Start

```bash
cp .env.example .env
# Edit .env - change passwords
docker compose -f miniflux.yaml up -d
```

## Access

- **URL**: http://localhost:8080
- **Username**: `admin` (from .env)
- **Password**: `P@ss0rd123` (change in .env)

## Configuration

Environment variables in `.env`:
- `MINIFLUX_PORT` - Web port (default: 8080)
- `ADMIN_USERNAME` - Admin username
- `ADMIN_PASSWORD` - Admin password (change!)
- `POSTGRES_PASSWORD` - Database password (change!)

## Features

- Fast and lightweight
- Keyboard shortcuts
- Fever API support
- Full-text search
- Feed discovery
- Bookmarklet
- Mobile-friendly
- Dark mode
- Multiple themes

## Resources

- [Official Site](https://miniflux.app/)
- [Documentation](https://miniflux.app/docs/)
- [GitHub](https://github.com/miniflux/v2)
