# Grist

A modern relational spreadsheet that combines the flexibility of spreadsheets with the power of databases. Grist is perfect for organizing data, building custom tools, and creating lightweight applications.

**Official Sites:**
- [Grist](https://www.getgrist.com/) | [Docker Hub](https://hub.docker.com/r/gristlabs/grist)

## Quick Start

```bash
docker compose -f grist.yaml up -d
```

## Services

### Grist
- **URL**: http://localhost:8484
- **Container**: `grist`
- **Default Email**: `admin@example.com`
- **Note**: No password required for local setup

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `grist_db`
- **Database**: `grist`
- **Username**: `grist`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Start the services with `docker compose -f grist.yaml up -d`
2. Navigate to http://localhost:8484
3. Sign in with the default email (admin@example.com)
4. Create your first document
5. Start building spreadsheets and databases

## Volumes

- `grist-data` - Document files and attachments
- `grist-db-data` - PostgreSQL database files

## Common Tasks

### Create a New Document

1. Click "Add New" on the home page
2. Choose "Create empty document"
3. Name your document
4. Start adding tables and data

### Import Data

Supported import formats:
- Excel (.xlsx, .xls)
- CSV files
- Google Sheets (via URL)

To import:
1. Click "Add New"
2. Select "Import document"
3. Choose file or paste URL
4. Map columns and import

### Create Tables and Columns

1. Click "Add New" in the left sidebar
2. Select "Add Page" > "Table"
3. Name your table
4. Add columns with different types:
   - Text, Numeric, Date, Choice
   - Reference (link to other tables)
   - Attachments, Toggle, etc.

### Build Forms

1. Create a table for form data
2. Click "Add New" > "Add Page" > "Form"
3. Select the table to collect data
4. Customize form fields
5. Share the form URL

### Create Views

1. Click "Add New" > "Add Page"
2. Choose view type:
   - Card: Kanban-style cards
   - Chart: Visualize data
   - Calendar: Date-based view
   - Custom: Build custom layouts
3. Configure view settings

### Use Formulas

Grist supports Python-like formulas:

```python
# Calculate total
$Price * $Quantity

# Conditional logic
"High" if $Amount > 1000 else "Low"

# Reference other tables
$Products.lookupOne(id=$ProductID).Name

# Aggregate data
SUM(Transactions.Amount)
```

### Access Control

1. Click "Share" button
2. Add users by email
3. Set permissions:
   - Viewer: Read-only access
   - Editor: Can edit data
   - Owner: Full control
4. Share the document link

### Export Data

1. Click document menu (three dots)
2. Select "Export"
3. Choose format:
   - Excel (.xlsx)
   - CSV
   - SQLite database
4. Download file

### Backup Documents

```bash
# Backup the data volume
docker run --rm -v grist-data:/data -v $(pwd):/backup alpine tar czf /backup/grist-backup.tar.gz /data

# Backup the database
docker exec grist_db pg_dump -U grist grist > grist_db_backup.sql
```

### Restore Documents

```bash
# Restore data volume
docker run --rm -v grist-data:/data -v $(pwd):/backup alpine tar xzf /backup/grist-backup.tar.gz -C /

# Restore database
cat grist_db_backup.sql | docker exec -i grist_db psql -U grist grist
```

## API Access

Grist provides a REST API for programmatic access:

```bash
# Get document data
curl http://localhost:8484/api/docs/DOC_ID/tables/TABLE_ID/records

# Add a record
curl -X POST http://localhost:8484/api/docs/DOC_ID/tables/TABLE_ID/records \
  -H "Content-Type: application/json" \
  -d '{"records": [{"fields": {"Name": "John", "Age": 30}}]}'

# Update a record
curl -X PATCH http://localhost:8484/api/docs/DOC_ID/tables/TABLE_ID/records \
  -H "Content-Type: application/json" \
  -d '{"records": [{"id": 1, "fields": {"Age": 31}}]}'
```

## Configuration

### Environment Variables

**Application Configuration**:
- `GRIST_SINGLE_ORG` - Organization name
- `GRIST_DEFAULT_EMAIL` - Default admin email
- `GRIST_SESSION_SECRET` - Session encryption secret (32+ characters)

**Database Configuration**:
- `TYPEORM_TYPE` - Database type (postgres)
- `TYPEORM_HOST` - Database hostname
- `TYPEORM_DATABASE` - Database name
- `TYPEORM_USERNAME` - Database username
- `TYPEORM_PASSWORD` - Database password

### Generate Session Secret

```bash
# Generate a secure session secret
openssl rand -hex 32
```

Replace `GRIST_SESSION_SECRET` in the compose file with the generated value.

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "9000:8484"  # Access on port 9000 instead
```

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:8484
- **Solution**: Ensure the container is running. Check logs with `docker logs grist`.

### Database Connection Failed

- **Symptoms**: Grist shows database errors
- **Solution**: Verify the database container is running. Check TYPEORM_HOST matches the database container name.

### Documents Not Saving

- **Symptoms**: Changes are lost after restart
- **Solution**: Verify volumes are properly mounted. Check container logs for errors.

### Import Fails

- **Symptoms**: Cannot import Excel or CSV files
- **Solution**: Check file format is supported. Verify file size is reasonable. Review error messages.

## Features

- **Relational Data**: Link tables with references
- **Python Formulas**: Powerful calculations and logic
- **Multiple Views**: Table, card, chart, calendar, form
- **Access Control**: Share with specific permissions
- **API Access**: REST API for integrations
- **Import/Export**: Excel, CSV, SQLite
- **Custom Widgets**: Extend with custom components
- **Attachments**: Store files in cells
- **Conditional Formatting**: Highlight data based on rules
- **Filtering and Sorting**: Organize data efficiently

## Use Cases

- **Project Management**: Track tasks and milestones
- **CRM**: Manage customers and contacts
- **Inventory**: Track products and stock
- **Event Planning**: Organize events and attendees
- **Content Calendar**: Plan and schedule content
- **Bug Tracking**: Manage issues and bugs
- **HR Management**: Employee records and onboarding
- **Sales Pipeline**: Track leads and opportunities
- **Custom Applications**: Build lightweight apps

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure GRIST_SESSION_SECRET (32+ characters)
- Change the database password
- Configure proper authentication (OAuth, SAML)
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential

## Resources

- [Official Documentation](https://support.getgrist.com/)
- [Formula Reference](https://support.getgrist.com/formulas/)
- [API Documentation](https://support.getgrist.com/api/)
- [GitHub Repository](https://github.com/gristlabs/grist-core)
- [Docker Hub](https://hub.docker.com/r/gristlabs/grist)
