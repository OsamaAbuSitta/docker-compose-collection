# Portainer

Portainer is a lightweight management UI that allows you to easily manage your Docker environments.

## Quick Start

```bash
docker compose up -d
```

## Access

- **URL**: http://localhost:9000
- **Initial Password**: `P@ssw0rd@123`

## First Time Setup

1. Navigate to http://localhost:9000
2. Create an admin account on first visit
3. Choose "Docker" as the environment type
4. Connect to local Docker environment

## Features

- Container management (start, stop, restart, remove)
- Image management
- Volume management
- Network management
- Docker Compose stack deployment
- Container logs and stats
- User access control

## Volumes

- `portainer_data` - Stores Portainer configuration and data

## Security

⚠️ **Important**: Change the default password immediately after first login.

For production use:
- Use HTTPS with valid certificates
- Enable authentication
- Restrict network access
- Regular backups of portainer_data volume

## Resources

- [Portainer Documentation](https://docs.portainer.io/)
- [Video Tutorial](https://www.youtube.com/watch?v=iX0HbrfRyvc)
