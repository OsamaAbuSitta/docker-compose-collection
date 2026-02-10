# Homepage

A modern, fully static, fast, secure fully proxied, highly customizable application dashboard with integrations for over 100 services and translations into multiple languages.

**Official Sites:**
- [Homepage](https://gethomepage.dev/) | [Docker Hub](https://ghcr.io/gethomepage/homepage)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Start the service
docker compose -f homepage.yaml up -d
```

## Services

### Homepage
- **URL**: http://localhost:3000
- **Container**: `homepage`
- **Note**: No authentication by default

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f homepage.yaml up -d`
3. Navigate to http://localhost:3000
4. Configure services by editing config files in the volume
5. Customize layout, widgets, and integrations

## Configuration

### Environment Variables (.env)

- `HOMEPAGE_PORT` - Web interface port (default: 3000)
- `PUID` - User ID for file permissions (default: 1000)
- `PGID` - Group ID for file permissions (default: 1000)
- `TZ` - Timezone

## Volumes

- `homepage-config` - Configuration files (services.yaml, widgets.yaml, etc.)
- Docker socket mounted for container integration

## Configuration Files

Homepage uses YAML files for configuration:

**services.yaml** - Define your services:
```yaml
- Group Name:
    - Service Name:
        href: http://localhost:8080
        description: Service description
        icon: service-icon.png
```

**widgets.yaml** - Configure widgets:
```yaml
- resources:
    cpu: true
    memory: true
    disk: /
```

**bookmarks.yaml** - Add bookmarks:
```yaml
- Developer:
    - GitHub:
        - href: https://github.com
```

## Features

- **Service Links**: Organize all your services
- **Widgets**: System stats, weather, calendar
- **Integrations**: 100+ service integrations
- **Docker Integration**: Auto-discover containers
- **Search**: Quick service search
- **Customizable**: Themes and layouts
- **Multi-Language**: 40+ languages
- **Fast**: Static site generation
- **Mobile Friendly**: Responsive design

## Supported Integrations

- **Media**: Plex, Jellyfin, Emby, Sonarr, Radarr
- **Download**: qBittorrent, Transmission, SABnzbd
- **Home Automation**: Home Assistant, Node-RED
- **Monitoring**: Prometheus, Grafana, Uptime Kuma
- **And 100+ more...**

## Security Notes

⚠️ **Important**: For production use:
- Add authentication via reverse proxy
- Restrict Docker socket access
- Use HTTPS with reverse proxy
- Limit network access

## Resources

- [Official Documentation](https://gethomepage.dev/en/installation/)
- [GitHub Repository](https://github.com/gethomepage/homepage)
- [Docker Hub](https://ghcr.io/gethomepage/homepage)
