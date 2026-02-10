# Gotify

A simple server for sending and receiving messages in real-time. Gotify is a self-hosted push notification service with Android app, CLI, and web interface.

**Official Sites:**
- [Gotify](https://gotify.net/) | [Docker Hub](https://hub.docker.com/r/gotify/server)

## Quick Start

```bash
docker compose -f gotify.yaml up -d
```

## Services

### Gotify Server
- **URL**: http://localhost:8080
- **Container**: `gotify`
- **Default Username**: `admin`
- **Default Password**: `P@ss0rd123`

## Initial Setup

1. Start the service with `docker compose -f gotify.yaml up -d`
2. Navigate to http://localhost:8080
3. Log in with default credentials
4. **Important**: Change the admin password in settings
5. Create applications and clients
6. Start sending notifications

## Volumes

- `gotify-data` - Application data, messages, and configuration

## Common Tasks

### Create an Application

Applications are used to send messages:

1. Log in to the web interface
2. Click "Apps" in the sidebar
3. Click "Create Application"
4. Enter application name and description
5. Copy the application token
6. Use the token to send messages via API

### Send a Notification

```bash
# Using curl
curl -X POST "http://localhost:8080/message?token=YOUR_APP_TOKEN" \
  -F "title=My Title" \
  -F "message=This is a test message" \
  -F "priority=5"

# Using wget
wget --post-data="title=My Title&message=Test&priority=5" \
  "http://localhost:8080/message?token=YOUR_APP_TOKEN"
```

### Create a Client

Clients are used to receive messages:

1. Click "Clients" in the sidebar
2. Click "Create Client"
3. Enter client name
4. Copy the client token
5. Use the token in mobile app or CLI

### Configure Mobile App

1. Download Gotify Android app from F-Droid or Play Store
2. Open the app
3. Enter server URL: http://your-server:8080
4. Enter client token
5. Start receiving push notifications

### Backup Messages

```bash
# Backup the data volume
docker run --rm -v gotify-data:/data -v $(pwd):/backup alpine tar czf /backup/gotify-backup.tar.gz /data
```

### Restore Messages

```bash
# Restore from backup
docker run --rm -v gotify-data:/data -v $(pwd):/backup alpine tar xzf /backup/gotify-backup.tar.gz -C /
```

## API Usage

### Send Message with Priority

```bash
# Priority levels: 0 (lowest) to 10 (highest)
curl -X POST "http://localhost:8080/message?token=YOUR_APP_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Important Alert",
    "message": "This is a high priority message",
    "priority": 8,
    "extras": {
      "client::display": {
        "contentType": "text/markdown"
      }
    }
  }'
```

### Send Message with Markdown

```bash
curl -X POST "http://localhost:8080/message?token=YOUR_APP_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Formatted Message",
    "message": "**Bold** and *italic* text\n\n- List item 1\n- List item 2",
    "extras": {
      "client::display": {
        "contentType": "text/markdown"
      }
    }
  }'
```

### Get Messages

```bash
# Get all messages
curl -X GET "http://localhost:8080/message?token=YOUR_CLIENT_TOKEN"

# Get messages with limit
curl -X GET "http://localhost:8080/message?limit=10&token=YOUR_CLIENT_TOKEN"
```

### Delete Messages

```bash
# Delete specific message
curl -X DELETE "http://localhost:8080/message/MESSAGE_ID?token=YOUR_CLIENT_TOKEN"

# Delete all messages
curl -X DELETE "http://localhost:8080/message?token=YOUR_CLIENT_TOKEN"
```

## Configuration

### Environment Variables

- `GOTIFY_DEFAULTUSER_NAME` - Default admin username
- `GOTIFY_DEFAULTUSER_PASS` - Default admin password
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "9000:80"  # Access on port 9000 instead
```

### Enable HTTPS

For production use, configure a reverse proxy (nginx, Caddy, Traefik) with SSL certificates.

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:8080
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### Mobile App Cannot Connect

- **Symptoms**: Android app shows connection error
- **Solution**: Verify server URL is accessible from mobile device. Check firewall rules. Use IP address instead of localhost.

### Messages Not Sending

- **Symptoms**: API returns error when sending messages
- **Solution**: Verify application token is correct. Check API endpoint URL. Review server logs.

### Push Notifications Not Working

- **Symptoms**: Messages arrive but no push notification
- **Solution**: Check Android battery optimization settings. Ensure app has notification permissions. Verify priority level is set.

## Integration Examples

### Home Assistant

```yaml
notify:
  - name: gotify
    platform: rest
    resource: http://localhost:8080/message
    method: POST
    data:
      token: YOUR_APP_TOKEN
    title_param_name: title
    message_param_name: message
```

### Bash Script

```bash
#!/bin/bash
GOTIFY_URL="http://localhost:8080/message"
GOTIFY_TOKEN="YOUR_APP_TOKEN"

send_notification() {
    curl -X POST "${GOTIFY_URL}?token=${GOTIFY_TOKEN}" \
        -F "title=$1" \
        -F "message=$2" \
        -F "priority=${3:-5}"
}

# Usage
send_notification "Backup Complete" "Database backup finished successfully" 7
```

### Python

```python
import requests

def send_gotify(title, message, priority=5):
    url = "http://localhost:8080/message"
    params = {"token": "YOUR_APP_TOKEN"}
    data = {
        "title": title,
        "message": message,
        "priority": priority
    }
    response = requests.post(url, params=params, json=data)
    return response.json()

# Usage
send_gotify("Test", "Hello from Python!", 5)
```

## Features

- **Real-Time**: WebSocket-based push notifications
- **Multi-User**: Support for multiple users and applications
- **Priority Levels**: 11 priority levels (0-10)
- **Markdown**: Rich text formatting support
- **Android App**: Native Android application
- **CLI**: Command-line interface for sending messages
- **REST API**: Simple HTTP API
- **Web Interface**: Manage apps and view messages
- **Message History**: Store and retrieve past messages
- **Plugins**: Extend functionality with plugins

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the default admin password immediately
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Use strong application and client tokens
- Regularly rotate tokens
- Enable authentication on reverse proxy

## Resources

- [Official Documentation](https://gotify.net/docs/)
- [API Documentation](https://gotify.net/api-docs)
- [GitHub Repository](https://github.com/gotify/server)
- [Docker Hub](https://hub.docker.com/r/gotify/server)
- [Android App](https://github.com/gotify/android)
