# Mailpit

An email testing tool for developers. Catch and view emails sent from your applications.

**Official Sites:**
- [Mailpit](https://github.com/axllent/mailpit) | [Docker Hub](https://hub.docker.com/r/axllent/mailpit)

## Quick Start

```bash
cp .env.example .env
docker compose -f mailpit.yaml up -d
```

## Access
- **Web UI**: http://localhost:8025
- **SMTP**: localhost:1025

## Configuration
- `SMTP_PORT` - SMTP port (default: 1025)
- `WEB_PORT` - Web UI port (default: 8025)
- `TZ` - Timezone

## Features
- Catch all emails
- Web interface for viewing
- Search and filter
- API access
- No authentication required

## Resources
- [GitHub](https://github.com/axllent/mailpit)
