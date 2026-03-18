# Mailhog

Email testing tool for developers. Catch emails and view them in a web interface.

**Official Sites:**
- [Mailhog](https://github.com/mailhog/MailHog) | [Docker Hub](https://hub.docker.com/r/mailhog/mailhog)

## Quick Start

```bash
cp .env.example .env
docker compose -f mailhog.yaml up -d
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
- Web interface
- API access
- Jim mode (chaos testing)

## Resources
- [GitHub](https://github.com/mailhog/MailHog)
