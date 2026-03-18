# Changedetection.io

A self-hosted web page change detection and notification service. Monitor websites for changes and get notified via email, Discord, Slack, and many other platforms.

**Official Sites:**
- [Changedetection.io](https://changedetection.io/) | [Docker Hub](https://ghcr.io/dgtlmoon/changedetection.io)

## Quick Start

```bash
docker compose -f changedetection.yaml up -d
```

## Services

### Changedetection.io
- **URL**: http://localhost:5000
- **Container**: `changedetection`
- **Note**: No authentication by default (configure in settings)

### Playwright Chrome Browser
- **Container**: `changedetection_browser`
- **Purpose**: Renders JavaScript-heavy websites

## Initial Setup

1. Start the services with `docker compose -f changedetection.yaml up -d`
2. Navigate to http://localhost:5000
3. Add your first website to monitor
4. Configure notification settings
5. Set check frequency and filters

## Volumes

- `changedetection-data` - Monitored URLs, snapshots, and configuration

## Common Tasks

### Add a Website to Monitor

1. Click "Add new" on the main page
2. Enter the URL to monitor
3. Configure check frequency
4. Set up filters (CSS selectors, text filters)
5. Click "Watch"

### Configure Notifications

```bash
# In the web UI:
# 1. Go to Settings
# 2. Navigate to Notifications
# 3. Add notification endpoints:
#    - Email (SMTP)
#    - Discord webhook
#    - Slack webhook
#    - Telegram
#    - And many more
```

### Set Up Filters

Use CSS selectors to monitor specific parts of a page:
```css
/* Monitor only the price element */
.product-price

/* Monitor article content */
article.content

/* Exclude elements */
:not(.advertisement)
```

### View Change History

1. Click on a monitored URL
2. View the "Diff" tab to see changes
3. Browse previous snapshots
4. Export changes as needed

### Backup Monitoring Data

```bash
# Backup the data volume
docker run --rm -v changedetection-data:/data -v $(pwd):/backup alpine tar czf /backup/changedetection-backup.tar.gz /data
```

### Restore Monitoring Data

```bash
# Restore from backup
docker run --rm -v changedetection-data:/data -v $(pwd):/backup alpine tar xzf /backup/changedetection-backup.tar.gz -C /
```

## Configuration

### Environment Variables

- `BASE_URL` - The URL where Changedetection is accessible
- `PLAYWRIGHT_DRIVER_URL` - Browser service URL for JavaScript rendering

### Enable Authentication

1. Go to Settings in the web UI
2. Navigate to Security
3. Set a password
4. Optionally enable two-factor authentication

### Custom Check Intervals

Configure per-watch or globally:
- Minimum: Every 5 minutes
- Maximum: Custom intervals (hours, days)
- Recommended: 1-6 hours for most sites

### Notification Endpoints

Supported notification services:
- Email (SMTP)
- Discord
- Slack
- Telegram
- Pushover
- Gotify
- Apprise (supports 80+ services)
- Custom webhooks

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:5000
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### JavaScript Sites Not Rendering

- **Symptoms**: Changes not detected on dynamic websites
- **Solution**: Verify the playwright-chrome container is running. Check PLAYWRIGHT_DRIVER_URL is correct.

### Notifications Not Sending

- **Symptoms**: No notifications received
- **Solution**: Test notification settings in the UI. Check SMTP/webhook credentials. Review container logs.

### High CPU Usage

- **Symptoms**: System slow when checking many sites
- **Solution**: Reduce check frequency. Limit concurrent checks. Use filters to reduce page size.

## Features

- **Visual Selector**: Point-and-click element selection
- **Text Filters**: Monitor specific text patterns
- **JavaScript Rendering**: Full browser support for dynamic sites
- **Change Highlighting**: Visual diff of changes
- **Multiple Notifications**: 80+ notification services via Apprise
- **Proxy Support**: Route checks through proxies
- **API Access**: RESTful API for automation
- **Import/Export**: Backup and share watch lists
- **Custom Headers**: Add authentication headers
- **Ignore Patterns**: Filter out noise

## Use Cases

- **Price Monitoring**: Track product prices for deals
- **Stock Alerts**: Monitor product availability
- **News Tracking**: Get notified of new articles
- **Job Listings**: Watch for new job postings
- **Government Sites**: Monitor policy changes
- **Competitor Tracking**: Watch competitor websites
- **API Monitoring**: Track API response changes

## Security Notes

⚠️ **Important**: For production/remote access:
- Enable password protection in settings
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Be mindful of rate limits on monitored sites
- Use proxies to avoid IP bans

## Resources

- [Official Documentation](https://github.com/dgtlmoon/changedetection.io/wiki)
- [GitHub Repository](https://github.com/dgtlmoon/changedetection.io)
- [Docker Hub](https://ghcr.io/dgtlmoon/changedetection.io)
