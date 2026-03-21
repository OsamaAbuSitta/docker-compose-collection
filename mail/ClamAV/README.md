# ClamAV Antivirus

Open-source antivirus engine for detecting malware in email attachments. Integrates with Rspamd or Amavis for mail scanning.

**Official Sites:**
- [ClamAV](https://www.clamav.net/) | [Docker Hub](https://hub.docker.com/r/clamav/clamav)

## Quick Start

```bash
cp .env.example .env
docker compose -f clamav.yaml up -d
```

## Access
- **Clamd**: localhost:3310

## Configuration
- `CLAMD_PORT` - ClamAV daemon port (default: 3310)

## Features
- Real-time virus scanning
- Automatic signature updates via freshclam
- Milter integration for mail scanning
- Supports multiple file formats
- Low resource footprint

## Resources
- [ClamAV Documentation](https://docs.clamav.net/)
