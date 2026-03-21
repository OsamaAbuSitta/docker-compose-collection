# Rspamd Spam Filtering

Advanced spam filtering system with DKIM signing/verification, DMARC, SPF checks, and a web UI. Integrates with Postfix/Exim via milter protocol.

**Official Sites:**
- [Rspamd](https://rspamd.com/) | [Docker Hub](https://hub.docker.com/r/rspamd/rspamd)

## Quick Start

```bash
cp .env.example .env
# Edit .env - set DKIM_DOMAIN
docker compose -f rspamd.yaml up -d
```

## Access
- **Web UI**: http://localhost:11334

## Configuration
- `RSPAMD_WEB_PORT` - Web interface port (default: 11334)
- `DKIM_SELECTOR` - DKIM selector (default: mail)
- `DKIM_DOMAIN` - Domain for DKIM signing

## Features
- Spam filtering with machine learning
- DKIM signing and verification
- DMARC policy enforcement
- SPF checking
- Greylisting
- Rate limiting
- Web management UI
- Redis-backed statistics

## Resources
- [Rspamd Documentation](https://rspamd.com/doc/)
