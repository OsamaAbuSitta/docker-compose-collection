# Dozzle

A simple, lightweight application that provides you with a web-based interface to monitor your Docker container logs live. Real-time log viewing with search and filtering.

**Official Sites:**
- [Dozzle](https://dozzle.dev/) | [Docker Hub](https://hub.docker.com/r/amir20/dozzle)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Start the service
docker compose -f dozzle.yaml up -d
```

## Services

### Dozzle
- **URL**: http://localhost:8080
- **Container**: `dozzle`
- **Note**: No authentication by default

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Optionally set DOZZLE_USERNAME and DOZZLE_PASSWORD for authentication
3. Start the service with `docker compose -f dozzle.yaml up -d`
4. Navigate to http://localhost:8080
5. View logs from all running containers

## Configuration

### Environment Variables (.env)

- `DOZZLE_PORT` - Web interface port (default: 8080)
- `TZ` - Timezone
- `DOZZLE_USERNAME` - Optional username for authentication
- `DOZZLE_PASSWORD` - Optional password for authentication
- `DOZZLE_FILTER` - Filter containers (e.g., status=running)
- `DOZZLE_REMOTE_HOST` - Connect to remote Docker hosts

## Features

- **Real-Time Logs**: Live log streaming
- **Multi-Container**: View logs from all containers
- **Search**: Search through logs
- **Filtering**: Filter by container, time, text
- **Dark Mode**: Toggle dark/light theme
- **Stats**: Container CPU and memory usage
- **Multi-Host**: Connect to multiple Docker hosts
- **No Database**: Stateless application
- **Lightweight**: Minimal resource usage
- **Mobile Friendly**: Responsive design

## Common Tasks

### View Container Logs

1. Open http://localhost:8080
2. Select container from sidebar
3. View real-time logs
4. Use search to find specific entries

### Search Logs

1. Click search icon
2. Enter search term
3. Use regex for advanced search
4. Filter by time range

### Monitor Multiple Containers

1. Click "Multi-host" icon
2. Select multiple containers
3. View logs side-by-side
4. Compare container output

### Connect Remote Docker Host

Add to `.env`:
```
DOZZLE_REMOTE_HOST=tcp://remote-docker:2375
```

## Security Notes

⚠️ **Important**: For production use:
- Enable authentication (DOZZLE_USERNAME/PASSWORD)
- Use HTTPS with reverse proxy
- Restrict Docker socket access
- Limit network access
- Be cautious with remote hosts

## Resources

- [Official Documentation](https://dozzle.dev/guide)
- [GitHub Repository](https://github.com/amir20/dozzle)
- [Docker Hub](https://hub.docker.com/r/amir20/dozzle)
