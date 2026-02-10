# PairDrop

A local file sharing service inspired by Apple's AirDrop. PairDrop allows you to share files between devices on the same network through a simple web interface - no installation required.

**Official Sites:**
- [PairDrop](https://github.com/schlagmichdoch/PairDrop) | [Docker Hub](https://hub.docker.com/r/linuxserver/pairdrop)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Start the service
docker compose -f pairdrop.yaml up -d
```

## Services

### PairDrop
- **URL**: http://localhost:3000
- **Container**: `pairdrop`
- **Description**: Local file sharing service

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service: `docker compose -f pairdrop.yaml up -d`
3. Access at http://localhost:3000
4. Open the same URL on other devices on your network
5. Devices will automatically discover each other

## Configuration

### Environment Variables (.env)

- `PAIRDROP_PORT` - Web interface port (default: 3000)
- `PUID` - User ID (default: 1000)
- `PGID` - Group ID (default: 1000)
- `TZ` - Timezone (default: UTC)
- `RATE_LIMIT` - Enable rate limiting (default: false)
- `WS_FALLBACK` - WebSocket fallback (default: false)

## Using PairDrop

### Sharing Files

1. Open PairDrop on both devices (same network)
2. Devices will appear automatically
3. Click on the target device
4. Select files to share
5. Recipient accepts the transfer
6. Files are transferred directly peer-to-peer

### Sharing Text

1. Click on a device
2. Select "Send Message"
3. Type or paste text
4. Send to the device

## Features

- **No Installation**: Works in any modern browser
- **Peer-to-Peer**: Direct transfer between devices
- **Local Network**: No internet required
- **Private**: Files never leave your network
- **Cross-platform**: Works on any device with a browser
- **No Size Limits**: Transfer files of any size
- **Multiple Files**: Send multiple files at once
- **Text Sharing**: Share text snippets quickly

## Troubleshooting

### Devices Not Appearing

- Ensure all devices are on the same network
- Check firewall settings
- Try refreshing the page
- Verify the service is running

### Transfer Fails

- Check network connectivity
- Ensure sufficient disk space
- Try smaller files first
- Check browser console for errors

## Security Notes

⚠️ **Important**: 
- PairDrop is designed for local network use only
- Do not expose to the internet without proper security
- Files are transferred directly between devices
- No authentication by default

## Resources

- [GitHub Repository](https://github.com/schlagmichdoch/PairDrop)
- [Documentation](https://github.com/schlagmichdoch/PairDrop/blob/master/docs/index.md)
