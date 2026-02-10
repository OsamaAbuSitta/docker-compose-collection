# Immich

A self-hosted photo and video backup solution directly from your mobile phone. Immich provides automatic backup, AI-powered search, face recognition, and more.

**Official Sites:**
- [Immich](https://immich.app/) | [Docker Hub](https://ghcr.io/immich-app/immich-server)

## Quick Start

```bash
docker compose -f immich.yaml up -d
```

## Services

### Immich Server
- **URL**: http://localhost:2283
- **Container**: `immich_server`
- **Note**: Create account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `immich_db`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `immich_redis`

## Initial Setup

1. Start services with `docker compose -f immich.yaml up -d`
2. Navigate to http://localhost:2283
3. Create your admin account
4. Download Immich mobile app (iOS/Android)
5. Configure mobile app to connect to server
6. Enable automatic backup

## Volumes

- `immich-upload` - Uploaded photos and videos
- `immich-db-data` - PostgreSQL database

## Features

- **Automatic Backup**: Auto-upload from mobile
- **AI Search**: Search photos by content
- **Face Recognition**: Identify people
- **Albums**: Organize photos
- **Sharing**: Share albums with others
- **Timeline**: Chronological view
- **Map View**: View photos by location
- **Mobile Apps**: iOS and Android

## Security Notes

⚠️ **Important**: For production use:
- Change database password
- Use HTTPS with reverse proxy
- Regular backups essential

## Resources

- [Official Documentation](https://immich.app/docs)
- [GitHub Repository](https://github.com/immich-app/immich)
