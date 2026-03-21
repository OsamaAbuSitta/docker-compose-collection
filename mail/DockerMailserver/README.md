# Docker Mailserver

A full-featured, production-ready mail server stack in a single container. Includes Postfix, Dovecot, OpenDKIM, OpenDMARC, SpamAssassin, ClamAV, and Fail2Ban.

**Official Sites:**
- [Docker Mailserver](https://docker-mailserver.github.io/docker-mailserver/) | [GitHub](https://github.com/docker-mailserver/docker-mailserver)

## Quick Start

```bash
cp .env.example .env
# Edit .env - set HOSTNAME and DOMAIN
docker compose -f docker-mailserver.yaml up -d

# Add a mail account
docker exec -it docker-mailserver setup email add user@example.com
```

## Access
- **SMTP**: localhost:25
- **Submission**: localhost:587
- **SMTPS**: localhost:465
- **IMAP**: localhost:143
- **IMAPS**: localhost:993

## Configuration
- `HOSTNAME` - Mail server FQDN
- `DOMAIN` - Mail domain
- `ENABLE_SPAMASSASSIN` - Enable spam filtering (default: 1)
- `ENABLE_CLAMAV` - Enable antivirus scanning (default: 1)
- `ENABLE_FAIL2BAN` - Enable brute-force protection (default: 1)
- `ENABLE_OPENDKIM` - Enable DKIM signing (default: 1)
- `ENABLE_OPENDMARC` - Enable DMARC verification (default: 1)

## Features
- Postfix MTA + Dovecot IMAP/POP3
- DKIM signing and verification
- DMARC policy enforcement
- SPF checking
- SpamAssassin spam filtering
- ClamAV antivirus
- Fail2Ban intrusion prevention
- Let's Encrypt TLS support
- User management CLI

## Resources
- [Docker Mailserver Docs](https://docker-mailserver.github.io/docker-mailserver/latest/)
