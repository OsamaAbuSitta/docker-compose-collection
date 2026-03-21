# Exim SMTP Server

A lightweight and flexible SMTP mail transfer agent. Alternative to Postfix.

**Official Sites:**
- [Exim](https://www.exim.org/) | [Docker Hub](https://hub.docker.com/r/devture/exim-relay)

## Quick Start

```bash
cp .env.example .env
# Edit .env - set HOSTNAME and RELAY_DOMAINS
docker compose -f exim.yaml up -d
```

## Access
- **SMTP**: localhost:25
- **Submission**: localhost:587

## Configuration
- `SMTP_PORT` - SMTP port (default: 25)
- `SUBMISSION_PORT` - Submission port (default: 587)
- `HOSTNAME` - Mail server hostname
- `RELAY_DOMAINS` - Domains to relay mail for

## Features
- Full MTA functionality
- TLS support
- Flexible routing and filtering
- ACL-based access control
- Lightweight alternative to Postfix

## Resources
- [Exim Documentation](https://www.exim.org/docs.html)
