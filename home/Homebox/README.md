# Homebox

The inventory and organization system built for the home user. Track, organize, and manage your stuff with a simple and intuitive interface.

**Official Sites:**
- [Homebox](https://hay-kot.github.io/homebox/) | [Docker Hub](https://ghcr.io/hay-kot/homebox)

## Quick Start

```bash
docker compose -f homebox.yaml up -d
```

## Services

### Homebox
- **URL**: http://localhost:7745
- **Container**: `homebox`
- **Note**: Create account on first visit

## Initial Setup

1. Start the service with `docker compose -f homebox.yaml up -d`
2. Navigate to http://localhost:7745
3. Create your account
4. Set up locations and labels
5. Start adding items to your inventory

## Volumes

- `homebox-data` - Application data and SQLite database

## Common Tasks

### Add an Item

1. Click "Items" > "Create"
2. Enter item details:
   - Name and description
   - Location
   - Labels/tags
   - Purchase date and price
   - Warranty information
   - Serial number
3. Upload photos
4. Save item

### Organize with Locations

1. Go to "Locations"
2. Create locations (e.g., Garage, Kitchen, Office)
3. Create sub-locations (e.g., Garage > Shelf 1)
4. Assign items to locations
5. View items by location

### Use Labels

1. Go to "Labels"
2. Create labels (e.g., Electronics, Tools, Seasonal)
3. Assign multiple labels to items
4. Filter items by labels

### Track Warranties

1. Add warranty expiration date to items
2. View "Expiring Warranties" dashboard
3. Get reminders for expiring warranties
4. Store warranty documents

### Search Inventory

1. Use the search bar
2. Search by:
   - Item name
   - Description
   - Location
   - Labels
   - Serial number
3. Filter and sort results

### Generate Reports

1. Go to "Reports"
2. View inventory statistics:
   - Total items
   - Total value
   - Items by location
   - Items by label
3. Export reports

### Backup Data

```bash
# Backup the data volume (includes SQLite database)
docker run --rm -v homebox-data:/data -v $(pwd):/backup alpine tar czf /backup/homebox-backup.tar.gz /data
```

### Restore Data

```bash
# Restore from backup
docker run --rm -v homebox-data:/data -v $(pwd):/backup alpine tar xzf /backup/homebox-backup.tar.gz -C /
```

## Configuration

### Environment Variables

- `HBOX_LOG_LEVEL` - Logging level (info, debug, error)
- `HBOX_WEB_PORT` - Web server port
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "8080:7745"  # Access on port 8080 instead
```

## Features

- **Item Management**: Track all household items
- **Locations**: Organize by physical location
- **Labels**: Categorize with custom labels
- **Photos**: Attach multiple photos per item
- **Warranties**: Track warranty expiration
- **Purchase Info**: Record purchase date and price
- **Serial Numbers**: Store serial numbers
- **Attachments**: Add documents and receipts
- **Search**: Full-text search across all items
- **Reports**: Inventory statistics and summaries
- **QR Codes**: Generate QR codes for items
- **Multi-User**: Support for multiple users
- **Mobile Friendly**: Responsive design

## Use Cases

- **Home Inventory**: Track all household items
- **Insurance**: Document items for insurance claims
- **Moving**: Organize items when moving
- **Estate Planning**: Catalog valuable items
- **Tool Management**: Track tools and equipment
- **Electronics**: Manage devices and warranties
- **Collections**: Organize collectibles
- **Seasonal Items**: Track holiday decorations
- **Garage Organization**: Manage garage items
- **Office Supplies**: Track office equipment

## Security Notes

⚠️ **Important**: For production/remote access:
- Use a strong password for your account
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential
- Store sensitive data securely

## Resources

- [Official Documentation](https://hay-kot.github.io/homebox/)
- [GitHub Repository](https://github.com/hay-kot/homebox)
- [Docker Hub](https://ghcr.io/hay-kot/homebox)
