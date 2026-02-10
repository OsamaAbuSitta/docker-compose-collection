# Ntfy

A simple HTTP-based pub-sub notification service. Send notifications to your phone or desktop via scripts from any computer, without having to sign up or pay any fees. Ntfy is perfect for sending notifications from scripts, cron jobs, or any application.

**Official Sites:**
- [Ntfy](https://ntfy.sh/) | [Docker Hub](https://hub.docker.com/r/binwiederhier/ntfy)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f ntfy.yaml up -d
```

## Services

### Ntfy Server
- **URL**: http://localhost:8090
- **Container**: `ntfy`
- **Note**: No authentication required by default (configurable)

## Initial Setup

1. Copy `.env.example` to `.env` and configure if needed
2. Start the service with `docker compose -f ntfy.yaml up -d`
3. Navigate to http://localhost:8090
4. Create topics and start receiving notifications!

## Configuration

### Environment Variables (.env)

- `NTFY_PORT` - Web interface port (default: 8090)
- `NTFY_BASE_URL` - Base URL for the service (change if using reverse proxy)
- `NTFY_AUTH_DEFAULT_ACCESS` - Default access level (read-write, read-only, write-only, deny-all)
- `NTFY_BEHIND_PROXY` - Set to true if behind a reverse proxy
- `NTFY_ENABLE_SIGNUP` - Allow user registration (true/false)
- `NTFY_ENABLE_LOGIN` - Enable user login (true/false)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Authentication

By default, Ntfy allows anonymous access. To enable authentication:

1. Set `NTFY_AUTH_DEFAULT_ACCESS=deny-all` in `.env`
2. Create users via CLI:

```bash
# Create a user
docker exec -it ntfy ntfy user add myuser

# Grant access to a topic
docker exec -it ntfy ntfy access myuser mytopic rw
```

## Sending Notifications

### Using curl

```bash
# Simple notification
curl -d "Hello World" http://localhost:8090/mytopic

# With title
curl -H "Title: Backup Complete" -d "All files backed up successfully" http://localhost:8090/backups

# With priority (1=min, 5=max)
curl -H "Priority: 5" -d "Critical alert!" http://localhost:8090/alerts

# With tags/emojis
curl -H "Tags: warning,skull" -d "Disk space low" http://localhost:8090/server-alerts

# With actions (buttons)
curl -H "Actions: view, Open dashboard, https://example.com" -d "Check the dashboard" http://localhost:8090/monitoring
```

### Using Python

```python
import requests

# Simple notification
requests.post("http://localhost:8090/mytopic", 
    data="Hello from Python".encode('utf-8'))

# With headers
requests.post("http://localhost:8090/mytopic",
    data="Backup complete".encode('utf-8'),
    headers={
        "Title": "Backup Status",
        "Priority": "3",
        "Tags": "white_check_mark"
    })
```

### Using JavaScript

```javascript
// Simple notification
fetch('http://localhost:8090/mytopic', {
    method: 'POST',
    body: 'Hello from JavaScript'
});

// With headers
fetch('http://localhost:8090/mytopic', {
    method: 'POST',
    body: 'Deployment complete',
    headers: {
        'Title': 'Deployment Status',
        'Priority': '4',
        'Tags': 'rocket'
    }
});
```

### Using Shell Script

```bash
#!/bin/bash
# Send notification on script completion
./my-script.sh && \
  curl -H "Title: Script Complete" \
       -d "The script finished successfully" \
       http://localhost:8090/scripts
```

## Receiving Notifications

### Web Interface

1. Navigate to http://localhost:8090
2. Subscribe to a topic by entering the topic name
3. Receive notifications in real-time

### Mobile Apps

1. Download the Ntfy app (Android/iOS)
2. Add your server: http://your-server:8090
3. Subscribe to topics
4. Receive push notifications

### Command Line

```bash
# Subscribe to a topic
ntfy subscribe mytopic

# Subscribe with custom server
ntfy subscribe --from-config http://localhost:8090/mytopic
```

### Using WebSocket

```javascript
const ws = new WebSocket('ws://localhost:8090/mytopic/ws');
ws.onmessage = (event) => {
    const notification = JSON.parse(event.data);
    console.log(notification.message);
};
```

## Volumes

- `ntfy-cache` - Message cache and attachments
- `ntfy-data` - User database and authentication data

## Common Tasks

### Create a User

```bash
docker exec -it ntfy ntfy user add username
```

### Change User Password

```bash
docker exec -it ntfy ntfy user change-pass username
```

### Grant Topic Access

```bash
# Grant read-write access
docker exec -it ntfy ntfy access username mytopic rw

# Grant read-only access
docker exec -it ntfy ntfy access username mytopic ro

# Grant write-only access
docker exec -it ntfy ntfy access username mytopic wo
```

### List Users

```bash
docker exec -it ntfy ntfy user list
```

### Remove User

```bash
docker exec -it ntfy ntfy user remove username
```

### Send Notification with Attachment

```bash
# Upload and attach a file
curl -T myfile.jpg http://localhost:8090/mytopic

# With message
curl -H "Message: Check this file" -T myfile.jpg http://localhost:8090/mytopic
```

### Schedule Delayed Notification

```bash
# Send in 30 minutes
curl -H "Delay: 30m" -d "Meeting reminder" http://localhost:8090/reminders

# Send at specific time
curl -H "At: 2024-12-31T23:59:00" -d "Happy New Year!" http://localhost:8090/celebrations
```

### Backup Configuration

```bash
# Backup user database
docker run --rm -v ntfy-data:/data -v $(pwd):/backup alpine tar czf /backup/ntfy-data.tar.gz -C /data .
```

### Restore Configuration

```bash
# Restore user database
docker run --rm -v ntfy-data:/data -v $(pwd):/backup alpine tar xzf /backup/ntfy-data.tar.gz -C /data
```

## Integration Examples

### Cron Job Notifications

```bash
# Add to crontab
0 2 * * * /path/to/backup.sh && curl -d "Backup completed" http://localhost:8090/backups || curl -H "Priority: 5" -d "Backup failed!" http://localhost:8090/backups
```

### Docker Container Monitoring

```bash
# Monitor container status
docker events --filter 'event=die' --format '{{.Actor.Attributes.name}}' | \
  while read container; do
    curl -H "Title: Container Died" -d "$container stopped unexpectedly" http://localhost:8090/docker-alerts
  done
```

### Git Hook Notifications

```bash
# In .git/hooks/post-commit
#!/bin/bash
COMMIT_MSG=$(git log -1 --pretty=%B)
curl -H "Title: New Commit" -d "$COMMIT_MSG" http://localhost:8090/git-updates
```

### System Monitoring

```bash
# Disk space alert
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ $USAGE -gt 80 ]; then
  curl -H "Priority: 4" -H "Tags: warning" \
       -d "Disk usage is at ${USAGE}%" \
       http://localhost:8090/system-alerts
fi
```

## Features

- **Simple HTTP API**: Send notifications with curl or any HTTP client
- **No Signup Required**: Use without creating an account (configurable)
- **Web Interface**: Subscribe and receive notifications in the browser
- **Mobile Apps**: Native Android and iOS apps with push notifications
- **Attachments**: Send files with notifications
- **Delayed Delivery**: Schedule notifications for later
- **Priority Levels**: Set notification importance (1-5)
- **Tags/Emojis**: Add visual indicators to notifications
- **Actions**: Add clickable buttons to notifications
- **Authentication**: Optional user authentication and access control
- **Self-Hosted**: Full control over your notification infrastructure
- **Open Source**: Free and open source software

## Troubleshooting

### Cannot Access Ntfy

- **Symptoms**: Browser shows "connection refused"
- **Solution**: 
  - Check container is running: `docker ps | grep ntfy`
  - Check logs: `docker logs ntfy`
  - Verify port is not in use by another service

### Notifications Not Received

- **Symptoms**: Messages sent but not appearing
- **Solution**: 
  - Verify topic name matches between sender and receiver
  - Check if authentication is enabled and credentials are correct
  - Check browser console for WebSocket errors

### Authentication Issues

- **Symptoms**: Cannot create users or access topics
- **Solution**: 
  - Ensure container has write access to volumes
  - Check user database exists: `docker exec ntfy ls -la /var/lib/ntfy/`
  - Verify NTFY_AUTH_FILE path is correct

### Mobile App Not Connecting

- **Symptoms**: Mobile app cannot connect to server
- **Solution**: 
  - Ensure server is accessible from mobile device network
  - Use IP address instead of localhost
  - Check firewall rules allow incoming connections
  - For HTTPS, ensure valid SSL certificate

### Attachments Not Working

- **Symptoms**: Cannot upload or download attachments
- **Solution**: 
  - Check NTFY_ATTACHMENT_CACHE_DIR is writable
  - Verify volume mount is correct
  - Check available disk space

## Security Notes

⚠️ **Important**: The default configuration allows anonymous access. For production use:
- Enable authentication (set NTFY_AUTH_DEFAULT_ACCESS=deny-all)
- Create user accounts with strong passwords
- Use HTTPS with a reverse proxy (nginx, Caddy)
- Restrict access with firewall rules
- Regular backups are essential
- Consider rate limiting for public instances
- Review and configure access control per topic

## Resources

- [Official Documentation](https://docs.ntfy.sh/)
- [GitHub Repository](https://github.com/binwiederhier/ntfy)
- [Docker Hub](https://hub.docker.com/r/binwiederhier/ntfy)
- [Mobile Apps](https://ntfy.sh/docs/subscribe/phone/)
- [API Documentation](https://docs.ntfy.sh/publish/)
