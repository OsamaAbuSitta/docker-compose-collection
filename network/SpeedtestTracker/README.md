# Speedtest Tracker

A self-hosted internet performance tracking application that runs speedtests and stores the results. Monitor your internet speed over time with beautiful charts and notifications.

**Official Sites:**
- [Speedtest Tracker](https://docs.speedtest-tracker.dev/) | [Docker Hub](https://ghcr.io/alexjustesen/speedtest-tracker)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f speedtest-tracker.yaml up -d
```

## Services

### Speedtest Tracker
- **URL**: http://localhost:8080
- **Container**: `speedtest_tracker`
- **Note**: Create account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `speedtest_db`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate APP_KEY: `docker run --rm ghcr.io/alexjustesen/speedtest-tracker php artisan key:generate --show`
3. Update APP_KEY in `.env`
4. Start services with `docker compose -f speedtest-tracker.yaml up -d`
5. Navigate to http://localhost:8080
6. Create your admin account
7. Configure speedtest schedule

## Configuration

### Environment Variables (.env)

**Application**:
- `SPEEDTEST_PORT` - Web interface port (default: 8080)
- `APP_KEY` - Application encryption key (required)
- `APP_URL` - The URL where app is accessible
- `TZ` - Timezone

**Database**:
- `DB_HOST` - Database hostname
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password

**Speedtest Settings**:
- `SPEEDTEST_SCHEDULE` - Cron schedule (default: */30 * * * *)
- `SPEEDTEST_SERVERS` - Comma-separated server IDs (optional)

## Volumes

- `speedtest-config` - Application configuration
- `speedtest-db-data` - PostgreSQL database

## Features

- **Automated Tests**: Schedule speedtests
- **Historical Data**: Track speed over time
- **Charts**: Visualize performance
- **Notifications**: Alert on slow speeds
- **Multiple Servers**: Test against specific servers
- **API**: REST API for integrations
- **Thresholds**: Set speed thresholds
- **Export**: Export data as CSV
- **Mobile Friendly**: Responsive design

## Common Tasks

### Schedule Speedtests

1. Go to Settings
2. Configure schedule (cron format)
3. Examples:
   - Every 30 minutes: `*/30 * * * *`
   - Every hour: `0 * * * *`
   - Every 6 hours: `0 */6 * * *`

### Set Thresholds

1. Go to Settings > Thresholds
2. Set minimum download speed
3. Set minimum upload speed
4. Configure notifications

### View Results

1. Dashboard shows latest results
2. Charts show historical trends
3. Filter by date range
4. Export data as CSV

## Security Notes

⚠️ **Important**: For production use:
- Generate secure APP_KEY
- Change database password
- Use HTTPS with reverse proxy
- Regular backups essential

## Resources

- [Official Documentation](https://docs.speedtest-tracker.dev/)
- [GitHub Repository](https://github.com/alexjustesen/speedtest-tracker)
