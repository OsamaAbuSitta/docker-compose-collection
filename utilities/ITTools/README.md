# IT Tools

A collection of handy online tools for developers with great UX. Includes encoders, decoders, formatters, generators, and more - all working offline.

**Official Sites:**
- [IT Tools](https://it-tools.tech/) | [Docker Hub](https://hub.docker.com/r/corentinth/it-tools)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Start the service
docker compose -f it-tools.yaml up -d
```

## Services

### IT Tools
- **URL**: http://localhost:8080
- **Container**: `it_tools`
- **Note**: No authentication required (all tools work client-side)

## Configuration

### Environment Variables (.env)

- `IT_TOOLS_PORT` - Web interface port (default: 8080)
- `TZ` - Timezone

## Features

All tools work offline in your browser:

**Encoders/Decoders**:
- Base64, URL, HTML entities
- JWT decoder
- Hash generators (MD5, SHA, etc.)

**Formatters**:
- JSON, XML, SQL, YAML
- Code beautifiers

**Generators**:
- UUID, Lorem Ipsum
- QR codes, Barcodes
- Passwords, Random strings

**Converters**:
- Case converters
- Color converters
- Unit converters

**Text Tools**:
- Diff checker
- Text statistics
- Regex tester

**And many more...**

## Security Notes

⚠️ All processing happens client-side in your browser. No data is sent to external servers.

## Resources

- [Official Website](https://it-tools.tech/)
- [GitHub Repository](https://github.com/CorentinTh/it-tools)
