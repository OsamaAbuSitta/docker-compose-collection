# Uptime Kuma

A fancy self-hosted monitoring tool with a beautiful and intuitive interface. Uptime Kuma provides uptime monitoring for HTTP(s), TCP, HTTP(s) Keyword, Ping, DNS Record, Push, Steam Game Server, and Docker containers. Features include status pages, notifications, and multi-language support.

**Official Sites:**
- [Uptime Kuma](https://uptime.kuma.pet/) | [Docker Hub](https://hub.docker.com/r/louislam/uptime-kuma)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start Uptime Kuma
docker compose -f uptime-kuma.yaml up -d
```

## Services

### Uptime Kuma
- **URL**: http://localhost:3001
- **Container**: `uptime_kuma`
- **Note**: Create your admin account on first visit

## Initial Setup

1. Copy `.env.example` to `.env` and configure settings
2. Start the service with `docker compose -f uptime-kuma.yaml up -d`
3. Wait for the service to initialize (check: `docker logs uptime_kuma`)
4. Navigate to http://localhost:3001
5. Create your admin account on first visit
6. Start adding monitors

## Monitor Setup

### Add HTTP(S) Monitor

1. Click "Add New Monitor"
2. Select "HTTP(s)" as monitor type
3. Enter friendly name (e.g., "My Website")
4. Enter URL to monitor (e.g., https://example.com)
5. Set heartbeat interval (default: 60 seconds)
6. Configure retry settings
7. Click "Save"

### Monitor Types

**HTTP(s):**
- Monitor website availability
- Check response time
- Verify HTTP status codes
- Check for specific keywords in response

**TCP Port:**
- Monitor TCP port availability
- Check connection time
- Useful for databases, mail servers, etc.

**Ping:**
- ICMP ping monitoring
- Check host reachability
- Monitor network latency

**DNS:**
- Monitor DNS record resolution
- Verify DNS propagation
- Check for DNS changes

**Docker Container:**
- Monitor Docker container status
- Requires Docker socket mount

**Push:**
- Receive heartbeats from applications
- Monitor cron jobs and scheduled tasks
- Get unique push URL for each monitor

**Steam Game Server:**
- Monitor Steam game server status
- Check player count

### Advanced Monitor Settings

**Accepted Status Codes:**
```
200-299  # Accept all 2xx codes
200,301,302  # Accept specific codes
```

**Keyword Matching:**
- Check if response contains specific text
- Useful for detecting error pages

**Certificate Expiry:**
- Automatically monitors SSL certificate expiration
- Sends alerts before expiry

**Retry Settings:**
- Number of retries before marking as down
- Retry interval

## Notification Configuration

### Add Notification Channel

1. Go to "Settings" → "Notifications"
2. Click "Setup Notification"
3. Select notification type
4. Configure settings
5. Test notification
6. Save

### Supported Notification Types

**Email (SMTP):**
```
SMTP Host: smtp.gmail.com
Port: 587
Security: TLS
Username: your-email@gmail.com
Password: your-app-password
From: your-email@gmail.com
To: recipient@example.com
```

**Discord:**
```
Webhook URL: https://discord.com/api/webhooks/...
```

**Slack:**
```
Webhook URL: https://hooks.slack.com/services/...
```

**Telegram:**
```
Bot Token: 123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11
Chat ID: @your_channel or user_id
```

**Webhook:**
```
URL: https://your-webhook-endpoint.com
Method: POST
Content Type: application/json
```

**Other Supported Services:**
- Microsoft Teams
- Rocket.chat
- Mattermost
- Pushover
- Pushbullet
- Gotify
- Apprise
- Signal
- And many more...

### Notification Groups

1. Create notification groups to send alerts to multiple channels
2. Assign groups to monitors
3. Manage all notifications from one place

## Status Page

### Create Public Status Page

1. Go to "Status Pages"
2. Click "New Status Page"
3. Enter page name and slug (URL path)
4. Select monitors to display
5. Customize appearance:
   - Theme (light/dark/auto)
   - Custom CSS
   - Logo and favicon
6. Configure settings:
   - Show tags
   - Show certificate info
   - Show powered by
7. Save and publish

### Access Status Page

```
http://localhost:3001/status/your-slug
```

### Embed Status Page

```html
<iframe src="http://localhost:3001/status/your-slug" 
        width="100%" height="600" frameborder="0"></iframe>
```

## Configuration

### Environment Variables (.env)

- `UPTIME_KUMA_PORT` - Web interface port (default: 3001)
- `TZ` - Timezone for logs and notifications (e.g., America/New_York, Europe/London)

### Custom Port

To change the port, update the `.env` file:
```bash
UPTIME_KUMA_PORT=8080
```

### Timezone Configuration

Set your timezone for accurate timestamps:
```bash
TZ=America/New_York
```

## Volumes

- `uptime-kuma-data` - Monitor configurations, history, and database

## Common Tasks

### Backup Data

```bash
# Stop the container
docker compose -f uptime-kuma.yaml down

# Backup the data volume
docker run --rm -v uptime-kuma-data:/data -v $(pwd):/backup alpine tar czf /backup/uptime-kuma-backup.tar.gz -C /data .

# Start the container
docker compose -f uptime-kuma.yaml up -d
```

### Restore Data

```bash
# Stop the container
docker compose -f uptime-kuma.yaml down

# Restore the data
docker run --rm -v uptime-kuma-data:/data -v $(pwd):/backup alpine sh -c "cd /data && tar xzf /backup/uptime-kuma-backup.tar.gz"

# Start the container
docker compose -f uptime-kuma.yaml up -d
```

### View Logs

```bash
docker logs uptime_kuma
```

### Update to Latest Version

```bash
docker compose -f uptime-kuma.yaml pull
docker compose -f uptime-kuma.yaml up -d
```

### Reset Admin Password

```bash
# Access the container
docker exec -it uptime_kuma sh

# Run the password reset command
npm run reset-password

# Follow the prompts to reset password
```

## Push Monitor Example

### Create Push Monitor

1. Add new monitor with type "Push"
2. Copy the push URL provided
3. Send heartbeats to the URL

### Send Heartbeat

**Using curl:**
```bash
curl https://your-uptime-kuma-url/api/push/xxxxx?status=up&msg=OK&ping=123
```

**Parameters:**
- `status` - up, down, or empty
- `msg` - Optional status message
- `ping` - Optional response time in ms

**In Cron Job:**
```bash
# Add to crontab
*/5 * * * * curl -s https://your-uptime-kuma-url/api/push/xxxxx?status=up > /dev/null
```

**In Application:**
```python
import requests

def send_heartbeat():
    url = "https://your-uptime-kuma-url/api/push/xxxxx"
    params = {"status": "up", "msg": "Job completed", "ping": 150}
    requests.get(url, params=params)
```

## Docker Container Monitoring

### Enable Docker Monitoring

To monitor Docker containers, mount the Docker socket:

```yaml
# Add to uptime-kuma service in compose file
volumes:
  - /var/run/docker.sock:/var/run/docker.sock:ro
```

Then add Docker Container monitors in the UI.

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Connection refused or timeout
- **Solution**: 
  1. Check container is running: `docker ps | grep uptime_kuma`
  2. Check logs: `docker logs uptime_kuma`
  3. Verify port is not in use: `netstat -an | grep 3001`

### Monitors Showing as Down

- **Symptoms**: All monitors marked as down
- **Solution**: 
  1. Check network connectivity from container
  2. Verify DNS resolution: `docker exec uptime_kuma nslookup google.com`
  3. Check firewall rules

### Notifications Not Sending

- **Symptoms**: No notifications received
- **Solution**: 
  1. Test notification in settings
  2. Check notification logs in UI
  3. Verify webhook URLs or SMTP settings
  4. Check spam folder for email notifications

### High CPU Usage

- **Symptoms**: Container using excessive CPU
- **Solution**: 
  1. Reduce monitor frequency (increase heartbeat interval)
  2. Reduce number of monitors
  3. Check for monitors with very short intervals

## Security Notes

⚠️ **Important**: Security best practices for production use:
- Use strong admin password
- Enable two-factor authentication (2FA) in settings
- Use HTTPS with a reverse proxy (nginx, Caddy, Traefik)
- Restrict access with firewall rules
- Keep Uptime Kuma updated
- Regular backups are essential
- Use authentication for status pages if needed
- Secure notification webhooks

## Features

- **Multiple Monitor Types**: HTTP(s), TCP, Ping, DNS, Docker, Push, and more
- **Beautiful UI**: Modern, responsive interface with dark mode
- **Status Pages**: Create public status pages for your services
- **Notifications**: 90+ notification services supported
- **Multi-language**: Available in 30+ languages
- **Certificate Monitoring**: Automatic SSL certificate expiry alerts
- **Uptime Calculation**: 24-hour, 30-day, and custom uptime statistics
- **Tags**: Organize monitors with tags
- **Maintenance Windows**: Schedule maintenance to prevent false alerts
- **API**: REST API for automation
- **Import/Export**: Backup and restore configurations

## Resources

- [Official Documentation](https://github.com/louislam/uptime-kuma/wiki)
- [GitHub Repository](https://github.com/louislam/uptime-kuma)
- [Docker Hub](https://hub.docker.com/r/louislam/uptime-kuma)
- [Community Forum](https://github.com/louislam/uptime-kuma/discussions)
