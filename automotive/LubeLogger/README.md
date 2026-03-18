# LubeLogger

A web-based vehicle maintenance and fuel mileage tracker. Track service records, fuel economy, and maintenance schedules.

**Official Sites:**
- [LubeLogger](https://github.com/hargata/lubelogger) | [Docker Hub](https://ghcr.io/hargata/lubelogger)

## Quick Start

```bash
cp .env.example .env
docker compose -f lubelogger.yaml up -d
```

## Access
- **URL**: http://localhost:8080
- Create account on first visit

## Configuration
- `LUBELOGGER_PORT` - Web port (default: 8080)
- `TZ` - Timezone

## Features
- Vehicle maintenance tracking
- Fuel mileage logging
- Service reminders
- Odometer tracking
- Cost analysis
- Multiple vehicle support
- Document storage
- Export data

## Resources
- [GitHub](https://github.com/hargata/lubelogger)
- [Documentation](https://github.com/hargata/lubelogger/wiki)
