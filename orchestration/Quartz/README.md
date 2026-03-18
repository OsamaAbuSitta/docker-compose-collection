# Quartz.NET

A full-featured, open source job scheduling system for .NET applications. Quartz.NET provides enterprise-class features for scheduling jobs with complex triggers, clustering support, and persistent job storage.

**Official Sites:**
- [Quartz.NET](https://www.quartz-scheduler.net/) | [Docker Hub](https://hub.docker.com/_/microsoft-dotnet-aspnet)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the services
docker compose -f quartz.yaml up -d
```

## Services

### Quartz.NET Application
- **URL**: http://localhost:5001
- **Container**: `quartz_app`
- **Note**: Requires a custom .NET application with Quartz.NET configured

### PostgreSQL Database
- **Port**: 5432
- **Container**: `quartz_db`
- **Database**: `quartz`
- **Username**: `quartz`
- **Password**: `P@ss0rd123`

## Initial Setup

**Important**: This Docker Compose configuration provides the infrastructure (PostgreSQL database) for Quartz.NET, but you need to create a .NET application that uses Quartz.NET.

### Step 1: Create a .NET Application

```bash
# Create a new ASP.NET Core application
dotnet new web -n QuartzApp
cd QuartzApp

# Add Quartz.NET packages
dotnet add package Quartz
dotnet add package Quartz.Extensions.Hosting
dotnet add package Quartz.Serialization.Json
dotnet add package Npgsql
```

### Step 2: Initialize Database Schema

Download the Quartz.NET PostgreSQL schema from:
https://github.com/quartznet/quartznet/blob/main/database/tables/tables_postgres.sql

```bash
# Apply schema to database
docker exec -i quartz_db psql -U quartz -d quartz < tables_postgres.sql
```

### Step 3: Configure Quartz.NET in Program.cs

```csharp
using Quartz;

var builder = WebApplication.CreateBuilder(args);

// Add Quartz services
builder.Services.AddQuartz(q =>
{
    // Use a Scoped container for jobs
    q.UseMicrosoftDependencyInjectionJobFactory();
    
    // Use PostgreSQL for job storage
    q.UsePersistentStore(s =>
    {
        s.UsePostgres(builder.Configuration.GetConnectionString("QuartzConnection"));
        s.UseJsonSerializer();
    });
    
    // Configure scheduler
    q.SchedulerId = "AUTO";
    q.SchedulerName = builder.Configuration["Quartz:InstanceName"] ?? "QuartzScheduler";
    q.MaxBatchSize = 20;
    q.UseDefaultThreadPool(tp =>
    {
        tp.MaxConcurrency = int.Parse(builder.Configuration["Quartz:ThreadCount"] ?? "10");
    });
});

// Add Quartz hosted service
builder.Services.AddQuartzHostedService(options =>
{
    options.WaitForJobsToComplete = true;
});

var app = builder.Build();

app.MapGet("/", () => "Quartz.NET is running!");

app.Run();
```

### Step 4: Create a Sample Job

```csharp
public class SampleJob : IJob
{
    private readonly ILogger<SampleJob> _logger;

    public SampleJob(ILogger<SampleJob> logger)
    {
        _logger = logger;
    }

    public Task Execute(IJobExecutionContext context)
    {
        _logger.LogInformation("Sample job executed at {Time}", DateTime.UtcNow);
        return Task.CompletedTask;
    }
}
```

### Step 5: Schedule the Job

```csharp
// In Program.cs, add job scheduling
builder.Services.AddQuartz(q =>
{
    // ... previous configuration ...
    
    // Define the job
    var jobKey = new JobKey("SampleJob");
    q.AddJob<SampleJob>(opts => opts.WithIdentity(jobKey));
    
    // Create a trigger
    q.AddTrigger(opts => opts
        .ForJob(jobKey)
        .WithIdentity("SampleJob-trigger")
        .WithCronSchedule("0 0/5 * * * ?")); // Every 5 minutes
});
```

### Step 6: Build and Deploy

```bash
# Build the application
dotnet publish -c Release -o ./publish

# Copy to Docker volume or mount as volume in compose file
```

### Step 7: Start the Services

```bash
docker compose -f quartz.yaml up -d
```

## Configuration

### Environment Variables (.env)

- `QUARTZ_PORT` - Web interface port (default: 5001)
- `DB_EXTERNAL_PORT` - PostgreSQL external port (default: 5432)
- `INSTANCE_NAME` - Scheduler instance name (default: QuartzScheduler)
- `THREAD_COUNT` - Number of worker threads (default: 10)
- `DB_HOST` - PostgreSQL hostname (use container name)
- `DB_PORT` - PostgreSQL port (default: 5432)
- `DB_DATABASE` - Database name (default: quartz)
- `DB_USERNAME` - Database username (default: quartz)
- `DB_PASSWORD` - Database password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Connection String

The connection string is automatically constructed from environment variables:
```
Host=quartz-db;Port=5432;Database=quartz;Username=quartz;Password=P@ss0rd123;
```

## Job Scheduling

### Simple Trigger (Run Once)

```csharp
var trigger = TriggerBuilder.Create()
    .WithIdentity("myTrigger")
    .StartNow()
    .Build();

await scheduler.ScheduleJob(job, trigger);
```

### Interval Trigger (Repeat)

```csharp
var trigger = TriggerBuilder.Create()
    .WithIdentity("intervalTrigger")
    .StartNow()
    .WithSimpleSchedule(x => x
        .WithIntervalInSeconds(60)
        .RepeatForever())
    .Build();
```

### Cron Trigger (Complex Schedules)

```csharp
var trigger = TriggerBuilder.Create()
    .WithIdentity("cronTrigger")
    .WithCronSchedule("0 0 12 * * ?") // Every day at noon
    .Build();
```

### Common Cron Expressions

- `0 0/5 * * * ?` - Every 5 minutes
- `0 0 * * * ?` - Every hour
- `0 0 12 * * ?` - Every day at noon
- `0 0 0 * * ?` - Every day at midnight
- `0 0 0 ? * MON` - Every Monday at midnight
- `0 0 0 1 * ?` - First day of every month

## Job Data and Parameters

### Passing Data to Jobs

```csharp
var job = JobBuilder.Create<MyJob>()
    .WithIdentity("myJob")
    .UsingJobData("key1", "value1")
    .UsingJobData("key2", 42)
    .Build();
```

### Accessing Data in Jobs

```csharp
public class MyJob : IJob
{
    public Task Execute(IJobExecutionContext context)
    {
        var dataMap = context.JobDetail.JobDataMap;
        var value1 = dataMap.GetString("key1");
        var value2 = dataMap.GetInt("key2");
        
        // Job logic here
        
        return Task.CompletedTask;
    }
}
```

## Volumes

- `quartz-app-data` - Application data and logs
- `quartz-db-data` - PostgreSQL database files

## Common Tasks

### List All Jobs

```bash
docker exec -it quartz_db psql -U quartz -d quartz -c "SELECT * FROM qrtz_job_details;"
```

### List All Triggers

```bash
docker exec -it quartz_db psql -U quartz -d quartz -c "SELECT * FROM qrtz_triggers;"
```

### View Job Execution History

```bash
docker exec -it quartz_db psql -U quartz -d quartz -c "SELECT * FROM qrtz_fired_triggers;"
```

### Pause a Job

```csharp
await scheduler.PauseJob(new JobKey("myJob"));
```

### Resume a Job

```csharp
await scheduler.ResumeJob(new JobKey("myJob"));
```

### Delete a Job

```csharp
await scheduler.DeleteJob(new JobKey("myJob"));
```

### Backup Database

```bash
docker exec quartz_db pg_dump -U quartz quartz > quartz_backup.sql
```

### Restore Database

```bash
cat quartz_backup.sql | docker exec -i quartz_db psql -U quartz quartz
```

## Clustering

Quartz.NET supports clustering for high availability. To enable clustering:

```csharp
builder.Services.AddQuartz(q =>
{
    q.UsePersistentStore(s =>
    {
        s.UsePostgres(connectionString);
        s.UseClustering(c =>
        {
            c.CheckinInterval = TimeSpan.FromSeconds(20);
            c.CheckinMisfireThreshold = TimeSpan.FromSeconds(30);
        });
    });
});
```

Run multiple instances of your application pointing to the same database for automatic load balancing and failover.

## Troubleshooting

### Database Connection Failed

- **Symptoms**: "Connection refused" or "Login failed" errors
- **Solution**: Ensure PostgreSQL is running and credentials match. Wait for database to fully initialize (check logs: `docker logs quartz_db`)

### Jobs Not Executing

- **Symptoms**: Jobs scheduled but never run
- **Solution**: Verify the Quartz hosted service is added with `AddQuartzHostedService()`. Check application logs for errors.

### Schema Errors

- **Symptoms**: "Table does not exist" errors
- **Solution**: Ensure the Quartz.NET database schema has been applied to the PostgreSQL database

### Misfire Handling

- **Symptoms**: Jobs not running at expected times
- **Solution**: Configure misfire instructions on triggers and adjust the misfire threshold in clustering configuration

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the PostgreSQL password to a strong password
- Use connection pooling for better performance
- Restrict PostgreSQL port access with firewall rules
- Enable SSL/TLS for database connections
- Implement authentication and authorization for job management endpoints
- Regular backups are essential
- Monitor job execution and failures

## Resources

- [Official Documentation](https://www.quartz-scheduler.net/documentation/)
- [GitHub Repository](https://github.com/quartznet/quartznet)
- [Cron Expression Generator](https://www.freeformatter.com/cron-expression-generator-quartz.html)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
