# Snipe-IT

A free open source IT asset/license management system. Snipe-IT helps you track who has which laptop, when it was purchased, which software licenses and accessories are available, and more.

**Official Sites:**
- [Snipe-IT](https://snipeitapp.com/) | [Docker Hub](https://hub.docker.com/r/snipe/snipe-it)

## Quick Start

```bash
docker compose -f snipe-it.yaml up -d
```

## Services

### Snipe-IT
- **URL**: http://localhost:8080
- **Container**: `snipeit`
- **Note**: Complete setup wizard on first visit

### MySQL Database
- **Port**: 3306 (internal)
- **Container**: `snipeit_db`
- **Database**: `snipeit`
- **Username**: `snipeit`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Start the services with `docker compose -f snipe-it.yaml up -d`
2. Wait for initialization (check logs: `docker logs snipeit`)
3. Navigate to http://localhost:8080
4. Complete the setup wizard:
   - Create admin account
   - Configure site settings
   - Set up company information
5. Start adding assets

## Volumes

- `snipeit-data` - Uploaded files, logs, and application data
- `snipeit-db-data` - MySQL database files

## Common Tasks

### Add an Asset

1. Go to "Assets" > "Create New"
2. Select asset model
3. Enter asset details:
   - Asset tag (unique identifier)
   - Serial number
   - Purchase date and cost
   - Supplier
   - Location
4. Upload photos
5. Save asset

### Check Out an Asset

1. Find the asset
2. Click "Check Out"
3. Select user or location
4. Set expected check-in date
5. Add notes
6. Confirm check-out

### Check In an Asset

1. Find the checked-out asset
2. Click "Check In"
3. Add notes about condition
4. Confirm check-in

### Manage Licenses

1. Go to "Licenses"
2. Click "Create New"
3. Enter license details:
   - Software name
   - Product key
   - Seats available
   - Purchase date
   - Expiration date
4. Assign licenses to users

### Track Accessories

1. Go to "Accessories"
2. Add accessories (keyboards, mice, cables, etc.)
3. Set quantity available
4. Check out to users

### Generate Reports

1. Go to "Reports"
2. Choose report type:
   - Asset report
   - License report
   - Accessory report
   - Activity report
   - Audit report
3. Export as CSV or PDF

### Import Assets

1. Go to "Assets" > "Import"
2. Download CSV template
3. Fill in asset data
4. Upload CSV file
5. Map columns
6. Import assets

### Backup Data

```bash
# Backup the database
docker exec snipeit_db mysqldump -u snipeit -pP@ss0rd123 snipeit > snipeit_backup.sql

# Backup uploaded files
docker run --rm -v snipeit-data:/data -v $(pwd):/backup alpine tar czf /backup/snipeit-data-backup.tar.gz /data
```

### Restore Data

```bash
# Restore database
cat snipeit_backup.sql | docker exec -i snipeit_db mysql -u snipeit -pP@ss0rd123 snipeit

# Restore uploaded files
docker run --rm -v snipeit-data:/data -v $(pwd):/backup alpine tar xzf /backup/snipeit-data-backup.tar.gz -C /
```

## Configuration

### Environment Variables

**Application Configuration**:
- `APP_KEY` - Application encryption key (base64 encoded, 32 characters)
- `APP_URL` - The URL where Snipe-IT is accessible
- `APP_TIMEZONE` - Timezone (e.g., America/New_York, Europe/London)
- `APP_LOCALE` - Language (en, es, fr, de, etc.)

**Database Configuration**:
- `MYSQL_PORT_3306_TCP_ADDR` - Database hostname
- `MYSQL_DATABASE` - Database name
- `MYSQL_USER` - Database username
- `MYSQL_PASSWORD` - Database password

**Email Configuration** (optional):
- `MAIL_DRIVER` - Mail driver (smtp)
- `MAIL_HOST` - SMTP server
- `MAIL_PORT` - SMTP port
- `MAIL_USERNAME` - SMTP username
- `MAIL_PASSWORD` - SMTP password
- `MAIL_FROM_ADDR` - From email address

### Generate APP_KEY

```bash
# Generate a secure app key
docker run --rm snipe/snipe-it php artisan key:generate --show
```

Replace `APP_KEY` in the compose file with the generated value (including "base64:" prefix).

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "9000:80"  # Access on port 9000 instead
```

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:8080
- **Solution**: Wait for initialization. Check logs with `docker logs snipeit`.

### Database Connection Failed

- **Symptoms**: Snipe-IT shows database errors
- **Solution**: Ensure the database container is running. Verify MYSQL_PORT_3306_TCP_ADDR matches the database container name.

### Setup Wizard Errors

- **Symptoms**: Setup wizard fails
- **Solution**: Ensure APP_KEY is properly set. Check database credentials. Review container logs.

### Email Notifications Not Sending

- **Symptoms**: Users don't receive email notifications
- **Solution**: Configure MAIL_* environment variables. Test SMTP settings in Snipe-IT admin panel.

## Features

- **Asset Management**: Track all IT assets
- **Check In/Out**: Assign assets to users
- **License Management**: Track software licenses
- **Accessories**: Manage peripherals and accessories
- **Consumables**: Track consumable items
- **Components**: Manage hardware components
- **Maintenance**: Schedule and track maintenance
- **Depreciation**: Calculate asset depreciation
- **Custom Fields**: Add custom asset fields
- **Locations**: Organize by physical location
- **Suppliers**: Track vendors and suppliers
- **Reports**: Comprehensive reporting
- **Audit Log**: Track all changes
- **API**: RESTful API for integrations
- **LDAP/AD**: Active Directory integration
- **Multi-Language**: Support for 60+ languages

## Use Cases

- **IT Asset Management**: Track computers, servers, phones
- **Software Licensing**: Manage software licenses
- **Equipment Tracking**: Monitor equipment location
- **Compliance**: Maintain audit trails
- **Budgeting**: Track asset costs and depreciation
- **Maintenance**: Schedule equipment maintenance
- **Procurement**: Track purchases and suppliers
- **Disposal**: Manage asset retirement
- **Reporting**: Generate compliance reports

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure APP_KEY using the command above
- Change all database passwords
- Configure email for notifications
- Use HTTPS with a reverse proxy
- Enable two-factor authentication
- Restrict access with firewall rules
- Regular backups are essential
- Keep Snipe-IT updated

## Resources

- [Official Documentation](https://snipe-it.readme.io/)
- [API Documentation](https://snipe-it.readme.io/reference)
- [GitHub Repository](https://github.com/snipe/snipe-it)
- [Docker Hub](https://hub.docker.com/r/snipe/snipe-it)
- [Community Forum](https://gitter.im/snipe/snipe-it)
