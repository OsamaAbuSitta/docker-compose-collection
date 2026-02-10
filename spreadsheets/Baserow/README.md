# Baserow

An open-source no-code database tool and Airtable alternative. Create your own online database without technical experience with an intuitive spreadsheet-like interface.

**Official Sites:**
- [Baserow](https://baserow.io/) | [Docker Hub](https://hub.docker.com/r/baserow/baserow)

## Quick Start

```bash
docker compose -f baserow.yaml up -d
```

## Services

### Baserow
- **URL**: http://localhost:8000
- **HTTPS URL**: https://localhost:8443
- **Container**: `baserow`
- **Note**: Create account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `baserow_db`
- **Database**: `baserow`
- **Username**: `baserow`
- **Password**: `P@ss0rd123`

### Redis Cache
- **Port**: 6379 (internal)
- **Container**: `baserow_redis`

## Initial Setup

1. Start the services with `docker compose -f baserow.yaml up -d`
2. Wait for initialization (check logs: `docker logs baserow`)
3. Navigate to http://localhost:8000
4. Create your admin account
5. Create your first database and table

## Volumes

- `baserow-data` - Application data, files, and user uploads
- `baserow-db-data` - PostgreSQL database files

## Common Tasks

### Create a Database

1. Click "Create new" on the dashboard
2. Select "Database"
3. Name your database
4. Start adding tables

### Create a Table

1. Open a database
2. Click "Add table"
3. Name your table
4. Add fields with different types:
   - Text, Long text, Number
   - Rating, Boolean, Date
   - File, Single select, Multiple select
   - Link to table, Formula, Lookup
   - And many more...

### Import Data

Supported import formats:
- CSV files
- XML files
- JSON files
- Paste from clipboard

To import:
1. Click table menu (three dots)
2. Select "Import data"
3. Choose file or paste data
4. Map columns
5. Import

### Create Views

1. Click "Create view" in a table
2. Choose view type:
   - Grid: Spreadsheet view
   - Gallery: Card-based view
   - Form: Data collection form
   - Kanban: Board view
3. Configure filters, sorting, and grouping

### Build Forms

1. Create a Form view
2. Customize form fields
3. Configure submit button and messages
4. Share the form URL
5. Collect responses in the table

### Use Formulas

Baserow supports formulas for calculations:

```javascript
// Calculate total
field('Price') * field('Quantity')

// Conditional logic
if(field('Amount') > 1000, 'High', 'Low')

// Text manipulation
concat(field('First Name'), ' ', field('Last Name'))

// Date calculations
date_diff('days', field('Start Date'), field('End Date'))

// Lookup values
lookup('Products', 'Name')
```

### Link Tables

1. Add a "Link to table" field
2. Select the table to link to
3. Choose relationship type (one-to-many, many-to-many)
4. Link records between tables

### API Access

Baserow provides a REST API:

```bash
# Get database tables
curl http://localhost:8000/api/database/tables/database/DATABASE_ID/

# Get table rows
curl http://localhost:8000/api/database/rows/table/TABLE_ID/ \
  -H "Authorization: Token YOUR_API_TOKEN"

# Create a row
curl -X POST http://localhost:8000/api/database/rows/table/TABLE_ID/ \
  -H "Authorization: Token YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"field_1": "value1", "field_2": "value2"}'

# Update a row
curl -X PATCH http://localhost:8000/api/database/rows/table/TABLE_ID/ROW_ID/ \
  -H "Authorization: Token YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"field_1": "new_value"}'
```

### Generate API Token

1. Click your profile icon
2. Go to "Settings"
3. Navigate to "API tokens"
4. Click "Create token"
5. Name the token and set permissions
6. Copy the token for API access

### Backup Data

```bash
# Backup the data volume
docker run --rm -v baserow-data:/data -v $(pwd):/backup alpine tar czf /backup/baserow-backup.tar.gz /data

# Backup the database
docker exec baserow_db pg_dump -U baserow baserow > baserow_db_backup.sql
```

### Restore Data

```bash
# Restore data volume
docker run --rm -v baserow-data:/data -v $(pwd):/backup alpine tar xzf /backup/baserow-backup.tar.gz -C /

# Restore database
cat baserow_db_backup.sql | docker exec -i baserow_db psql -U baserow baserow
```

### Export Table

1. Click table menu (three dots)
2. Select "Export"
3. Choose format (CSV, JSON, XML)
4. Download file

## Configuration

### Environment Variables

**Application Configuration**:
- `BASEROW_PUBLIC_URL` - The URL where Baserow is accessible
- `SECRET_KEY` - Secret key for encryption (50+ characters)

**Database Configuration**:
- `DATABASE_HOST` - Database hostname
- `DATABASE_NAME` - Database name
- `DATABASE_USER` - Database username
- `DATABASE_PASSWORD` - Database password

**Redis Configuration**:
- `REDIS_HOST` - Redis hostname
- `REDIS_PORT` - Redis port

### Generate Secret Key

```bash
# Generate a secure secret key
openssl rand -hex 50
```

Replace `SECRET_KEY` in the compose file with the generated value.

### Custom Port

To change the HTTP port, modify the ports section:

```yaml
ports:
  - "9000:80"  # Access on port 9000 instead
  - "9443:443"
```

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:8000
- **Solution**: Wait for initialization to complete. Check logs with `docker logs baserow`.

### Database Connection Failed

- **Symptoms**: Baserow shows database errors
- **Solution**: Ensure the database container is running. Verify DATABASE_HOST matches the database container name.

### Redis Connection Failed

- **Symptoms**: Application shows Redis errors
- **Solution**: Ensure the Redis container is running. Check REDIS_HOST configuration.

### File Upload Fails

- **Symptoms**: Cannot upload files to file fields
- **Solution**: Verify the data volume is mounted. Check available disk space. Review file size limits.

## Features

- **No-Code Database**: Build databases without coding
- **Multiple Field Types**: 20+ field types including formulas
- **Views**: Grid, gallery, form, kanban views
- **Filters and Sorting**: Organize data efficiently
- **Collaboration**: Real-time multi-user editing
- **API Access**: REST API for integrations
- **Webhooks**: Trigger actions on data changes
- **Import/Export**: CSV, JSON, XML support
- **File Storage**: Upload and manage files
- **Formulas**: Calculate and transform data
- **Linked Tables**: Create relationships between tables
- **Public Forms**: Collect data from external users

## Use Cases

- **Project Management**: Track tasks, projects, and teams
- **CRM**: Manage customers and sales pipeline
- **Content Management**: Organize articles and media
- **Inventory**: Track products and stock levels
- **Event Management**: Plan and coordinate events
- **HR Management**: Employee records and recruitment
- **Bug Tracking**: Manage issues and feature requests
- **Product Catalog**: Organize products and variants
- **Survey Data**: Collect and analyze responses
- **Custom Applications**: Build tailored solutions

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure SECRET_KEY (50+ characters)
- Change the database password
- Use HTTPS (port 8443) with valid SSL certificates
- Configure proper authentication
- Restrict access with firewall rules
- Regular backups are essential
- Keep Baserow updated

## Resources

- [Official Documentation](https://baserow.io/docs)
- [API Documentation](https://baserow.io/docs/apis/rest-api)
- [Formula Reference](https://baserow.io/docs/formulas)
- [GitHub Repository](https://github.com/bram2w/baserow)
- [Docker Hub](https://hub.docker.com/r/baserow/baserow)
- [Community Forum](https://community.baserow.io/)
