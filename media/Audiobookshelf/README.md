# Audiobookshelf

A self-hosted audiobook and podcast server. Stream your audiobooks and podcasts with a beautiful web interface and mobile apps.

**Official Sites:**
- [Audiobookshelf](https://www.audiobookshelf.org/) | [Docker Hub](https://ghcr.io/advplyr/audiobookshelf)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f audiobookshelf.yaml up -d
```

## Services

### Audiobookshelf
- **URL**: http://localhost:13378
- **Container**: `audiobookshelf`
- **Note**: Create account on first visit

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Set `AUDIOBOOKS_PATH` to your audiobook directory
   - Set `PODCASTS_PATH` to your podcast directory
   - Adjust `AUDIOBOOKSHELF_PORT` if needed
2. Start the service with `docker compose -f audiobookshelf.yaml up -d`
3. Navigate to http://localhost:13378
4. Create your admin account
5. Add libraries and scan media

## Configuration

### Environment Variables (.env)

- `AUDIOBOOKSHELF_PORT` - Web interface port (default: 13378)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)
- `AUDIOBOOKS_PATH` - Path to audiobook files
- `PODCASTS_PATH` - Path to podcast files

## Volumes

- `audiobookshelf-config` - Application configuration
- `audiobookshelf-metadata` - Metadata and cover images
- Audiobooks and podcasts are mounted from host paths

## Features

- **Audiobook Streaming**: Stream audiobooks with progress tracking
- **Podcast Management**: Subscribe and download podcasts
- **Mobile Apps**: iOS and Android apps available
- **Progress Sync**: Sync progress across devices
- **Collections**: Organize books into collections
- **User Management**: Multiple user accounts
- **Sleep Timer**: Auto-stop playback
- **Playback Speed**: Adjust playback speed
- **Bookmarks**: Mark favorite positions

## Security Notes

⚠️ **Important**: For production use:
- Use strong passwords
- Use HTTPS with reverse proxy
- Restrict access with firewall rules

## Resources

- [Official Documentation](https://www.audiobookshelf.org/docs)
- [GitHub Repository](https://github.com/advplyr/audiobookshelf)
