# Postfix Mail Server

A full-featured SMTP mail server using Postfix. Send and receive emails.

**Official Sites:**
- [Postfix](http://www.postfix.org/) | [Docker Hub](https://hub.docker.com/r/boky/postfix)

## Quick Start

```bash
cp .env.example .env
# Edit .env - set HOSTNAME and ALLOWED_DOMAINS
docker compose -f postfix-mail.yaml up -d
```

## Access
- **SMTP**: localhost:25
- **Submission**: localhost:587

## Configuration
- `SMTP_PORT` - SMTP port (default: 25)
- `SUBMISSION_PORT` - Submission port (default: 587)
- `HOSTNAME` - Mail server hostname
- `ALLOWED_DOMAINS` - Allowed sender domains

## Features
- Full SMTP server
- TLS support
- Domain restrictions
- Relay configuration

## Resources
- [Postfix Documentation](http://www.postfix.org/documentation.html)
