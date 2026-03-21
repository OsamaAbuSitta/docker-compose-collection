# Dovecot IMAP/POP3 Server

A secure IMAP and POP3 mailbox server. Pairs with Postfix or Exim for a complete mail stack.

**Official Sites:**
- [Dovecot](https://www.dovecot.org/) | [Docker Hub](https://hub.docker.com/r/dovecot/dovecot)

## Quick Start

```bash
cp .env.example .env
# Edit .env - set MAIL_DOMAIN
docker compose -f dovecot.yaml up -d
```

## Access
- **IMAP**: localhost:143
- **IMAPS**: localhost:993
- **POP3**: localhost:110
- **POP3S**: localhost:995

## Configuration
- `IMAP_PORT` - IMAP port (default: 143)
- `IMAPS_PORT` - IMAP over TLS port (default: 993)
- `POP3_PORT` - POP3 port (default: 110)
- `POP3S_PORT` - POP3 over TLS port (default: 995)
- `MAIL_DOMAIN` - Mail domain

## Features
- IMAP and POP3 support
- TLS/SSL encryption
- Virtual users
- Sieve mail filtering
- Full-text search

## Resources
- [Dovecot Documentation](https://doc.dovecot.org/)
