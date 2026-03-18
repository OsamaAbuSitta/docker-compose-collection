# Kavita

A fast, feature-rich, cross-platform reading server for comics, manga, and books. Kavita provides a beautiful interface for organizing and reading your digital library.

**Official Sites:**
- [Kavita](https://www.kavitareader.com/) | [Docker Hub](https://hub.docker.com/r/kizaing/kavita)

## Quick Start

```bash
cp .env.example .env
mkdir -p library
docker compose -f kavita.yaml up -d
```

## Access

- **URL**: http://localhost:5000
- Create admin account on first visit

## Configuration

Environment variables in `.env`:
- `KAVITA_PORT` - Web port (default: 5000)
- `TZ` - Timezone
- `LIBRARY_DIR` - Library directory (default: ./library)

## Features

- Comics (CBZ, CBR, CB7, CBT)
- Manga and books (EPUB, PDF)
- Metadata management
- Reading progress tracking
- Collections and reading lists
- OPDS support
- Mobile apps (iOS/Android)

## Resources

- [Official Site](https://www.kavitareader.com/)
- [Documentation](https://wiki.kavitareader.com/)
- [GitHub](https://github.com/Kareadita/Kavita)
