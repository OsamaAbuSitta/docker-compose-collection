# Syncthing

A continuous file synchronization program that synchronizes files between two or more computers in real time. Syncthing is decentralized, secure, and respects your privacy.

**Official Sites:**
- [Syncthing](https://syncthing.net/) | [Docker Hub](https://hub.docker.com/r/syncthing/syncthing)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Create data directory
mkdir -p data

# Start the service
docker compose -f syncthing.yaml up -d
```

## Services

### Syncthing
- **URL**: http://localhost:8384
- **Container**: `syncthing`
- **Sync Port**: 22000 (TCP/UDP)
- **Discovery Port**: 21027 (UDP)

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Create data directory: `mkdir -p data`
3. Start the service: `docker compose -f syncthing.yaml up -d`
4. Access at http://localhost:8384
5. Complete the setup wizard
6. Add devices and folders to sync

## Configuration

### Environment Variables (.env)

- `SYNCTHING_WEB_PORT` - Web UI port (default: 8384)
- `SYNCTHING_LISTEN_PORT` - Sync port (default: 22000)
- `SYNCTHING_DISCOVERY_PORT` - Discovery port (default: 21027)
- `PUID` - User ID (default: 1000)
- `PGID` - Group ID (default: 1000)
- `TZ` - Timezone (default: UTC)
- `DATA_DIR` - Data directory (default: ./data)

## Features

- **Decentralized**: No central server required
- **Secure**: All communication is encrypted
- **Private**: Your data stays on your devices
- **Cross-platform**: Windows, macOS, Linux, Android
- **Versioning**: Keep old versions of files
- **Selective Sync**: Choose which folders to sync
- **Conflict Resolution**: Handles file conflicts gracefully

## Common Tasks

### Add a Device

```bash
# 1. Get your device ID from the web UI
# 2. On the other device, add this device ID
# 3. Accept the connection on both sides
```

### Add a Folder

```bash
# 1. Click "Add Folder" in the web UI
# 2. Select the folder path
# 3. Choose which devices to share with
# 4. Configure sync options
```

## Resources

- [Official Documentation](https://docs.syncthing.net/)
- [GitHub Repository](https://github.com/syncthing/syncthing)
