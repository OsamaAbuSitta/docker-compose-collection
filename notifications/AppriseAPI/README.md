# Apprise API

A simple API wrapper for Apprise, allowing you to send notifications to 80+ notification services including Discord, Slack, Telegram, Email, and many more through a single unified API.

**Official Sites:**
- [Apprise](https://github.com/caronc/apprise) | [Docker Hub](https://hub.docker.com/r/caronc/apprise)

## Quick Start

```bash
docker compose -f apprise-api.yaml up -d
```

## Services

### Apprise API
- **URL**: http://localhost:8000
- **Container**: `apprise_api`
- **Note**: No authentication by default

## Initial Setup

1. Start the service with `docker compose -f apprise-api.yaml up -d`
2. Navigate to http://localhost:8000 for the web interface
3. Create notification configurations
4. Start sending notifications via API

## Volumes

- `apprise-config` - Stored notification configurations
- `apprise-attach` - Temporary storage for attachments

## Common Tasks

### Send a Simple Notification

```bash
# Send to Discord
curl -X POST http://localhost:8000/notify \
  -d "urls=discord://webhook_id/webhook_token" \
  -d "body=Hello from Apprise!"

# Send to Slack
curl -X POST http://localhost:8000/notify \
  -d "urls=slack://TokenA/TokenB/TokenC" \
  -d "body=Notification message"

# Send to Telegram
curl -X POST http://localhost:8000/notify \
  -d "urls=tgram://bot_token/chat_id" \
  -d "body=Test message"
```

### Send to Multiple Services

```bash
# Send to Discord and Slack simultaneously
curl -X POST http://localhost:8000/notify \
  -d "urls=discord://webhook_id/webhook_token,slack://TokenA/TokenB/TokenC" \
  -d "title=Alert" \
  -d "body=This goes to multiple services"
```

### Store Configuration

```bash
# Store a configuration with a key
curl -X POST http://localhost:8000/add/myconfig \
  -d "urls=discord://webhook_id/webhook_token,slack://TokenA/TokenB/TokenC"

# Send notification using stored config
curl -X POST http://localhost:8000/notify/myconfig \
  -d "body=Using stored configuration"
```

### Send with Attachments

```bash
# Send notification with image
curl -X POST http://localhost:8000/notify \
  -F "urls=discord://webhook_id/webhook_token" \
  -F "body=Check out this image" \
  -F "attach=@/path/to/image.png"
```

### Get Configuration

```bash
# Retrieve stored configuration
curl http://localhost:8000/get/myconfig

# List all configurations
curl http://localhost:8000/list
```

### Delete Configuration

```bash
# Delete a stored configuration
curl -X POST http://localhost:8000/del/myconfig
```

## Supported Services

Apprise supports 80+ notification services including:

**Messaging**:
- Discord, Slack, Microsoft Teams, Mattermost
- Telegram, WhatsApp, Signal
- Matrix, Rocket.Chat, Zulip

**Email**:
- SMTP, Gmail, Outlook, SendGrid
- Mailgun, Amazon SES, Postmark

**Push Notifications**:
- Pushover, Pushbullet, Pushy
- Gotify, Ntfy, Prowl

**SMS**:
- Twilio, Nexmo, AWS SNS
- Clickatell, MessageBird

**Social Media**:
- Twitter, Mastodon

**Monitoring**:
- PagerDuty, Opsgenie, VictorOps
- Datadog, New Relic

**And many more...**

## URL Format Examples

### Discord
```
discord://webhook_id/webhook_token
```

### Slack
```
slack://TokenA/TokenB/TokenC
slack://TokenA/TokenB/TokenC/#channel
```

### Telegram
```
tgram://bot_token/chat_id
```

### Email (SMTP)
```
mailto://user:password@smtp.example.com?from=sender@example.com&to=recipient@example.com
```

### Gotify
```
gotify://hostname/token
```

### Pushover
```
pover://user_key@token
```

### Microsoft Teams
```
msteams://TokenA/TokenB/TokenC
```

## API Endpoints

### POST /notify
Send a notification immediately
- `urls` - Notification service URLs (comma-separated)
- `title` - Notification title (optional)
- `body` - Notification message
- `type` - Message type: info, success, warning, failure (optional)

### POST /notify/{key}
Send notification using stored configuration
- `body` - Notification message
- `title` - Notification title (optional)

### POST /add/{key}
Store a notification configuration
- `urls` - Notification service URLs

### GET /get/{key}
Retrieve stored configuration

### POST /del/{key}
Delete stored configuration

### GET /list
List all stored configurations

## Configuration

### Environment Variables

- `TZ` - Timezone (e.g., America/New_York, Europe/London)
- `APPRISE_CONFIG_DIR` - Configuration directory (default: /config)
- `APPRISE_ATTACH_DIR` - Attachments directory (default: /attach)

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "9000:8000"  # Access on port 9000 instead
```

### Enable Authentication

For production use, configure a reverse proxy with authentication or use API keys.

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:8000
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### Notifications Not Sending

- **Symptoms**: API returns success but no notification received
- **Solution**: Verify service URLs are correct. Check service credentials. Review container logs with `docker logs apprise_api`.

### Invalid URL Format

- **Symptoms**: API returns error about invalid URL
- **Solution**: Check the URL format for your service. Refer to [Apprise documentation](https://github.com/caronc/apprise/wiki) for correct formats.

### Attachment Upload Fails

- **Symptoms**: Cannot send attachments
- **Solution**: Verify the attach volume is mounted. Check file size limits. Ensure the service supports attachments.

## Integration Examples

### Python

```python
import requests

def send_notification(title, message, urls):
    response = requests.post(
        "http://localhost:8000/notify",
        data={
            "urls": urls,
            "title": title,
            "body": message
        }
    )
    return response.json()

# Usage
send_notification(
    "Alert",
    "Something happened!",
    "discord://webhook_id/webhook_token"
)
```

### Bash Script

```bash
#!/bin/bash
APPRISE_URL="http://localhost:8000/notify"
SERVICES="discord://webhook_id/webhook_token,slack://TokenA/TokenB/TokenC"

send_notification() {
    curl -X POST "${APPRISE_URL}" \
        -d "urls=${SERVICES}" \
        -d "title=$1" \
        -d "body=$2"
}

# Usage
send_notification "Backup Complete" "Database backup finished successfully"
```

### Node.js

```javascript
const axios = require('axios');

async function sendNotification(title, message, urls) {
    const response = await axios.post('http://localhost:8000/notify', {
        urls: urls,
        title: title,
        body: message
    });
    return response.data;
}

// Usage
sendNotification(
    'Alert',
    'Something happened!',
    'discord://webhook_id/webhook_token'
);
```

## Features

- **80+ Services**: Support for most popular notification platforms
- **Unified API**: Single API for all services
- **Stored Configs**: Save and reuse notification configurations
- **Multiple Recipients**: Send to multiple services simultaneously
- **Attachments**: Send images and files (service-dependent)
- **Message Types**: Info, success, warning, failure
- **Web Interface**: Simple web UI for testing
- **No Authentication**: Simple setup (add auth via reverse proxy)
- **Lightweight**: Minimal resource usage

## Security Notes

⚠️ **Important**: The default configuration has no authentication. For production use:
- Use a reverse proxy with authentication (nginx, Caddy, Traefik)
- Restrict access with firewall rules
- Use HTTPS for encrypted communication
- Store sensitive URLs in configurations, not in API calls
- Regularly rotate service tokens and webhooks
- Monitor API usage for abuse

## Resources

- [Apprise Documentation](https://github.com/caronc/apprise/wiki)
- [Supported Services](https://github.com/caronc/apprise/wiki#supported-notifications)
- [GitHub Repository](https://github.com/caronc/apprise-api)
- [Docker Hub](https://hub.docker.com/r/caronc/apprise)
