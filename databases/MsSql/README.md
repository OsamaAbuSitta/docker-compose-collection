# Microsoft SQL Server

Docker configurations for running Microsoft SQL Server in containers.

## Available Editions

### Express Edition (sql-express-edition.yaml)
Free edition with limitations, suitable for development and small applications.

### Developer Edition (sql-develper-edition.yaml)
Full-featured edition for development and testing (not for production).

### Windows Edition (sql-dev-windows.yaml)
SQL Server running on Windows containers.

## Quick Start

### Express Edition

```bash
docker compose -f sql-express-edition.yaml up -d
```

## Connection Details

- **Host**: `localhost`
- **Port**: `1431` (mapped from internal 1433)
- **Username**: `sa`
- **Password**: `P@ssw0rd`
- **Container**: `sql-server-db`

## Connecting to SQL Server

### Using sqlcmd (from container)

```bash
docker exec -it sql-server-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'P@ssw0rd'
```

### Using Azure Data Studio

1. Download [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download)
2. Create new connection:
   - Server: `localhost,1431`
   - Authentication: SQL Login
   - Username: `sa`
   - Password: `P@ssw0rd`

### Using SQL Server Management Studio (SSMS)

1. Server name: `localhost,1431`
2. Authentication: SQL Server Authentication
3. Login: `sa`
4. Password: `P@ssw0rd`

### Connection String

```
Server=localhost,1431;Database=master;User Id=sa;Password=P@ssw0rd;TrustServerCertificate=True;
```

## Common Tasks

### Create Database

```sql
CREATE DATABASE MyDatabase;
GO
```

### List Databases

```sql
SELECT name FROM sys.databases;
GO
```

### Backup Database

```bash
docker exec sql-server-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'P@ssw0rd' -Q "BACKUP DATABASE MyDatabase TO DISK='/var/opt/mssql/data/MyDatabase.bak'"
```

### Restore Database

```bash
docker exec sql-server-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'P@ssw0rd' -Q "RESTORE DATABASE MyDatabase FROM DISK='/var/opt/mssql/data/MyDatabase.bak'"
```

### Copy Backup File from Container

```bash
docker cp sql-server-db:/var/opt/mssql/data/MyDatabase.bak ./MyDatabase.bak
```

### Copy Backup File to Container

```bash
docker cp ./MyDatabase.bak sql-server-db:/var/opt/mssql/data/MyDatabase.bak
```

## Persistent Data

The `mssqldata` directory contains:
- `data/` - Database files (.mdf, .ldf)
- `log/` - SQL Server logs
- `secrets/` - Machine keys

## Configuration

### Change SA Password

Edit the `SA_PASSWORD` environment variable. Password must meet complexity requirements:
- At least 8 characters
- Contains uppercase, lowercase, numbers, and symbols

### Change Edition

Edit the `MSSQL_PID` environment variable:
- `Express` - Express Edition
- `Developer` - Developer Edition
- `Enterprise` - Enterprise Edition (requires license)
- `Standard` - Standard Edition (requires license)

### Memory Limits

Add memory limits to prevent SQL Server from consuming all available memory:

```yaml
deploy:
  resources:
    limits:
      memory: 2G
```

## Troubleshooting

### Container Exits Immediately

- Check password complexity requirements
- View logs: `docker compose logs sql-server-db`
- Ensure EULA is accepted: `ACCEPT_EULA: "Y"`

### Cannot Connect

- Verify container is running: `docker compose ps`
- Check port mapping: `docker port sql-server-db`
- Ensure firewall allows port 1431

### Performance Issues

- Increase memory allocation
- Check disk I/O performance
- Review SQL Server error logs

## Resources

- [SQL Server on Docker Documentation](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment)
- [SQL Server Docker Hub](https://hub.docker.com/_/microsoft-mssql-server)
- [sqlcmd Utility](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility)
