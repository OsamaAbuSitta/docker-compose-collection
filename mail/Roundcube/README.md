# Roundcube Webmail

A browser-based IMAP email client with a rich UI. Connects to Dovecot/Cyrus for mailbox access and Postfix/Exim for sending.

**Official Sites:**
- [Roundcube](https://roundcube.net/) | [Docker Hub](https://hub.docker.com/r/roundcube/roundcubemail)

## Quick Start

```bash
cp .env.example .env
# Edit .env - set IMAP_HOST and SMTP_HOST
docker compose -f roundcube.yaml up -d
```

## Access
- **Webmail**: http://localhost:8080

## Configuration
- `WEBMAIL_PORT` - Web UI port (default: 8080)
- `IMAP_HOST` - IMAP server hostname (default: dovecot)
- `IMAP_PORT` - IMAP port (default: 143)
- `SMTP_HOST` - SMTP server hostname (default: postfix)
- `SMTP_PORT` - SMTP port (default: 25)

## Features
- Rich webmail interface
- Address book with LDAP support
- Drag-and-drop attachments
- Spell checking
- Plugin ecosystem

## Resources
- [Roundcube Documentation](https://github.com/roundcube/roundcubemail/wiki)
