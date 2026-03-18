# Nexus Repository Manager

Nexus Repository Manager is a universal artifact repository that supports all major package formats including Maven, npm, Docker, PyPI, NuGet, RubyGems, and more. It provides a single source of truth for all your software components and binaries.

**Official Sites:**
- [Sonatype Nexus](https://www.sonatype.com/products/nexus-repository) | [Docker Hub](https://hub.docker.com/r/sonatype/nexus3)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start Nexus
docker compose -f nexus.yaml up -d
```

## Services

### Nexus Repository Manager
- **URL**: http://localhost:8081
- **Docker Registry**: http://localhost:8082
- **Container**: `nexus_container`
- **Username**: `admin`
- **Password**: Located in `/nexus-data/admin.password` (first login only)

## Initial Setup

1. Copy `.env.example` to `.env` and configure your settings
2. **Important**: Ensure your system has at least 4GB RAM available
3. Start the service with `docker compose -f nexus.yaml up -d`
4. Wait 2-3 minutes for Nexus to initialize (first startup is slow)
5. Check initialization progress: `docker logs -f nexus_container`
6. Navigate to http://localhost:8081
7. Click "Sign in" in the top right
8. Retrieve the initial admin password:
   ```bash
   docker exec nexus_container cat /nexus-data/admin.password
   ```
9. Log in with username `admin` and the retrieved password
10. Complete the setup wizard:
    - Set a new admin password
    - Configure anonymous access (enable for public repositories)
    - Complete the wizard

## Configuration

### Environment Variables (.env)

- `NEXUS_HTTP_PORT` - Web interface port (default: 8081)
- `NEXUS_DOCKER_PORT` - Docker registry port (default: 8082)
- `NEXUS_MIN_HEAP` - Minimum JVM heap size (default: 2703m)
- `NEXUS_MAX_HEAP` - Maximum JVM heap size (default: 2703m)
- `NEXUS_MAX_DIRECT_MEMORY` - Maximum direct memory (default: 2703m)
- `NEXUS_CONTEXT` - Context path (default: /)
- `TZ` - Timezone (default: UTC)

### Memory Requirements

Nexus requires significant memory to run properly:
- **Minimum**: 4GB RAM (2.7GB for Nexus + 1.3GB for OS)
- **Recommended**: 8GB+ RAM for production use
- Adjust heap sizes in `.env` based on your available resources

### Custom Configuration

Advanced configuration can be done through:
- Web UI: Administration > System > Capabilities
- Configuration files in `/nexus-data/etc/` directory
- See [Nexus Documentation](https://help.sonatype.com/repomanager3) for details

## Connecting to Nexus

### Web Interface
```
http://localhost:8081
```

### Maven Configuration
Add to `~/.m2/settings.xml`:
```xml
<settings>
  <mirrors>
    <mirror>
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>http://localhost:8081/repository/maven-public/</url>
    </mirror>
  </mirrors>
  <servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>your-password</password>
    </server>
  </servers>
</settings>
```

### npm Configuration
```bash
npm config set registry http://localhost:8081/repository/npm-group/
npm login --registry=http://localhost:8081/repository/npm-hosted/
```

### Docker Registry
```bash
# Login to Nexus Docker registry
docker login localhost:8082

# Tag and push image
docker tag myimage:latest localhost:8082/myimage:latest
docker push localhost:8082/myimage:latest

# Pull image
docker pull localhost:8082/myimage:latest
```

### PyPI Configuration
Add to `~/.pip/pip.conf`:
```ini
[global]
index-url = http://localhost:8081/repository/pypi-group/simple
trusted-host = localhost
```

## Volumes

- `nexus-data` - Nexus data including repositories, configuration, and uploaded artifacts

## Common Tasks

### Create a New Repository
1. Log in to Nexus web interface
2. Go to Administration > Repository > Repositories
3. Click "Create repository"
4. Select repository type (maven2, npm, docker, etc.)
5. Choose format (hosted, proxy, or group)
6. Configure repository settings
7. Click "Create repository"

### Set Up Docker Registry
1. Create a Docker hosted repository:
   - Go to Repositories > Create repository > docker (hosted)
   - Name: `docker-hosted`
   - HTTP port: `8082`
   - Enable Docker V1 API if needed
2. Create a Docker proxy repository (optional):
   - Create repository > docker (proxy)
   - Name: `docker-proxy`
   - Remote storage: `https://registry-1.docker.io`
3. Create a Docker group repository:
   - Create repository > docker (group)
   - Name: `docker-group`
   - Add hosted and proxy repositories to group

### Configure npm Registry
1. Create npm hosted repository:
   - Repositories > Create repository > npm (hosted)
   - Name: `npm-hosted`
2. Create npm proxy repository:
   - Create repository > npm (proxy)
   - Name: `npm-proxy`
   - Remote storage: `https://registry.npmjs.org`
3. Create npm group repository:
   - Create repository > npm (group)
   - Name: `npm-group`
   - Add hosted and proxy repositories

### Set Up Maven Repository
1. Default repositories are pre-configured:
   - `maven-central` (proxy to Maven Central)
   - `maven-releases` (hosted)
   - `maven-snapshots` (hosted)
   - `maven-public` (group)
2. Configure in your `pom.xml` or `settings.xml`

### Create User Account
1. Go to Administration > Security > Users
2. Click "Create local user"
3. Enter user details (ID, password, email)
4. Assign roles (e.g., nx-admin, nx-anonymous)
5. Click "Create local user"

### Backup Nexus
```bash
# Backup the entire data volume
docker run --rm -v nexus-data:/data -v $(pwd):/backup alpine tar czf /backup/nexus-backup.tar.gz -C /data .

# Or use Nexus built-in backup tasks
# Go to Administration > System > Tasks
# Create task > Admin - Export configuration for backup
```

### Restore from Backup
```bash
# Stop Nexus
docker compose -f nexus.yaml down

# Restore data volume
docker run --rm -v nexus-data:/data -v $(pwd):/backup alpine sh -c "cd /data && tar xzf /backup/nexus-backup.tar.gz"

# Start Nexus
docker compose -f nexus.yaml up -d
```

## Features

- **Universal Repository**: Support for 30+ package formats
- **Proxy Repositories**: Cache remote repositories locally
- **Hosted Repositories**: Host your own artifacts
- **Group Repositories**: Combine multiple repositories
- **Docker Registry**: Full Docker registry support
- **Security**: Fine-grained access control and authentication
- **High Availability**: Clustering support (Pro version)
- **REST API**: Automate repository management
- **Cleanup Policies**: Automatic artifact cleanup
- **Repository Health Check**: Verify repository integrity

## Troubleshooting

### Nexus Won't Start
- **Symptoms**: Container exits immediately or fails to start
- **Solution**: Check available memory. Nexus requires at least 4GB RAM. Increase Docker memory limit or reduce heap sizes in `.env`.

### Cannot Access Web Interface
- **Symptoms**: Connection refused or timeout
- **Solution**: Wait 2-3 minutes for initialization. Check logs: `docker logs nexus_container`. Verify port 8081 is not in use.

### Forgot Admin Password
- **Symptoms**: Cannot log in with admin account
- **Solution**: Reset password by editing `/nexus-data/admin.password` file in the volume, then restart Nexus.

### Out of Disk Space
- **Symptoms**: Cannot upload artifacts or Nexus becomes slow
- **Solution**: Clean up old artifacts using cleanup policies. Increase disk space or move data volume to larger disk.

### Docker Push Fails
- **Symptoms**: Cannot push images to Nexus Docker registry
- **Solution**: Ensure Docker registry is configured with HTTP connector on port 8082. For HTTPS, configure SSL certificates. Check Docker daemon allows insecure registries for localhost.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the admin password immediately after first login
- Create separate user accounts with appropriate permissions
- Disable anonymous access if not needed
- Configure HTTPS with valid SSL certificates
- Set up regular automated backups
- Enable audit logging
- Configure firewall rules to restrict access
- Use a proper domain name instead of localhost
- Review and harden security settings
- Keep Nexus updated to the latest version
- Implement cleanup policies to manage disk space
- Use strong passwords for all accounts

## Resources

- [Nexus Repository Manager Documentation](https://help.sonatype.com/repomanager3)
- [Docker Hub](https://hub.docker.com/r/sonatype/nexus3)
- [REST API Documentation](https://help.sonatype.com/repomanager3/integrations/rest-and-integration-api)
- [Repository Management Best Practices](https://help.sonatype.com/repomanager3/planning-your-implementation)
