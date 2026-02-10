# Hangfire

An easy way to perform background processing in .NET applications. Hangfire allows you to kick off method calls outside of the request processing pipeline in a reliable way. It provides a built-in dashboard for monitoring and managing background jobs.

**Official Sites:**
- [Hangfire](https://www.hangfire.io/) | [Docker Hub](https://hub.docker.com/_/microsoft-dotnet-aspnet)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the services
docker compose -f hangfire.yaml up -d
```

## Services

### Hangfire Application
- **URL**: http://localhost:5000/hangfire
- **Container**: `hangfire_app`
- **Note**: Requires a custom .NET application with Hangfire configured

### SQL Server Database
- **Port**: 1433
- **Container**: `hangfire_db`
- **Database**: `Hangfire`
- **Username**: `sa`
- **Password**: `P@ssw0rd@123`

## Initial Setup

**Important**: This Docker Compose configuration provides the infrastructure (SQL Server database) for Hangfire, but you need to create a .NET application that uses Hangfire.

### Step 1: Create a .NET Application

```bash
# Create a new ASP.NET Core application
dotnet new web -n HangfireApp
cd HangfireApp

# Add Hangfire packages
dotnet add package Hangfire.Core
dotnet add package Hangfire.SqlServer
dotnet add package Hangfire.AspNetCore
```

### Step 2: Configure Hangfire in Program.cs

```csharp
using Hangfire;
using Hangfire.SqlServer;

var builder = WebApplication.CreateBuilder(args);

// Add Hangfire services
builder.Services.AddHangfire(configuration => configuration
    .SetDataCompatibilityLevel(CompatibilityLevel.Version_180)
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UseSqlServerStorage(builder.Configuration.GetConnectionString("HangfireConnection"), 
        new SqlServerStorageOptions
        {
            CommandBatchMaxTimeout = TimeSpan.FromMinutes(5),
            SlidingInvisibilityTimeout = TimeSpan.FromMinutes(5),
            QueuePollInterval = TimeSpan.Zero,
            UseRecommendedIsolationLevel = true,
            DisableGlobalLocks = true
        }));

builder.Services.AddHangfireServer();

var app = builder.Build();

app.UseHangfireDashboard("/hangfire");

app.MapGet("/", () => "Hangfire is running! Visit /hangfire for the dashboard.");

app.Run();
```

### Step 3: Build and Deploy

```bash
# Build the application
dotnet publish -c Release -o ./publish

# Copy to Docker volume or mount as volume in compose file
```

### Step 4: Start the Services

```bash
docker compose -f hangfire.yaml up -d
```

## Configuration

### Environment Variables (.env)

- `HANGFIRE_PORT` - Web interface port (default: 5000)
- `SQL_PORT` - SQL Server port (default: 1433)
- `DASHBOARD_PATH` - Dashboard URL path (default: /hangfire)
- `WORKER_COUNT` - Number of background workers (default: 5)
- `SQL_HOST` - SQL Server hostname (use container name)
- `SQL_DATABASE` - Database name (default: Hangfire)
- `SQL_USER` - SQL Server username (default: sa)
- `SQL_PASSWORD` - SQL Server password (change for production)
- `MSSQL_PID` - SQL Server edition (Developer, Express, Standard, Enterprise)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Connection String

The connection string is automatically constructed from environment variables:
```
Server=hangfire-db;Database=Hangfire;User Id=sa;Password=P@ssw0rd@123;TrustServerCertificate=True;
```

## Scheduling Jobs

### Fire-and-Forget Jobs

```csharp
BackgroundJob.Enqueue(() => Console.WriteLine("Fire-and-forget job!"));
```

### Delayed Jobs

```csharp
BackgroundJob.Schedule(() => Console.WriteLine("Delayed job!"), TimeSpan.FromDays(1));
```

### Recurring Jobs

```csharp
RecurringJob.AddOrUpdate("my-job-id", () => Console.WriteLine("Recurring job!"), Cron.Daily);
```

### Continuations

```csharp
var jobId = BackgroundJob.Enqueue(() => Console.WriteLine("First job"));
BackgroundJob.ContinueJobWith(jobId, () => Console.WriteLine("Continuation job"));
```

## Dashboard Features

The Hangfire Dashboard provides:
- **Jobs**: View all jobs (enqueued, processing, succeeded, failed)
- **Recurring Jobs**: Manage recurring job schedules
- **Servers**: Monitor Hangfire server instances
- **Retries**: View and manage failed jobs
- **Statistics**: Job processing statistics and metrics

## Volumes

- `hangfire-app-data` - Application data and logs
- `hangfire-db-data` - SQL Server database files

## Common Tasks

### View Job Status

Access the dashboard at http://localhost:5000/hangfire to view all job statuses.

### Retry Failed Jobs

Failed jobs can be retried from the dashboard or programmatically:

```csharp
BackgroundJob.Requeue(jobId);
```

### Delete Jobs

```csharp
BackgroundJob.Delete(jobId);
```

### Connect to SQL Server

```bash
# Using sqlcmd
docker exec -it hangfire_db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'P@ssw0rd@123'

# List databases
SELECT name FROM sys.databases;
GO
```

### Backup Database

```bash
docker exec hangfire_db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'P@ssw0rd@123' -Q "BACKUP DATABASE [Hangfire] TO DISK = N'/var/opt/mssql/backup/Hangfire.bak' WITH NOFORMAT, NOINIT, NAME = 'Hangfire-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"
```

## Troubleshooting

### SQL Server Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Ensure SA_PASSWORD meets complexity requirements (at least 8 characters, uppercase, lowercase, numbers, and symbols)

### Cannot Connect to Database

- **Symptoms**: "Login failed for user 'sa'" error
- **Solution**: Verify the SQL_PASSWORD in .env matches the SA_PASSWORD. Wait for SQL Server to fully initialize (check logs: `docker logs hangfire_db`)

### Dashboard Not Accessible

- **Symptoms**: 404 error when accessing /hangfire
- **Solution**: Ensure your .NET application is properly configured with `app.UseHangfireDashboard("/hangfire")`

### Jobs Not Processing

- **Symptoms**: Jobs remain in "Enqueued" state
- **Solution**: Verify Hangfire server is running with `builder.Services.AddHangfireServer()` in your application

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the SQL Server SA password to a strong password
- Use Windows Authentication or create dedicated SQL users instead of SA
- Secure the Hangfire dashboard with authentication
- Use HTTPS with a reverse proxy
- Restrict SQL Server port access with firewall rules
- Enable SQL Server encryption
- Regular backups are essential

### Securing the Dashboard

```csharp
app.UseHangfireDashboard("/hangfire", new DashboardOptions
{
    Authorization = new[] { new MyAuthorizationFilter() }
});
```

## Resources

- [Official Documentation](https://docs.hangfire.io/)
- [GitHub Repository](https://github.com/HangfireIO/Hangfire)
- [SQL Server Documentation](https://docs.microsoft.com/en-us/sql/sql-server/)
