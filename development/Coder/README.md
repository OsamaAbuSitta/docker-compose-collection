# Coder

Self-hosted remote development environments. Create cloud development workspaces.

**Official Sites:**
- [Coder](https://coder.com/) | [Docker Hub](https://ghcr.io/coder/coder)

## Quick Start

```bash
cp .env.example .env
# Edit .env - change passwords
docker compose -f coder.yaml up -d
```

## Access
- **URL**: http://localhost:7080
- Create admin account on first visit

## Configuration
- `CODER_PORT` - Web port (default: 7080)
- `POSTGRES_PASSWORD` - Database password (change!)
- `ACCESS_URL` - Public URL

## Features
- Cloud development environments
- VS Code in browser
- Template-based workspaces
- Team collaboration
- Resource management

## Resources
- [Official Site](https://coder.com/)
- [Documentation](https://coder.com/docs)
