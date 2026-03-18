# MariaDB

MariaDB is a community-developed, commercially supported fork of the MySQL relational database management system. It's designed to remain free and open-source under the GNU GPL. MariaDB is intended to maintain high compatibility with MySQL, ensuring a drop-in replacement capability with library binary parity and exact matching with MySQL APIs and commands.

**Official Sites:**
- [MariaDB](https://mariadb.org/) | [Docker Hub](https://hub.docker.com/_/mariadb)
- [Adminer](https://www.adminer.org/) | [Docker Hub](https://hub.docker.com/_/adminer)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f mariadb.yaml up -d
```

## Services

### MariaDB Database
- **Port**: 3306
- **Container**: `mariadb_container`
- **Root Password**: `P@ss0rd123`
- **Database**: `mydb`
- **Username**: `dbuser`
- **Password**: `P@ss0rd123`

### Adminer (Database Management UI)
- **URL**: http://localhost:8080
- **Container**: `mariadb_adminer`
- **System**: MySQL
- **Server**: `mariadb`
- **Username**: `dbuser` or `root`
- **Password**: `P@ss0rd123`
- **Database**: `mydb`

## Initial Setup

1. Copy `.env.example` to `.env` and configure your settings
2. Change the default passwords (recommended for production)
3. Start the services with `docker compose -f mariadb.yaml up -d`
4. Wait for MariaDB to initialize (check logs: `docker logs mariadb_container`)
5. Access Adminer at http://localhost:8080
6. Login with the credentials configured in your `.env` file

## Configuration

### Environment Variables (.env)

- `MARIADB_PORT` - MariaDB server port (default: 3306)
- `ADMINER_PORT` - Adminer web interface port (default: 8080)
- `MYSQL_ROOT_PASSWORD` - Root user password (change for production)
- `MYSQL_DATABASE` - Default database to create on startup
- `MYSQL_USER` - Default user to create on startup
- `MYSQL_PASSWORD` - Password for the default user (change for production)
- `ADMINER_DESIGN` - Adminer theme (default: pepa-linha-dark)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

For advanced MariaDB configuration, you can mount a custom my.cnf file:

```yaml
volumes:
  - ./my.cnf:/etc/mysql/conf.d/custom.cnf
  - mariadb-data:/var/lib/mysql
```

Example my.cnf:
```ini
[mysqld]
max_connections=200
innodb_buffer_pool_size=1G
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci
```

## Connecting to MariaDB

### From Host Machine (MySQL Client)

```bash
# Using mysql client inside container
docker exec -it mariadb_container mysql -u root -pP@ss0rd123

# Or install mysql client on host and connect
mysql -h localhost -P 3306 -u dbuser -pP@ss0rd123 mydb
```

### From Application

#### Python (mysql-connector-python)

```python
import mysql.connector

# Connect to database
conn = mysql.connector.connect(
    host="localhost",
    port=3306,
    user="dbuser",
    password="P@ss0rd123",
    database="mydb"
)

cursor = conn.cursor()

# Create table
cursor.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
""")

# Insert data
cursor.execute(
    "INSERT INTO users (name, email) VALUES (%s, %s)",
    ("Alice", "alice@example.com")
)
conn.commit()

# Query data
cursor.execute("SELECT * FROM users")
for row in cursor.fetchall():
    print(row)

cursor.close()
conn.close()
```

#### JavaScript (mysql2)

```javascript
const mysql = require('mysql2/promise');

async function main() {
    // Create connection
    const connection = await mysql.createConnection({
        host: 'localhost',
        port: 3306,
        user: 'dbuser',
        password: 'P@ss0rd123',
        database: 'mydb'
    });

    // Create table
    await connection.execute(`
        CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100),
            email VARCHAR(100),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    `);

    // Insert data
    await connection.execute(
        'INSERT INTO users (name, email) VALUES (?, ?)',
        ['Alice', 'alice@example.com']
    );

    // Query data
    const [rows] = await connection.execute('SELECT * FROM users');
    console.log(rows);

    await connection.end();
}

main();
```

#### Java (JDBC)

```java
import java.sql.*;

public class MariaDBExample {
    public static void main(String[] args) {
        String url = "jdbc:mariadb://localhost:3306/mydb";
        String user = "dbuser";
        String password = "P@ss0rd123";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            // Create table
            Statement stmt = conn.createStatement();
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS users (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(100),
                    email VARCHAR(100),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """);

            // Insert data
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO users (name, email) VALUES (?, ?)"
            );
            pstmt.setString(1, "Alice");
            pstmt.setString(2, "alice@example.com");
            pstmt.executeUpdate();

            // Query data
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            while (rs.next()) {
                System.out.println(rs.getInt("id") + ": " + 
                    rs.getString("name") + " - " + rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

#### PHP (mysqli)

```php
<?php
$host = 'localhost';
$port = 3306;
$user = 'dbuser';
$password = 'P@ss0rd123';
$database = 'mydb';

// Create connection
$conn = new mysqli($host, $user, $password, $database, $port);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Create table
$sql = "CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";
$conn->query($sql);

// Insert data
$stmt = $conn->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
$stmt->bind_param("ss", $name, $email);
$name = "Alice";
$email = "alice@example.com";
$stmt->execute();

// Query data
$result = $conn->query("SELECT * FROM users");
while ($row = $result->fetch_assoc()) {
    echo $row['id'] . ": " . $row['name'] . " - " . $row['email'] . "\n";
}

$conn->close();
?>
```

### Connection String Examples

```
# Standard MySQL connection string
mysql://dbuser:P@ss0rd123@localhost:3306/mydb

# JDBC connection string
jdbc:mariadb://localhost:3306/mydb

# .NET connection string
Server=localhost;Port=3306;Database=mydb;Uid=dbuser;Pwd=P@ss0rd123;

# Django settings.py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mydb',
        'USER': 'dbuser',
        'PASSWORD': 'P@ss0rd123',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

## Volumes

- `mariadb-data` - Database files and data storage

## Using Adminer

Adminer is a full-featured database management tool written in PHP. It provides a web interface for:

### Features

- **Database Management**: Create, drop, and modify databases
- **Table Operations**: Create, alter, drop tables with visual schema editor
- **Data Manipulation**: Insert, update, delete records with a user-friendly interface
- **SQL Editor**: Execute custom SQL queries with syntax highlighting
- **Import/Export**: Import and export data in various formats (SQL, CSV, TSV)
- **User Management**: Create and manage database users and privileges
- **Schema Visualization**: View table relationships and structure
- **Multiple Database Support**: Connect to MySQL, MariaDB, PostgreSQL, SQLite, MS SQL, Oracle, and more

### Accessing Adminer

1. Navigate to http://localhost:8080
2. Select "MySQL" as the system (MariaDB is MySQL-compatible)
3. Enter server: `mariadb` (container name)
4. Enter username: `dbuser` or `root`
5. Enter password: `P@ss0rd123`
6. Enter database: `mydb` (or leave blank to see all databases)
7. Click "Login"

### Common Adminer Tasks

**Create a New Table**:
1. Click "Create table" in the left sidebar
2. Enter table name and define columns
3. Set data types, lengths, and constraints
4. Click "Save"

**Import SQL File**:
1. Click "Import" in the menu
2. Choose your SQL file
3. Click "Execute"

**Export Database**:
1. Click "Export" in the menu
2. Select format (SQL, CSV, etc.)
3. Choose tables to export
4. Click "Export"

**Execute SQL Query**:
1. Click "SQL command" in the menu
2. Enter your SQL query
3. Click "Execute"

## Common Tasks

### Create a New Database

```bash
docker exec -it mariadb_container mysql -u root -pP@ss0rd123 -e "CREATE DATABASE newdb;"
```

Or use Adminer:
1. Login to Adminer
2. Click "Create database"
3. Enter database name
4. Select collation (utf8mb4_unicode_ci recommended)
5. Click "Save"

### Create a New User

```bash
docker exec -it mariadb_container mysql -u root -pP@ss0rd123 -e "
CREATE USER 'newuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON newdb.* TO 'newuser'@'%';
FLUSH PRIVILEGES;
"
```

### Backup Database

```bash
# Backup single database
docker exec mariadb_container mysqldump -u root -pP@ss0rd123 mydb > mydb_backup.sql

# Backup all databases
docker exec mariadb_container mysqldump -u root -pP@ss0rd123 --all-databases > all_databases_backup.sql

# Backup with compression
docker exec mariadb_container mysqldump -u root -pP@ss0rd123 mydb | gzip > mydb_backup.sql.gz
```

### Restore Database

```bash
# Restore from SQL file
cat mydb_backup.sql | docker exec -i mariadb_container mysql -u root -pP@ss0rd123 mydb

# Restore from compressed file
gunzip < mydb_backup.sql.gz | docker exec -i mariadb_container mysql -u root -pP@ss0rd123 mydb
```

### View Database Size

```bash
docker exec -it mariadb_container mysql -u root -pP@ss0rd123 -e "
SELECT 
    table_schema AS 'Database',
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
FROM information_schema.tables
GROUP BY table_schema;
"
```

### Optimize Tables

```bash
docker exec -it mariadb_container mysql -u root -pP@ss0rd123 -e "
USE mydb;
OPTIMIZE TABLE users;
"
```

### View Active Connections

```bash
docker exec -it mariadb_container mysql -u root -pP@ss0rd123 -e "SHOW PROCESSLIST;"
```

### Reset Root Password

```bash
# Stop the container
docker compose -f mariadb.yaml stop mariadb

# Start with skip-grant-tables
docker run --rm -v mariadb-data:/var/lib/mysql mariadb:11.2 \
  --skip-grant-tables --skip-networking

# In another terminal, connect and reset password
docker exec -it mariadb_container mysql -u root -e "
FLUSH PRIVILEGES;
ALTER USER 'root'@'%' IDENTIFIED BY 'NewPassword123';
FLUSH PRIVILEGES;
"

# Restart normally
docker compose -f mariadb.yaml start mariadb
```

### View Logs

```bash
# MariaDB logs
docker logs mariadb_container

# Follow logs in real-time
docker logs -f mariadb_container

# Adminer logs
docker logs mariadb_adminer
```

## Features

- **MySQL Compatibility**: Drop-in replacement for MySQL with enhanced features
- **High Performance**: Optimized query execution and storage engines
- **ACID Compliance**: Full transactional support with rollback capabilities
- **Replication**: Master-slave and master-master replication support
- **Storage Engines**: Multiple storage engines (InnoDB, MyISAM, Aria, etc.)
- **JSON Support**: Native JSON data type and functions
- **Full-Text Search**: Built-in full-text search capabilities
- **Partitioning**: Table partitioning for improved performance
- **Triggers and Stored Procedures**: Advanced database programming
- **Views**: Create virtual tables based on queries
- **Foreign Keys**: Referential integrity constraints
- **Encryption**: Data-at-rest and data-in-transit encryption
- **Adminer UI**: Full-featured web-based database management interface

## Troubleshooting

### Container Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs mariadb_container`. Ensure passwords are set correctly and volumes have proper permissions.

### Cannot Connect to Database

- **Symptoms**: "Can't connect to MySQL server" error
- **Solution**: Verify the container is running with `docker ps`. Check that port 3306 is not in use by another service. Wait a few seconds for MariaDB to fully initialize.

### Authentication Failed

- **Symptoms**: "Access denied for user" error
- **Solution**: Verify your credentials are correct. Check the MYSQL_USER and MYSQL_PASSWORD environment variables. For root access, use MYSQL_ROOT_PASSWORD.

### Adminer Cannot Connect

- **Symptoms**: "Unable to connect to database" in Adminer
- **Solution**: Use `mariadb` as the server name (container name), not `localhost`. Ensure the MariaDB container is running and healthy.

### Data Not Persisting

- **Symptoms**: Data lost after container restart
- **Solution**: Ensure the volume is properly mounted. Check volume with `docker volume inspect mariadb-data`. Verify the volume path in the compose file.

### Slow Query Performance

- **Symptoms**: Queries take a long time to execute
- **Solution**: Add indexes to frequently queried columns. Increase innodb_buffer_pool_size in custom my.cnf. Use EXPLAIN to analyze query execution plans.

### Out of Disk Space

- **Symptoms**: "No space left on device" error
- **Solution**: Check disk space with `df -h`. Clean up old logs and temporary files. Consider increasing disk space or moving the data volume.

### Character Encoding Issues

- **Symptoms**: Special characters display incorrectly
- **Solution**: Ensure you're using utf8mb4 character set. Set character-set-server=utf8mb4 in my.cnf. Create tables with CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change all default passwords immediately
- Use strong passwords with mixed case, numbers, and special characters
- Restrict network access with firewall rules
- Use SSL/TLS for encrypted connections
- Limit user privileges to only what's necessary
- Regular backups are essential for production data
- Keep MariaDB updated to the latest stable version
- Disable remote root access in production
- Use separate users for different applications
- Monitor logs for suspicious activity
- Consider using MariaDB MaxScale for additional security features

## Resources

- [Official Documentation](https://mariadb.com/kb/en/documentation/)
- [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
- [Docker Hub - MariaDB](https://hub.docker.com/_/mariadb)
- [Docker Hub - Adminer](https://hub.docker.com/_/adminer)
- [Adminer Documentation](https://www.adminer.org/)
- [MariaDB vs MySQL](https://mariadb.com/kb/en/mariadb-vs-mysql-compatibility/)
- [SQL Tutorial](https://www.w3schools.com/sql/)
- [MariaDB Community](https://mariadb.org/community/)

