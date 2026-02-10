# ArchiveBox

Open-source self-hosted web archiving. Save complete copies of websites for offline viewing.

**Official Sites:**
- [ArchiveBox](https://archivebox.io/) | [Docker Hub](https://hub.docker.com/r/archivebox/archivebox)

## Quick Start

```bash
cp .env.example .env
docker compose -f archivebox.yaml up -d
```

## Access
- **URL**: http://localhost:8000
- Create admin account on first visit

## Configuration
- `ARCHIVEBOX_PORT` - Web port (default: 8000)
- `TZ` - Timezone

## Features
- Complete web page archiving
- Multiple archive formats (HTML, PDF, screenshots)
- Search archived content
- Browser extensions
- Import from browsers

## Resources
- [Official Site](https://archivebox.io/)
- [Documentation](https://github.com/ArchiveBox/ArchiveBox/wiki)
