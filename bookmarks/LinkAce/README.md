# LinkAce

A self-hosted bookmark archive with automatic backups. Organize, tag, and search your bookmarks with a clean interface.

**Official Sites:**
- [LinkAce](https://www.linkace.org/) | [Docker Hub](https://hub.docker.com/r/linkace/linkace)

## Quick Start

```bash
cp .env.example .env
# Edit .env - change APP_KEY and passwords
docker compose -f linkace.yaml up -d
```

## Access
- **URL**: http://localhost
- Create account on first visit

## Configuration
- `LINKACE_PORT` - Web port (default: 80)
- `MYSQL_PASSWORD` - Database password (change!)
- `APP_KEY` - Application key (generate with `php artisan key:generate`)

## Features
- Bookmark organization with tags
- Automatic backups
- Full-text search
- Import from browsers
- API access

## Resources
- [Official Site](https://www.linkace.org/)
- [Documentation](https://www.linkace.org/docs/)
