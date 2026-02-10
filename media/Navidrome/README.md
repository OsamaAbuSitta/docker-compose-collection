# Navidrome

A modern music server and streamer compatible with Subsonic/Airsonic. Stream your music collection from anywhere with a beautiful web interface and mobile apps.

**Official Sites:**
- [Navidrome](https://www.navidrome.org/) | [Docker Hub](https://hub.docker.com/r/deluan/navidrome)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f navidrome.yaml up -d
```

## Services

### Navidrome
- **URL**: http://localhost:4533
- **Container**: `navidrome`
- **Note**: Create account on first visit

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Set `MUSIC_PATH` to your music directory
   - Adjust `NAVIDROME_PORT` if needed
2. Start the service with `docker compose -f navidrome.yaml up -d`
3. Navigate to http://localhost:4533
4. Create your admin account
5. Navidrome will automatically scan your music library

## Configuration

### Environment Variables (.env)

- `NAVIDROME_PORT` - Web interface port (default: 4533)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)
- `MUSIC_PATH` - Path to music files
- `ND_LOGLEVEL` - Log level (info, debug, error)
- `ND_SESSIONTIMEOUT` - Session timeout duration
- `ND_BASEURL` - Base URL if behind reverse proxy

## Volumes

- `navidrome-data` - Application data and database
- Music library is mounted from host path

## Features

- **Music Streaming**: Stream your music collection
- **Subsonic Compatible**: Works with Subsonic clients
- **Mobile Apps**: Use any Subsonic-compatible app
- **Playlists**: Create and manage playlists
- **Smart Playlists**: Auto-generated playlists
- **Scrobbling**: Last.fm and ListenBrainz support
- **Multi-User**: Support for multiple users
- **Transcoding**: On-the-fly audio transcoding
- **Album Art**: Automatic cover art fetching
- **Fast Scanning**: Quick library updates

## Compatible Mobile Apps

- **iOS**: play:Sub, substreamer, Amperfy
- **Android**: DSub, Ultrasonic, Subtracks
- **Desktop**: Sublime Music, Sonixd

## Security Notes

⚠️ **Important**: For production use:
- Use strong passwords
- Use HTTPS with reverse proxy
- Restrict access with firewall rules

## Resources

- [Official Documentation](https://www.navidrome.org/docs/)
- [GitHub Repository](https://github.com/navidrome/navidrome)
- [Docker Hub](https://hub.docker.com/r/deluan/navidrome)
