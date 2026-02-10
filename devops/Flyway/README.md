# Flyway

Flyway is an open-source database migration tool that helps you version control your database schema. It allows you to reliably evolve your database schema through versioned SQL migration scripts, making database changes trackable, repeatable, and automated.

**Official Sites:**
- [Flyway](https://flywaydb.org/) | [Docker Hub](https://hub.docker.com/r/flyway/flyway)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your database settings

# Start PostgreSQL database
docker compose -f flyway.yaml up -d postgres

# Run Flyway migrations
docker compose -f flyway.yaml run --rm flyway migrate

# Check migration status
docker compose -f flyway.yaml run --rm flyway info
```

## Services

### Flyway
- **Container**: `flyway_container`
- **Command**: Runs Flyway commands (info, migrate, validate, etc.)
- **Migration Scripts**: Located in `./sql/` directory

### PostgreSQL Database (Example)
- **Port**: 5432
- **Container**: `flyway_postgres`
- **Database**: `mydb`
- **Username**: `postgres`
- **Password**: `P@ssw0rd@123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure your database settings
2. Create your migration scripts in the `sql/` directory
3. Start the database: `docker compose -f flyway.yaml up -d postgres`
4. Run migrations: `docker compose -f flyway.yaml run --rm flyway migrate`
5. Verify migrations: `docker compose -f flyway.yaml run --rm flyway info`

## Configuration

### Environment Variables (.env)

- `DB_HOST` - Database hostname (default: postgres)
- `DB_PORT` - Database port (default: 5432)
- `DB_NAME` - Database name (default: mydb)
- `DB_USER` - Database username (default: postgres)
- `DB_PASSWORD` - Database password (change for production)
- `FLYWAY_SCHEMAS` - Database schemas to manage (default: public)
- `FLYWAY_BASELINE_ON_MIGRATE` - Baseline on first migration (default: true)
- `FLYWAY_VALIDATE_ON_MIGRATE` - Validate before migration (default: true)
- `FLYWAY_LOCATIONS` - Migration script locations (default: filesystem:/flyway/sql)
- `TZ` - Timezone (default: UTC)

### Migration Script Naming

Flyway uses a specific naming convention for migration scripts:

**Versioned Migrations** (applied once):
- Format: `V{version}__{description}.sql`
- Example: `V1__Create_users_table.sql`
- Example: `V2__Add_user_roles.sql`
- Example: `V2.1__Add_email_column.sql`

**Repeatable Migrations** (applied on checksum change):
- Format: `R__{description}.sql`
- Example: `R__Create_views.sql`
- Example: `R__Update_stored_procedures.sql`

**Undo Migrations** (rollback):
- Format: `U{version}__{description}.sql`
- Example: `U1__Drop_users_table.sql`

### Custom Configuration

Additional Flyway configuration can be added to `conf/flyway.conf` file. See the [Flyway Configuration Documentation](https://flywaydb.org/documentation/configuration/parameters) for all available options.

## Connecting to Other Databases

### MySQL/MariaDB
```yaml
environment:
  - FLYWAY_URL=jdbc:mysql://${DB_HOST}:3306/${DB_NAME}
  - FLYWAY_USER=${DB_USER}
  - FLYWAY_PASSWORD=${DB_PASSWORD}
```

### SQL Server
```yaml
environment:
  - FLYWAY_URL=jdbc:sqlserver://${DB_HOST}:1433;databaseName=${DB_NAME}
  - FLYWAY_USER=${DB_USER}
  - FLYWAY_PASSWORD=${DB_PASSWORD}
```

### Oracle
```yaml
environment:
  - FLYWAY_URL=jdbc:oracle:thin:@${DB_HOST}:1521:${DB_NAME}
  - FLYWAY_USER=${DB_USER}
  - FLYWAY_PASSWORD=${DB_PASSWORD}
```

## Volumes

- `./sql` - Migration SQL scripts (mounted to /flyway/sql)
- `./conf` - Flyway configuration files (mounted to /flyway/conf)
- `postgres-data` - PostgreSQL database files (example database)

## Common Tasks

### Run Migrations
```bash
# Apply all pending migrations
docker compose -f flyway.yaml run --rm flyway migrate

# Migrate to specific version
docker compose -f flyway.yaml run --rm flyway -target=2 migrate
```

### Check Migration Status
```bash
# Show migration information
docker compose -f flyway.yaml run --rm flyway info

# Validate applied migrations
docker compose -f flyway.yaml run --rm flyway validate
```

### Baseline Existing Database
```bash
# Baseline at version 1
docker compose -f flyway.yaml run --rm flyway baseline

# Baseline at specific version
docker compose -f flyway.yaml run --rm flyway -baselineVersion=5 baseline
```

### Repair Migration History
```bash
# Repair schema history table
docker compose -f flyway.yaml run --rm flyway repair
```

### Clean Database (Development Only)
```bash
# WARNING: Drops all objects in configured schemas
docker compose -f flyway.yaml run --rm flyway clean
```

### Create New Migration
```bash
# Create a new migration file
cat > sql/V3__Add_posts_table.sql << 'EOF'
-- Flyway Migration: Add posts table
-- Version: 3
-- Description: Create posts table for blog functionality

CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    published BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_published ON posts(published);
EOF
```

### Undo Last Migration (Flyway Teams)
```bash
# Undo the last applied migration
docker compose -f flyway.yaml run --rm flyway undo
```

### Generate Migration from Database
```bash
# Connect to database and export schema
docker exec flyway_postgres pg_dump -U postgres -s mydb > sql/V1__Initial_schema.sql
```

## Migration Script Examples

### Example 1: Create Table
```sql
-- V1__Create_products_table.sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Example 2: Add Column
```sql
-- V2__Add_product_description.sql
ALTER TABLE products ADD COLUMN description TEXT;
ALTER TABLE products ADD COLUMN category VARCHAR(50);
```

### Example 3: Create Index
```sql
-- V3__Add_product_indexes.sql
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_products_category ON products(category);
```

### Example 4: Insert Data
```sql
-- V4__Insert_initial_products.sql
INSERT INTO products (name, price, stock, category) VALUES
    ('Product A', 19.99, 100, 'Electronics'),
    ('Product B', 29.99, 50, 'Books'),
    ('Product C', 9.99, 200, 'Toys');
```

### Example 5: Repeatable Migration
```sql
-- R__Create_product_view.sql
CREATE OR REPLACE VIEW product_summary AS
SELECT 
    category,
    COUNT(*) as product_count,
    AVG(price) as avg_price,
    SUM(stock) as total_stock
FROM products
GROUP BY category;
```

## Features

- **Version Control**: Track database schema changes with version numbers
- **Repeatable Migrations**: Apply migrations that can be re-run on checksum change
- **Baseline**: Start versioning existing databases
- **Validation**: Verify applied migrations match source files
- **Undo**: Rollback migrations (Flyway Teams)
- **Dry Run**: Preview migrations without applying (Flyway Teams)
- **Multiple Databases**: Support for 20+ database types
- **CI/CD Integration**: Automate migrations in deployment pipelines
- **Callbacks**: Execute custom code before/after migrations
- **Placeholders**: Use variables in migration scripts

## Troubleshooting

### Migration Fails with Checksum Mismatch
- **Symptoms**: Flyway reports checksum validation error
- **Solution**: If migration was already applied, use `flyway repair` to fix the checksum. If not applied, fix the migration script.

### Cannot Connect to Database
- **Symptoms**: Connection refused or authentication failed
- **Solution**: Verify database is running and credentials are correct. Check `DB_HOST`, `DB_PORT`, `DB_USER`, and `DB_PASSWORD` in `.env`.

### Migration Already Applied
- **Symptoms**: Flyway reports migration version already exists
- **Solution**: Use a higher version number for new migrations. Check current version with `flyway info`.

### Baseline Required
- **Symptoms**: Flyway reports non-empty schema without baseline
- **Solution**: Run `flyway baseline` to mark existing schema as baseline version.

### Permission Denied
- **Symptoms**: Cannot create tables or modify schema
- **Solution**: Ensure database user has sufficient privileges (CREATE, ALTER, DROP, etc.).

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change all default database passwords
- Use secure connection strings (SSL/TLS)
- Restrict database user permissions to minimum required
- Store credentials in secure secret management systems
- Never commit `.env` files with production credentials
- Use read-only accounts for validation and info commands
- Enable audit logging for migration tracking
- Review all migration scripts before applying to production
- Test migrations in staging environment first
- Keep backups before running migrations

## Resources

- [Flyway Documentation](https://flywaydb.org/documentation/)
- [Configuration Parameters](https://flywaydb.org/documentation/configuration/parameters)
- [Migration Scripts](https://flywaydb.org/documentation/concepts/migrations)
- [Docker Hub](https://hub.docker.com/r/flyway/flyway)
- [Command Line Reference](https://flywaydb.org/documentation/usage/commandline/)
