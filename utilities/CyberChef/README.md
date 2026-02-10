# CyberChef

The Cyber Swiss Army Knife - a web app for encryption, encoding, compression and data analysis. Chain operations together to create complex data transformations.

**Official Sites:**
- [CyberChef](https://gchq.github.io/CyberChef/) | [Docker Hub](https://hub.docker.com/r/mpepping/cyberchef)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Start the service
docker compose -f cyberchef.yaml up -d
```

## Services

### CyberChef
- **URL**: http://localhost:8000
- **Container**: `cyberchef`
- **Note**: No authentication required (all processing client-side)

## Configuration

### Environment Variables (.env)

- `CYBERCHEF_PORT` - Web interface port (default: 8000)
- `TZ` - Timezone

## Features

**Encryption/Decryption**:
- AES, DES, Triple DES, Blowfish
- RSA, RC4
- And many more algorithms

**Encoding/Decoding**:
- Base64, Base32, Hex
- URL encoding, HTML entities
- Unicode, ASCII

**Compression**:
- Gzip, Bzip2, Zip
- Tar, Raw inflate/deflate

**Hashing**:
- MD5, SHA-1, SHA-2, SHA-3
- HMAC, Bcrypt, Scrypt

**Data Formats**:
- JSON, XML, YAML
- CSV, SQL
- Protobuf

**Analysis**:
- Entropy analysis
- Frequency distribution
- File type detection

**And 300+ operations...**

## Use Cases

- Decode encoded data
- Decrypt encrypted files
- Analyze unknown data
- Convert between formats
- Chain multiple operations
- Forensics and analysis

## Security Notes

⚠️ All processing happens client-side in your browser. No data is sent to external servers.

## Resources

- [Official Website](https://gchq.github.io/CyberChef/)
- [GitHub Repository](https://github.com/gchq/CyberChef)
