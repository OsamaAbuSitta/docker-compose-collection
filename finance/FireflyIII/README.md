# Firefly III

A free and open source personal finance manager. Firefly III helps you track your expenses and income, so you can spend less and save more. Features include support for budgets, categories, tags, and multi-currency transactions.

**Official Sites:**
- [Firefly III](https://www.firefly-iii.org/) | [Docker Hub](https://hub.docker.com/r/fireflyiii/core)

## Quick Start

```bash
docker compose -f firefly-iii.yaml up -d
```

## Services

### Firefly III Application
- **URL**: http://localhost:8080
- **Container**: `firefly_app`
- **Note**: Create your admin account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `firefly_db`
- **Database**: `firefly`
- **Username**: `firefly`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Start the services with `docker compose -f firefly-iii.yaml up -d`
2. Wait for the application to initialize (check logs: `docker logs firefly_app`)
3. Navigate to http://localhost:8080
4. Create your admin account
5. Complete the setup wizard to configure your financial accounts

## Volumes

- `firefly-upload` - Uploaded files and attachments
- `firefly-db-data` - PostgreSQL database files

## Common Tasks

### Create a Budget

1. Navigate to "Budgets" in the main menu
2. Click "Create a budget"
3. Set the budget name, amount, and period
4. Assign transactions to the budget

### Import Transactions

```bash
# Access the import feature through the web UI
# Supports CSV, Spectre, and other formats
```

### Backup Database

```bash
docker exec firefly_db pg_dump -U firefly firefly > firefly_backup.sql
```

### Restore Database

```bash
cat firefly_backup.sql | docker exec -i firefly_db psql -U firefly firefly
```

## Configuration

### Environment Variables

- `APP_KEY` - Application encryption key (must be 32 characters)
- `APP_URL` - The URL where Firefly III is accessible
- `DB_HOST` - Database hostname (use container name)
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports, add environment variables, or configure additional settings. See the [official documentation](https://docs.firefly-iii.org/) for all available options.

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check that APP_KEY is exactly 32 characters. Generate a new one if needed.

### Database Connection Failed

- **Symptoms**: "Could not connect to database" error
- **Solution**: Ensure the database container is running and healthy. Check DB_HOST matches the database container name.

### Permission Errors

- **Symptoms**: Cannot upload files or write data
- **Solution**: Check volume permissions. The application runs as www-data (UID 33).

## Security Notes

⚠️ **Important**: The default credentials are for development only. For production use:
- Generate a secure APP_KEY using `head /dev/urandom | LC_ALL=C tr -dc 'A-Za-z0-9' | head -c 32`
- Change the database password
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules

## Resources

- [Official Documentation](https://docs.firefly-iii.org/)
- [GitHub Repository](https://github.com/firefly-iii/firefly-iii)
- [Docker Hub](https://hub.docker.com/r/fireflyiii/core)
