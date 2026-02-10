# Grocy

ERP beyond your fridge - a self-hosted groceries & household management solution for your home. Track your stock, create shopping lists, manage recipes, and reduce food waste.

**Official Sites:**
- [Grocy](https://grocy.info/) | [Docker Hub](https://hub.docker.com/r/linuxserver/grocy)

## Quick Start

```bash
docker compose -f grocy.yaml up -d
```

## Services

### Grocy
- **URL**: http://localhost:9283
- **Container**: `grocy`
- **Default Username**: `admin`
- **Default Password**: `admin`

## Initial Setup

1. Start the service with `docker compose -f grocy.yaml up -d`
2. Navigate to http://localhost:9283
3. Log in with default credentials (admin/admin)
4. **Important**: Change the admin password in settings
5. Configure your household settings
6. Start adding products and locations

## Volumes

- `grocy-config` - Application configuration and database

## Common Tasks

### Add Products

1. Go to "Master data" > "Products"
2. Click "Add"
3. Enter product details (name, barcode, location)
4. Set min/max stock levels
5. Save product

### Track Stock

1. Go to "Stock overview"
2. Click "Purchase" to add stock
3. Enter quantity and best before date
4. Click "Consume" to remove stock
5. View stock levels and expiring items

### Create Shopping List

1. Go to "Shopping list"
2. Add items manually or from recipes
3. Check off items as you shop
4. Items auto-add to stock when purchased

### Manage Recipes

1. Go to "Recipes"
2. Click "Add recipe"
3. Enter recipe name and ingredients
4. Link to products in your stock
5. Use recipe to consume stock

### Track Expiring Items

1. Go to "Stock overview"
2. View "Expiring soon" section
3. Get notifications for expiring products
4. Reduce food waste

### Backup Data

```bash
# Backup the config volume (includes SQLite database)
docker run --rm -v grocy-config:/data -v $(pwd):/backup alpine tar czf /backup/grocy-backup.tar.gz /data
```

### Restore Data

```bash
# Restore from backup
docker run --rm -v grocy-config:/data -v $(pwd):/backup alpine tar xzf /backup/grocy-backup.tar.gz -C /
```

## Configuration

### Environment Variables

- `PUID` - User ID for file permissions
- `PGID` - Group ID for file permissions
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "8080:80"  # Access on port 8080 instead
```

## Features

- **Stock Management**: Track all household items
- **Shopping Lists**: Auto-generated from stock levels
- **Recipe Management**: Link recipes to stock
- **Expiration Tracking**: Reduce food waste
- **Barcode Scanning**: Quick product lookup
- **Locations**: Organize by fridge, pantry, etc.
- **Quantity Units**: Flexible unit management
- **Meal Planning**: Plan meals and track consumption
- **Chores**: Track household tasks
- **Batteries**: Monitor battery levels
- **Equipment**: Manage household equipment
- **Multi-User**: Support for multiple users

## Security Notes

⚠️ **Important**: For production use:
- Change the default admin password immediately
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential

## Resources

- [Official Documentation](https://grocy.info/)
- [GitHub Repository](https://github.com/grocy/grocy)
- [Docker Hub](https://hub.docker.com/r/linuxserver/grocy)
- [Demo Instance](https://demo.grocy.info/)
