# Radicale

A simple CalDAV and CardDAV server. Sync calendars and contacts across devices.

**Official Sites:**
- [Radicale](https://radicale.org/) | [Docker Hub](https://hub.docker.com/r/tomsquest/docker-radicale)

## Quick Start

```bash
cp .env.example .env
docker compose -f radicale.yaml up -d
```

## Access
- **URL**: http://localhost:5232
- **CalDAV**: http://localhost:5232/username/calendar.ics/
- **CardDAV**: http://localhost:5232/username/contacts.vcf/

## Configuration
- `RADICALE_PORT` - Web port (default: 5232)
- `TZ` - Timezone

## Features
- CalDAV calendar sync
- CardDAV contact sync
- Simple authentication
- Cross-platform clients

## Resources
- [Official Site](https://radicale.org/)
- [Documentation](https://radicale.org/v3.html)
