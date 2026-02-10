# Design Document: Docker Compose Services Expansion

## Overview

This design document outlines the implementation approach for adding 80+ new Docker Compose service configurations to the existing docker-compose-collection repository. The expansion maintains consistency with existing patterns while introducing new service categories and comprehensive documentation.

**Implementation Status**: Task 21 has been completed, successfully implementing 27 services across 13 new categories (finance, notes, automation, notifications, diagrams, spreadsheets, home, inventory, media, utilities, dashboards, network, and tools). All services follow the established patterns with Docker Compose configurations, comprehensive README documentation, and .env.example files for configuration management.

The implementation follows a systematic approach:
1. Analyze existing patterns and conventions ✅
2. Create category directories following the established structure ✅
3. Generate Docker Compose YAML files with proper configuration ✅
4. Create comprehensive README documentation for each service ✅
5. Create .env.example files with all configurable variables ✅
6. Ensure all configurations follow security and best practices ✅
7. Document port mappings and conflict resolution strategies ✅

### Key Design Principles

- **Consistency**: All new services follow existing naming conventions and file structures
- **Documentation**: Every service includes comprehensive setup and usage documentation
- **Security**: Default credentials are documented with security warnings
- **Modularity**: Services are self-contained with clear dependencies
- **Maintainability**: Configurations use environment variables for easy customization
- **Port Management**: Services use official/standard ports with clear conflict resolution via .env files
- **Configuration Management**: All services include .env.example files with commented variables for centralized configuration

## Architecture

### Directory Structure

The repository follows a category-based organization where services are grouped by their primary function:

```
docker-compose-collection/
├── data-streaming/          # Message queues and event streaming
│   ├── Kafka/
│   ├── RabbitMQ/
│   ├── NATS/
│   └── Pulsar/
├── databases/               # All database systems
│   ├── Postgresql/
│   ├── InfluxDB/
│   ├── Neo4j/
│   ├── MariaDB/
│   └── Typesense/
├── analytics/               # Business intelligence and data analytics
│   ├── Metabase/
│   ├── Superset/
│   ├── Redash/
│   └── Jupyter/
├── devops/                  # CI/CD and DevOps platforms
│   ├── GitLab/
│   ├── Gitea/
│   ├── Nexus/
│   └── Flyway/
├── collaboration/           # Project management and team tools
│   ├── Redmine/
│   ├── Mattermost/
│   ├── Plane/
│   ├── Focalboard/
│   ├── Vikunja/
│   ├── Taiga/
│   ├── Wekan/
│   ├── CryptPad/
│   └── Etherpad/
├── testing/                 # API testing and mocking
│   ├── WireMock/
│   ├── MockServer/
│   ├── SwaggerEditor/
│   └── Hoppscotch/
├── monitoring/              # Monitoring and alerting (existing)
│   ├── Grafana/
│   ├── Prometheus/
│   ├── UptimeKuma/
│   └── Healthchecks/
├── logging/                 # Log aggregation (existing)
│   ├── SeqLog/
│   ├── ELK/
│   └── Loki/
├── orchestration/           # Workflow and job scheduling (existing)
│   ├── Airflow/
│   ├── Hangfire/
│   ├── Quartz/
│   └── n8n/
├── documentation/           # Documentation and wikis (existing)
│   ├── Docusaurus/
│   ├── Structurizr/
│   ├── Outline/
│   ├── AppFlowy/
│   ├── BookStack/
│   ├── WikiJS/
│   ├── HedgeDoc/
│   ├── Typemill/
│   └── Gollum/
├── document-management/     # Document processing
│   ├── PaperlessNgx/
│   ├── StirlingPDF/
│   ├── Docspell/
│   └── OnlyOfficeDocs/
├── storage/                 # File storage and sync
│   ├── Nextcloud/
│   ├── FileBrowser/
│   ├── Syncthing/
│   ├── Seafile/
│   └── PairDrop/
├── content/                 # Reading and content management
│   ├── CalibreWeb/
│   ├── Kavita/
│   ├── Wallabag/
│   └── Miniflux/
├── bookmarks/               # Bookmark management
│   ├── LinkAce/
│   ├── Shiori/
│   └── ArchiveBox/
├── productivity/            # Calendar and contacts
│   ├── Radicale/
│   └── Baikal/
├── mail/                    # Email servers
│   ├── Mailpit/
│   ├── PostfixMail/
│   └── Mailhog/
├── development/             # Development environments
│   ├── Coder/
│   └── Ollama/
├── finance/                 # Personal finance
│   ├── FireflyIII/
│   └── ActualBudget/
├── notes/                   # Note-taking applications
│   ├── JoplinServer/
│   ├── TriliumNotes/
│   ├── Memos/
│   └── StandardNotes/
├── automation/              # Web monitoring and automation
│   ├── Changedetection/
│   └── Huginn/
├── notifications/           # Notification services
│   ├── Gotify/
│   └── AppriseAPI/
├── diagrams/                # Diagramming tools
│   ├── Drawio/
│   └── Excalidraw/
├── spreadsheets/            # Spreadsheet and database tools
│   ├── Grist/
│   └── Baserow/
├── home/                    # Home management
│   ├── TandoorRecipes/
│   ├── Grocy/
│   └── Homebox/
├── inventory/               # Asset management
│   └── SnipeIT/
├── media/                   # Media management
│   ├── Immich/
│   ├── PhotoPrism/
│   ├── Audiobookshelf/
│   └── Navidrome/
├── utilities/               # Encoding and crypto tools
│   ├── ITTools/
│   └── CyberChef/
├── dashboards/              # Service dashboards
│   └── Homepage/
├── network/                 # Network monitoring
│   └── SpeedtestTracker/
├── tools/                   # General tools (existing)
│   ├── Portainer/
│   ├── Dozzle/
│   └── ...
├── automotive/              # Vehicle maintenance
│   └── LubeLogger/
└── security/                # Security and identity (existing)
    └── Keycloak/
```

### Category Decision Logic

Services are categorized based on their primary function:

1. **Existing Categories**: Services that fit existing categories are added there
   - Databases → `databases/`
   - Monitoring tools → `monitoring/`
   - Logging tools → `logging/`
   - Documentation → `documentation/`

2. **New Categories**: Services requiring new categories get dedicated directories
   - Analytics tools → `analytics/`
   - Collaboration tools → `collaboration/`
   - Media management → `media/`

3. **Multi-Purpose Services**: Services with multiple functions are placed in their primary category
   - OnlyOffice Workspace → `document-management/` (primary: document editing)
   - Mattermost → `collaboration/` (primary: team communication)

## Components and Interfaces

### Service Directory Structure

Each service directory contains:

```
category/ServiceName/
├── service-name.yaml      # Docker Compose configuration
├── README.md              # Service documentation
├── .env.example           # Environment variable template with comments
└── config/                # Optional: service-specific config files
```

All services created in Task 21 follow this structure, with comprehensive .env.example files that include:
- Port configuration variables
- Database credentials
- Application secrets and keys
- Timezone settings
- Service-specific feature flags
- Comments explaining each variable's purpose

### Docker Compose File Structure

Each service follows a standardized Docker Compose file structure with environment variable support:

```yaml
version: "3.9"

services:
  service-name:
    image: official/image:tag
    container_name: service-name_container
    restart: unless-stopped
    ports:
      - "${SERVICE_PORT:-8080}:container_port"
    environment:
      - ENV_VAR=${ENV_VAR:-default_value}
      - PASSWORD=${PASSWORD:-P@ss0rd123}
    volumes:
      - service-data:/path/to/data
    healthcheck:
      test: ["CMD", "health-check-command"]
      interval: 30s
      timeout: 10s
      retries: 3
    depends_on:
      - dependency-service

  # Additional services (databases, admin UIs, etc.)
  dependency-service:
    image: dependency/image:tag
    container_name: dependency_container
    restart: unless-stopped
    environment:
      - CONFIG=${CONFIG:-value}
    volumes:
      - dependency-data:/path/to/data

volumes:
  service-data:
  dependency-data:

networks:
  default:
    name: service-network
```

### Environment File Structure (.env.example)

Each service includes a `.env.example` file with all configurable options:

```bash
# Service Name Configuration

# Port Configuration
SERVICE_PORT=8080

# Timezone
TZ=UTC

# Application Configuration
APP_KEY=changeme_secret_key
APP_URL=http://localhost:8080

# Database Configuration
DB_HOST=service-db
DB_PORT=5432
DB_DATABASE=service
DB_USERNAME=service
DB_PASSWORD=P@ss0rd123

# Database Container Configuration
POSTGRES_USER=service
POSTGRES_PASSWORD=P@ss0rd123
POSTGRES_DB=service

# Additional Service-Specific Settings
FEATURE_ENABLED=true
MAX_UPLOAD_SIZE=100M
```

### README Documentation Structure

Each service README follows this template:

```markdown
# Service Name

Brief description of what the service does and its primary use case.

**Official Sites:**
- [Service Name](https://official-site.com/) | [Docker Hub](https://hub.docker.com/r/org/image)

## Quick Start

\`\`\`bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f service-name.yaml up -d
\`\`\`

## Services

### Main Service
- **URL**: http://localhost:PORT
- **Container**: `service-name_container`
- **Username**: `admin`
- **Password**: `P@ss0rd123`

### Database (if applicable)
- **Port**: PORT
- **Container**: `database_container`
- **Username**: `dbuser`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Generate secure secrets if required
3. Start the service with `docker compose -f service-name.yaml up -d`
4. Navigate to http://localhost:PORT
5. Complete initial setup

## Configuration

### Environment Variables (.env)

- `SERVICE_PORT` - Web interface port (default: PORT)
- `VAR_NAME` - Description and default value
- `DB_PASSWORD` - Database password (change for production)

### Custom Configuration
Instructions for advanced configuration

## Connecting to Service

### From Host Machine
Instructions for accessing from the host

### From Application
Connection string examples

## Volumes

- `service-data` - Description of what's stored
- `database-data` - Database files

## Common Tasks

### Task 1
\`\`\`bash
docker exec service-name_container command
\`\`\`

### Task 2
Instructions for common operations

## Troubleshooting

### Common Issue 1
- Symptoms
- Solution

### Common Issue 2
- Symptoms
- Solution

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate secure secrets/keys
- Change all default passwords
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential

## Resources

- [Official Documentation](https://docs.official-site.com/)
- [Docker Hub](https://hub.docker.com/r/org/image)
```

## Port Management Strategy

### Port Assignment Rules

1. **Official Ports First**: Use the service's official/standard port when available
2. **Avoid Conflicts**: Assign unique ports when multiple services share the same default
3. **Configurable**: All ports must be configurable via environment variables
4. **Documented**: Maintain a port mapping document for all services

### Port Mapping Document

A comprehensive `PORT_MAPPING.md` document lists:
- All services and their assigned ports
- Port conflict identification
- Recommended alternative ports
- Database ports (internal only)
- Configuration instructions

### Example Port Assignments

```yaml
# Service with official port
ports:
  - "${SERVICE_PORT:-2342}:2342"  # PhotoPrism official port

# Service with common port (8080)
ports:
  - "${SERVICE_PORT:-8080}:80"    # Configurable to avoid conflicts

# Service with multiple ports
ports:
  - "${HTTP_PORT:-8080}:80"
  - "${HTTPS_PORT:-8443}:443"
```

### Port Conflict Resolution

When multiple services use port 8080:
1. First service keeps 8080
2. Subsequent services get unique ports (8081, 8082, etc.)
3. All documented in PORT_MAPPING.md
4. Users can customize via .env files

### Port Mapping Document Structure

The repository includes a comprehensive PORT_MAPPING.md document (created in Task 21) that provides:

**Service Port Listings**:
- Complete table of all services with their assigned ports
- Protocol information (HTTP/HTTPS)
- Notes on whether ports are official/standard or assigned

**Port Conflict Identification**:
- Lists all services using common ports (8080, 3000, 8000)
- Identifies potential conflicts when running multiple services
- Provides recommended alternative port assignments

**Configuration Guidance**:
- Instructions for using .env files to customize ports
- Examples of port configuration for conflict resolution
- Database port documentation (internal-only ports)

**Example Port Conflict Resolution**:
```bash
# Services using port 8080 by default:
# - Firefly III, Trilium Notes, Gotify, Draw.io, Tandoor Recipes,
#   Snipe-IT, IT Tools, Speedtest Tracker, Dozzle

# Recommended assignments when running multiple services:
Firefly III: 8081
Trilium Notes: 8082
Gotify: 8083
Draw.io: 8084
Tandoor Recipes: 8085
Snipe-IT: 8086
IT Tools: 8087
Speedtest Tracker: 8088
Dozzle: 8089
```

This document satisfies Requirements 7.7, 7.8, and 7.9 by providing a centralized reference for all port assignments and conflict resolution strategies.

## Configuration Management Strategy

### Environment Variable Usage

All configuration must be externalized:

```yaml
# In docker-compose.yaml
environment:
  - PORT=${SERVICE_PORT:-8080}
  - DB_PASSWORD=${DB_PASSWORD:-P@ss0rd123}
  - SECRET_KEY=${SECRET_KEY:-changeme}
```

### .env File Structure

Each service provides `.env.example`:

```bash
# Required Configuration
SERVICE_PORT=8080
DB_PASSWORD=P@ss0rd123

# Optional Configuration
# FEATURE_ENABLED=true
# MAX_CONNECTIONS=100
```

### Configuration Workflow

1. User copies `.env.example` to `.env`
2. User edits `.env` with custom values
3. Docker Compose reads `.env` automatically
4. Service starts with custom configuration

## Data Models

### Service Configuration Model

Each service configuration consists of:

```typescript
interface ServiceConfiguration {
  // Directory structure
  categoryPath: string;           // e.g., "analytics/"
  serviceName: string;            // e.g., "Metabase"
  
  // Docker Compose configuration
  composeFile: {
    version: string;              // "3.9"
    services: ServiceDefinition[];
    volumes: VolumeDefinition[];
    networks?: NetworkDefinition[];
  };
  
  // Environment configuration
  envFile: {
    portConfig: PortConfig;
    appConfig: Record<string, string>;
    dbConfig?: DatabaseConfig;
    secrets?: Record<string, string>;
  };
  
  // Documentation
  readme: {
    serviceName: string;
    description: string;
    officialSite: string;
    dockerHub: string;
    quickStart: string;
    services: ServiceInfo[];
    volumes: VolumeInfo[];
    configuration: ConfigInfo[];
    commonTasks: Task[];
    troubleshooting: Issue[];
  };
}

interface PortConfig {
  primary: number;                // Main service port
  secondary?: number[];           // Additional ports (HTTPS, etc.)
  isStandard: boolean;            // Uses official/standard port
  conflicts?: string[];           // Services with same port
}

interface ServiceDefinition {
  name: string;
  image: string;
  containerName: string;
  restart: "always" | "unless-stopped";
  ports: string[];                // ["${PORT:-8080}:80"]
  environment: Record<string, string>;  // Uses ${VAR:-default}
  volumes: string[];              // ["vol-name:/path"]
  healthcheck?: HealthCheck;
  dependsOn?: string[];
}

interface VolumeDefinition {
  name: string;
  driver?: string;
  driverOpts?: Record<string, string>;
}

interface HealthCheck {
  test: string[];
  interval: string;
  timeout: string;
  retries: number;
}

interface ServiceInfo {
  name: string;
  url?: string;
  port?: number;
  container: string;
  credentials?: {
    username: string;
    password: string;
  };
}
```

### Service Categories Mapping

```typescript
const categoryMappings: Record<string, string[]> = {
  "data-streaming": ["RabbitMQ", "NATS", "Pulsar"],
  "databases": ["InfluxDB", "Neo4j", "MariaDB", "Typesense"],
  "analytics": ["Metabase", "Superset", "Redash", "Jupyter"],
  "devops": ["GitLab", "Gitea", "Nexus", "Flyway"],
  "collaboration": ["Redmine", "Mattermost", "Plane", "Focalboard", "Vikunja", 
                    "Taiga", "Wekan", "CryptPad", "Etherpad"],
  "testing": ["WireMock", "MockServer", "SwaggerEditor", "Hoppscotch"],
  "monitoring": ["UptimeKuma", "Healthchecks"],
  "logging": ["ELK", "Loki"],
  "orchestration": ["Hangfire", "Quartz", "n8n"],
  "documentation": ["Outline", "AppFlowy", "BookStack", "WikiJS", "HedgeDoc", 
                    "Typemill", "Gollum"],
  "document-management": ["PaperlessNgx", "StirlingPDF", "Docspell", "OnlyOfficeDocs"],
  "storage": ["Nextcloud", "FileBrowser", "Syncthing", "Seafile", "PairDrop"],
  "content": ["CalibreWeb", "Kavita", "Wallabag", "Miniflux"],
  "bookmarks": ["LinkAce", "Shiori", "ArchiveBox"],
  "productivity": ["Radicale", "Baikal"],
  "mail": ["Mailpit", "PostfixMail", "Mailhog"],
  "development": ["Coder", "Ollama"],
  "finance": ["FireflyIII", "ActualBudget"],
  "notes": ["JoplinServer", "TriliumNotes", "Memos", "StandardNotes"],
  "automation": ["Changedetection", "Huginn"],
  "notifications": ["Gotify", "AppriseAPI"],
  "diagrams": ["Drawio", "Excalidraw"],
  "spreadsheets": ["Grist", "Baserow"],
  "home": ["TandoorRecipes", "Grocy", "Homebox"],
  "inventory": ["SnipeIT"],
  "media": ["Immich", "PhotoPrism", "Audiobookshelf", "Navidrome"],
  "utilities": ["ITTools", "CyberChef"],
  "dashboards": ["Homepage"],
  "network": ["SpeedtestTracker"],
  "tools": ["Dozzle"],
  "automotive": ["LubeLogger"]
};
```

**Implementation Status**: All services listed above have been implemented in Task 21, with complete Docker Compose configurations, README documentation, and .env.example files. New services (UptimeKuma, PairDrop, LubeLogger) are pending implementation.

### Service-Specific Configuration Patterns

Different service types require specific configuration patterns. The following patterns have been implemented across all Task 21 services:

#### Pattern 1: Simple Web Service
```yaml
services:
  service:
    image: org/service:latest
    container_name: service_container
    restart: unless-stopped
    ports:
      - "${SERVICE_PORT:-8080}:80"
    volumes:
      - service-data:/data
    environment:
      - TZ=${TZ:-UTC}
```

**Implemented Examples**: IT Tools, CyberChef, Excalidraw, Dozzle

#### Pattern 2: Service with Database
```yaml
services:
  app:
    image: org/app:latest
    container_name: app_container
    restart: unless-stopped
    ports:
      - "${APP_PORT:-8080}:80"
    environment:
      - DB_HOST=database
      - DB_USER=${DB_USER:-appuser}
      - DB_PASSWORD=${DB_PASSWORD:-P@ss0rd123}
      - TZ=${TZ:-UTC}
    depends_on:
      - database
    volumes:
      - app-data:/data
  
  database:
    image: postgres:15
    container_name: app_database
    restart: unless-stopped
    environment:
      - POSTGRES_USER=${DB_USER:-appuser}
      - POSTGRES_PASSWORD=${DB_PASSWORD:-P@ss0rd123}
      - POSTGRES_DB=${DB_NAME:-appdb}
    volumes:
      - db-data:/var/lib/postgresql/data
```

**Implemented Examples**: 
- PostgreSQL backends: Firefly III, Joplin Server, Huginn, Grist, Tandoor Recipes, Immich, Speedtest Tracker
- MySQL/MariaDB backends: Standard Notes, Snipe-IT, PhotoPrism, Baserow

#### Pattern 3: Service with Multiple Databases (Redis + SQL)
```yaml
services:
  app:
    image: org/app:latest
    container_name: app_container
    restart: unless-stopped
    ports:
      - "${APP_PORT:-8080}:80"
    environment:
      - DB_HOST=postgres
      - REDIS_HOST=redis
      - DB_PASSWORD=${DB_PASSWORD:-P@ss0rd123}
    depends_on:
      - postgres
      - redis
    volumes:
      - app-data:/data
  
  postgres:
    image: postgres:15
    container_name: app_postgres
    restart: unless-stopped
    environment:
      - POSTGRES_PASSWORD=${DB_PASSWORD:-P@ss0rd123}
    volumes:
      - postgres-data:/var/lib/postgresql/data
  
  redis:
    image: redis:7-alpine
    container_name: app_redis
    restart: unless-stopped
    volumes:
      - redis-data:/data
```

**Implemented Examples**: Standard Notes, Huginn, Baserow, Immich, PhotoPrism

#### Pattern 4: Multi-Container Stack (ELK)
```yaml
services:
  elasticsearch:
    image: elasticsearch:8.x
    container_name: elasticsearch
    environment:
      - discovery.type=single-node
    volumes:
      - es-data:/usr/share/elasticsearch/data
  
  logstash:
    image: logstash:8.x
    container_name: logstash
    depends_on:
      - elasticsearch
    volumes:
      - ./logstash.conf:/usr/share/logstash/pipeline/logstash.conf
  
  kibana:
    image: kibana:8.x
    container_name: kibana
    ports:
      - "${KIBANA_PORT:-5601}:5601"
    depends_on:
      - elasticsearch
```

#### Pattern 5: Docker Management (Socket Mount)
```yaml
services:
  docker-tool:
    image: org/docker-tool:latest
    container_name: docker_tool
    restart: unless-stopped
    ports:
      - "${TOOL_PORT:-8080}:8080"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    environment:
      - TZ=${TZ:-UTC}
```

**Implemented Example**: Dozzle (Docker log viewer with socket mount for container access)

#### Pattern 6: Media Management (Large Volume Mounts)
```yaml
services:
  media-app:
    image: org/media-app:latest
    container_name: media_app
    restart: unless-stopped
    ports:
      - "${APP_PORT:-2342}:2342"
    environment:
      - UPLOAD_NSFW=${UPLOAD_NSFW:-false}
      - TZ=${TZ:-UTC}
    volumes:
      - media-config:/config
      - ${MEDIA_PATH:-./media}:/media
      - media-import:/import
```

**Implemented Examples**: Immich, PhotoPrism, Audiobookshelf, Navidrome (all with media library volume mounts)

### Task 21 Implementation Patterns

The following patterns were consistently applied across all 27 services implemented in Task 21:

#### Environment Variable Pattern
All services use the `${VAR_NAME:-default_value}` syntax for environment variables:
```yaml
ports:
  - "${SERVICE_PORT:-8080}:80"
environment:
  - DB_PASSWORD=${DB_PASSWORD:-P@ss0rd123}
  - TZ=${TZ:-UTC}
```

#### .env.example Structure
All services include comprehensive .env.example files with:
- Header comment identifying the service
- Port configuration section
- Timezone configuration
- Application-specific settings
- Database credentials (when applicable)
- Comments explaining each variable

Example from Firefly III:
```bash
# Firefly III Configuration

# Port Configuration
FIREFLY_PORT=8080

# Timezone
TZ=UTC

# Application Configuration
APP_KEY=changeme_32_character_secret_key
APP_URL=http://localhost:8080

# Database Configuration
DB_HOST=firefly-db
DB_PORT=5432
DB_DATABASE=firefly
DB_USERNAME=firefly
DB_PASSWORD=P@ss0rd123
```

#### README Structure
All 27 services follow the standardized README template with:
1. Service name and description
2. Official links (website and Docker Hub)
3. Quick Start section with .env instructions
4. Services section (containers, ports, credentials)
5. Initial Setup steps
6. Configuration section (environment variables)
7. Volumes section
8. Common Tasks (service-specific)
9. Features list (service-specific)
10. Security Notes (production warnings)
11. Resources (documentation links)

#### Service-Specific Implementations

**Finance Services** (Firefly III, Actual Budget):
- PostgreSQL database backend (Firefly III)
- SQLite for simpler setup (Actual Budget)
- Initial setup documentation for account creation
- Budget management features documented

**Note-Taking Services** (Joplin, Trilium, Memos, Standard Notes):
- Sync server components (Joplin)
- Database backends for data persistence
- Encryption features documented (Standard Notes)
- Import/export capabilities documented

**Automation Services** (Changedetection, Huginn):
- Web monitoring target configuration documented
- Notification integration examples
- Scheduling configuration

**Notification Services** (Gotify, Apprise API):
- API endpoint documentation
- Integration examples for multiple platforms
- Token/authentication setup

**Media Services** (Immich, PhotoPrism, Audiobookshelf, Navidrome):
- Large volume mounts for media libraries
- Import/scanning process documentation
- AI features documented (PhotoPrism, Immich)
- Mobile app availability noted

**Docker Management** (Dozzle):
- Docker socket mount for container access
- Real-time log viewing capabilities
- Multi-host support documented

## Correctness Properties

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Service Directory Organization

*For any* service configuration, the service directory should be placed in the correct category directory based on the service type, with the directory name in PascalCase matching the service name.

**Validates: Requirements 1.1, 1.3, 1.4, 1.5**

### Property 2: Category Directory Creation

*For any* service being added to a non-existent category, the system should create the category directory following the lowercase-with-hyphens naming convention.

**Validates: Requirements 1.2**

### Property 3: Compose File Naming Convention

*For any* generated Docker Compose file, the filename should follow the pattern `{service-name}.yaml` in lowercase with hyphens.

**Validates: Requirements 2.1**

### Property 4: Compose File Structure Completeness

*For any* Docker Compose file, it should include a version declaration (3.9 or compatible), and all service definitions should include container_name, restart policy (always or unless-stopped), and use official Docker images when available.

**Validates: Requirements 2.2, 2.3, 2.4, 2.10**

### Property 5: Volume Configuration Consistency

*For any* service that stores persistent data, the compose file should define named volumes following the pattern `{service}-data`, and services sharing data should use the same named volume.

**Validates: Requirements 2.5, 5.1, 5.2, 5.5**

### Property 6: Port Mapping Format

*For any* service exposing ports, the compose file should use explicit port mappings in the format "host_port:container_port".

**Validates: Requirements 2.6, 7.4**

### Property 7: Environment Variable Usage

*For any* service requiring configuration or credentials, the compose file should use environment variables rather than hardcoded values.

**Validates: Requirements 2.7, 4.1, 4.3, 4.5**

### Property 8: Service Dependency Declaration

*For any* service with dependencies, the compose file should use depends_on to define the startup order.

**Validates: Requirements 2.8, 8.3**

### Property 9: Health Check Configuration

*For any* service that supports health checks, the compose file should include healthcheck configuration with test command, interval, timeout, and retries.

**Validates: Requirements 2.9, 10.1**

### Property 10: README File Presence

*For any* service configuration, a README.md file should exist in the service directory.

**Validates: Requirements 3.1**

### Property 11: README Structure Completeness

*For any* README file, it should include the service name as the main heading, a description, links to official sites and Docker Hub, a Quick Start section with the docker compose command, a Services section listing containers, and a Volumes section describing persistent data.

**Validates: Requirements 3.2, 3.3, 3.4, 3.5, 3.8, 3.9**

### Property 12: Web Service Documentation

*For any* service with a web interface, the README should document the access URL and default port.

**Validates: Requirements 3.6**

### Property 13: Authentication Documentation

*For any* service requiring authentication, the README should document default credentials.

**Validates: Requirements 3.7**

### Property 14: Configuration Documentation

*For any* service supporting custom configuration, the README should document environment variables in a Configuration section.

**Validates: Requirements 3.11, 4.4**

### Property 15: Password Strength and Consistency

*For any* service requiring credentials, default passwords should follow the pattern P@ss0rd123 or P@ssw0rd@123 (minimum 8 characters with mixed case and numbers).

**Validates: Requirements 4.2, 11.2**

### Property 16: Volume Documentation Completeness

*For any* service with multiple volumes, the README should document each volume's purpose.

**Validates: Requirements 5.3**

### Property 17: Service Bundling in Compose Files

*For any* service requiring a database or admin UI, those components should be included in the same compose file.

**Validates: Requirements 6.1, 8.1, 8.2**

### Property 18: Container Name Usage for Communication

*For any* services that need to communicate, connection strings should use container names rather than IP addresses.

**Validates: Requirements 6.2**

### Property 19: Network Configuration Documentation

*For any* service using custom networks, the networks should be explicitly defined in the compose file and documented in the README.

**Validates: Requirements 6.3, 6.4**

### Property 20: Port Documentation Consistency

*For any* service, all exposed ports in the compose file should be documented in the README Services section.

**Validates: Requirements 7.3**

### Property 21: Standard Port Usage

*For any* service, the configuration should use standard ports where possible, and when conflicts occur, alternative ports should be clearly documented.

**Validates: Requirements 7.1, 7.2**

### Property 22: Multi-Service Bundle Documentation

*For any* compose file with multiple services, all services should be documented in the README.

**Validates: Requirements 8.4**

### Property 23: Main README Integration

*For any* new service added, the main repository README.md should be updated with a link to the service, organized by category, including service name, brief description, and official site link.

**Validates: Requirements 9.1, 9.2, 9.3**

### Property 24: Category Ordering in Main README

*For any* category in the main README, services within that category should be in alphabetical or logical order.

**Validates: Requirements 9.4**

### Property 25: Health Check Documentation

*For any* service with health check configuration, the README should document the health check behavior.

**Validates: Requirements 10.4**

### Property 26: Security Warnings in Documentation

*For any* service with default credentials, the README should include warnings that credentials are for development only and should be changed for production use.

**Validates: Requirements 11.1, 11.4**

### Property 27: Compose File and README Round-Trip Consistency

*For any* service configuration, parsing the compose file then generating README documentation then extracting configuration details should produce values equivalent to the original compose file (service names, ports, volumes, environment variables should match).

**Validates: Requirements 2.1-2.10, 3.1-3.11**

### Property 28: Environment File Completeness and Documentation

*For any* service configuration, the .env.example file should contain all environment variables referenced in the compose file, and each variable should have a comment explaining its purpose.

**Validates: Requirements 4.6, 4.8**

### Property 29: Environment Variable Syntax Consistency

*For any* Docker Compose file, all environment variable references should use the ${VAR_NAME:-default_value} syntax to support .env files.

**Validates: Requirements 4.7**

### Property 30: README Environment File Instructions

*For any* service README, it should include instructions to copy .env.example to .env and customize values before starting the service.

**Validates: Requirements 4.9**

### Property 31: Port Configurability via Environment Variables

*For any* service with port mappings in the compose file, those ports should be configurable via environment variables defined in the .env.example file.

**Validates: Requirements 7.6**

### Property 32: Port Conflict Documentation

*For any* set of services with port conflicts (multiple services using the same default port), the port mapping document should provide recommended alternative port assignments.

**Validates: Requirements 7.9**

### Property 33: Finance Service Database Backend

*For any* finance service configuration, the compose file should include a database backend service, and the README should document initial setup steps.

**Validates: Requirements 12.8**

### Property 34: Monitoring Tool Alert Documentation

*For any* monitoring service configuration, the README should document alert configuration and notification setup.

**Validates: Requirements 12.9**

### Property 35: Note-Taking Sync Server Components

*For any* note-taking service that supports synchronization, the compose file should include sync server components.

**Validates: Requirements 12.10**

### Property 36: Web Monitoring Target Documentation

*For any* web monitoring service configuration, the README should document how to add monitoring targets.

**Validates: Requirements 12.11**

### Property 37: Notification Service API Documentation

*For any* notification service configuration, the README should document API endpoints and integration examples.

**Validates: Requirements 12.12**

### Property 38: Diagramming Tool Volume Persistence

*For any* diagramming service configuration, the compose file should mount volumes for diagram persistence.

**Validates: Requirements 12.13**

### Property 39: Spreadsheet Tool Database Backend

*For any* spreadsheet or database tool that requires a backend, the compose file should include the database backend service.

**Validates: Requirements 12.14**

### Property 40: Home Management Setup Documentation

*For any* home management service configuration, the README should document initial setup and configuration steps.

**Validates: Requirements 12.15**

### Property 41: Asset Management Database and User Setup

*For any* asset management service configuration, the compose file should include a database backend, and the README should document user setup.

**Validates: Requirements 12.16**

### Property 42: Media Management Volume and Import Documentation

*For any* media management service configuration, the compose file should mount volumes for media libraries, and the README should document scanning/import processes.

**Validates: Requirements 12.17**

### Property 43: Docker Management Socket Mount

*For any* Docker management service configuration, the compose file should mount the Docker socket (/var/run/docker.sock) for container access.

**Validates: Requirements 12.19**

### Property 44: Dashboard Customization Documentation

*For any* service dashboard configuration, the README should document how to add service links and customize the dashboard.

**Validates: Requirements 12.20**

### Property 45: Network Monitoring Scheduling Documentation

*For any* network monitoring service configuration, the README should document scheduling and data retention settings.

**Validates: Requirements 12.21**

## Error Handling

### File System Errors

**Directory Creation Failures**:
- If a category directory cannot be created due to permissions, the system should fail with a clear error message indicating the path and permission issue
- If a service directory already exists, the system should either skip creation or prompt for overwrite confirmation

**File Write Failures**:
- If compose files or README files cannot be written, the system should fail gracefully and report which files were not created
- Partial writes should be avoided - either all files for a service are created or none are

### Configuration Validation Errors

**Invalid Service Definitions**:
- If a service configuration is missing required fields (image, container_name), the system should reject the configuration with a descriptive error
- If port mappings are invalid or malformed, the system should report the specific port configuration issue

**Volume Configuration Errors**:
- If volume mount paths are invalid or conflict with existing mounts, the system should report the conflict
- If volume names contain invalid characters, the system should reject the configuration

### Documentation Generation Errors

**Missing Required Information**:
- If a service is missing required metadata (official site, description), the system should use placeholder text and log a warning
- If default credentials are not provided for authenticated services, the system should log a warning

**Template Rendering Errors**:
- If README templates fail to render, the system should fall back to a minimal README with basic information
- Template syntax errors should be caught and reported with the specific template and line number

### Docker Compose Validation Errors

**YAML Syntax Errors**:
- Generated YAML files should be validated for syntax correctness before writing
- If YAML generation produces invalid syntax, the system should report the specific syntax issue

**Schema Validation Errors**:
- Compose files should be validated against the Docker Compose schema
- If required fields are missing or have invalid values, the system should report schema validation errors

### Recovery Strategies

**Rollback on Failure**:
- If service creation fails partway through, any created files should be cleaned up
- The system should maintain a transaction-like approach where all files for a service are created atomically

**Validation Before Creation**:
- All service configurations should be validated before any files are written
- Batch operations should validate all services before creating any directories or files

**Logging and Reporting**:
- All errors should be logged with sufficient context (service name, category, specific field)
- Error messages should be actionable, indicating what needs to be fixed

## Testing Strategy

### Dual Testing Approach

This feature requires both unit testing and property-based testing to ensure comprehensive coverage:

**Unit Tests**: Verify specific examples, edge cases, and error conditions
- Test specific service configurations (e.g., RabbitMQ, PostgreSQL, ELK Stack)
- Test edge cases like services with no volumes, services with multiple databases
- Test error conditions like invalid YAML, missing required fields
- Test integration between compose files and README generation

**Property Tests**: Verify universal properties across all inputs
- Test that all generated configurations follow naming conventions
- Test that all compose files have required structure
- Test that all README files have required sections
- Test round-trip consistency between compose files and documentation

Both approaches are complementary and necessary for comprehensive coverage. Unit tests catch concrete bugs in specific configurations, while property tests verify general correctness across all possible service configurations.

### Property-Based Testing Configuration

**Testing Library**: Use a property-based testing library appropriate for the implementation language:
- Python: Hypothesis
- TypeScript/JavaScript: fast-check
- Java: jqwik or QuickCheck
- Go: gopter
- Rust: proptest or quickcheck

**Test Configuration**:
- Each property test should run a minimum of 100 iterations
- Each test should reference its design document property using a comment tag
- Tag format: `Feature: docker-compose-services-expansion, Property {number}: {property_text}`

**Example Property Test Structure** (Python with Hypothesis):

```python
from hypothesis import given, strategies as st
import yaml

@given(st.text(min_size=1))
def test_property_3_compose_file_naming(service_name):
    """
    Feature: docker-compose-services-expansion, Property 3: Compose File Naming Convention
    For any generated Docker Compose file, the filename should follow the pattern {service-name}.yaml
    """
    filename = generate_compose_filename(service_name)
    assert filename.endswith('.yaml')
    assert filename.islower()
    assert ' ' not in filename
    # Verify it uses hyphens for word separation
    assert filename == service_name.lower().replace('_', '-').replace(' ', '-') + '.yaml'

@given(st.builds(ServiceConfig))
def test_property_4_compose_structure(service_config):
    """
    Feature: docker-compose-services-expansion, Property 4: Compose File Structure Completeness
    For any Docker Compose file, it should include version, container_name, and restart policy
    """
    compose_content = generate_compose_file(service_config)
    parsed = yaml.safe_load(compose_content)
    
    assert 'version' in parsed
    assert parsed['version'] in ['3.9', '3.8', '3.7']
    
    for service_name, service_def in parsed['services'].items():
        assert 'container_name' in service_def
        assert 'restart' in service_def
        assert service_def['restart'] in ['always', 'unless-stopped']
```

### Unit Testing Strategy

**Service Configuration Tests**:
- Test generation of specific service types (message queues, databases, web services)
- Verify correct category placement for each service type
- Test multi-service configurations (service + database + admin UI)
- **Validate Task 21 implementations**: Test all 27 implemented services for compliance

**Documentation Tests**:
- Test README generation for services with different characteristics
- Verify all required sections are present
- Test documentation of credentials, ports, and volumes
- **Validate Task 21 READMEs**: Ensure all 27 services have complete documentation

**Configuration File Tests**:
- Test .env.example file generation and completeness
- Verify all compose file variables are present in .env.example
- Test that comments explain each variable
- **Validate Task 21 .env files**: Check all 27 services have properly documented .env.example files

**Integration Tests**:
- Test end-to-end service creation (directory + compose file + README + .env.example)
- Test main README update with new services
- Test batch creation of multiple services
- **Validate Task 21 integration**: Verify all services work together without port conflicts

**Error Handling Tests**:
- Test behavior when directories cannot be created
- Test behavior with invalid service configurations
- Test behavior with missing required fields

### Test Coverage Goals

- 100% coverage of all correctness properties through property-based tests
- 90%+ code coverage through unit tests
- All error paths tested with appropriate error conditions
- All service-specific requirements (12.1-12.21) tested with example services
- **All 27 Task 21 services validated** against requirements and design properties

### Testing Workflow

1. **Validation Tests First**: Run property tests to verify structural correctness
2. **Specific Service Tests**: Run unit tests for specific service configurations
3. **Task 21 Validation**: Run tests against all 27 implemented services to ensure compliance
4. **Integration Tests**: Run end-to-end tests for complete service creation
5. **Error Path Tests**: Run tests for all error conditions and recovery

### Continuous Validation

- All generated files should be validated before committing
- Docker Compose files should be validated with `docker compose config`
- README files should be validated for markdown syntax
- Main README should be validated for broken links
- **Task 21 services**: All 27 services should be validated for YAML syntax, README completeness, and .env.example accuracy
