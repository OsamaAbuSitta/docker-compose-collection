# Mailcow

A full-stack mail server suite with a web-based admin UI. Bundles Postfix, Dovecot, Rspamd, ClamAV, SOGo webmail, and more.

**Official Sites:**
- [Mailcow](https://mailcow.email/) | [GitHub](https://github.com/mailcow/mailcow-dockerized)

## Quick Start

```bash
cp .env.example .env
# Edit .env - set HOSTNAME, DOMAIN, and passwords
docker compose -f mailcow.yaml up -d
```

> **Note:** For production use, consider cloning the official mailcow repo and using its `generate_config.sh` for full configuration.

## Access
- **Admin UI**: http://localhost:8080
- **SMTP**: localhost:25
- **IMAPS**: localhost:993

## Configuration
- `HOSTNAME` - Mail server FQDN
- `DOMAIN` - Primary mail domain
- `ADMIN_USER` / `ADMIN_PASS` - Admin credentials
- `HTTP_PORT` / `HTTPS_PORT` - Web UI ports

## Features
- Web-based admin panel
- SOGo webmail and groupware
- Postfix MTA + Dovecot IMAP
- Rspamd spam filtering with DKIM/DMARC/SPF
- ClamAV antivirus
- Let's Encrypt auto-TLS
- Per-domain and per-user management
- Quarantine management
- Logging and monitoring

## Resources
- [Mailcow Documentation](https://docs.mailcow.email/)
