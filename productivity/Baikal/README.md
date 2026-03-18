# Baïkal

A lightweight CalDAV and CardDAV server. Sync calendars and contacts with a web interface.

**Official Sites:**
- [Baïkal](https://sabre.io/baikal/) | [Docker Hub](https://hub.docker.com/r/ckulka/baikal)

## Quick Start

```bash
cp .env.example .env
docker compose -f baikal.yaml up -d
```

## Access
- **URL**: http://localhost
- Complete setup wizard on first visit

## Configuration
- `BAIKAL_PORT` - Web port (default: 80)
- `TZ` - Timezone

## Features
- CalDAV calendar sync
- CardDAV contact sync
- Web-based admin interface
- User management

## Resources
- [Official Site](https://sabre.io/baikal/)
- [Documentation](https://sabre.io/baikal/install/)
