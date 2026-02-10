# Shiori

A simple bookmark manager built with Go. Fast, lightweight, and easy to use.

**Official Sites:**
- [Shiori](https://github.com/go-shiori/shiori) | [Docker Hub](https://ghcr.io/go-shiori/shiori)

## Quick Start

```bash
cp .env.example .env
docker compose -f shiori.yaml up -d
```

## Access
- **URL**: http://localhost:8080
- **Default Username**: `shiori`
- **Default Password**: `gopher`

## Configuration
- `SHIORI_PORT` - Web port (default: 8080)
- `TZ` - Timezone

## Features
- Simple bookmark management
- Archive web pages
- Full-text search
- Browser extensions
- CLI support

## Resources
- [GitHub](https://github.com/go-shiori/shiori)
