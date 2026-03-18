# Docker Compose Collection - Port Mapping Reference

This document provides a comprehensive list of all services and their default port assignments. Use this reference to avoid port conflicts when running multiple services.

## Quick Reference Table

| Service | Category | Default Port(s) | Protocol | Configurable Via | Notes |
|---------|----------|-----------------|----------|------------------|-------|
| **Analytics** |
| Metabase | Analytics | 3000 | HTTP | METABASE_PORT | |
| Superset | Analytics | 8088 | HTTP | SUPERSET_PORT | |
| Redash | Analytics | 5000 | HTTP | REDASH_PORT | |
| Jupyter | Analytics | 8888 | HTTP | JUPYTER_PORT | |
| **Automation** |
| Changedetection.io | Automation | 5000 | HTTP | CHANGEDETECTION_PORT | Conflicts with Redash |
| Huginn | Automation | 3000 | HTTP | HUGINN_PORT | Conflicts with Metabase |
| **Automotive** |
| LubeLogger | Automotive | 8080 | HTTP | LUBELOGGER_PORT | Common port - conflicts likely |
| **Bookmarks** |
| LinkAce | Bookmarks | 80 | HTTP | LINKACE_PORT | Standard HTTP port |
| Shiori | Bookmarks | 8080 | HTTP | SHIORI_PORT | Common port - conflicts likely |
| ArchiveBox | Bookmarks | 8000 | HTTP | ARCHIVEBOX_PORT | |
| **Collaboration** |
| Redmine | Collaboration | 3000 | HTTP | REDMINE_PORT | Conflicts with Metabase |
| Mattermost | Collaboration | 8065 | HTTP | MATTERMOST_PORT | |
| Plane | Collaboration | 3000 | HTTP | PLANE_PORT | Conflicts with Metabase |
| Focalboard | Collaboration | 8000 | HTTP | FOCALBOARD_PORT | Conflicts with ArchiveBox |
| Vikunja | Collaboration | 3456 | HTTP | VIKUNJA_PORT | |
| Taiga | Collaboration | 9000 (frontend), 8000 (backend) | HTTP | TAIGA_FRONTEND_PORT, TAIGA_BACKEND_PORT | |
| Wekan | Collaboration | 8080 | HTTP | WEKAN_PORT | Common port - conflicts likely |
| **Content** |
| Calibre-Web | Content | 8083 | HTTP | CALIBRE_PORT | |
| Kavita | Content | 5000 | HTTP | KAVITA_PORT | Conflicts with Redash |
| Wallabag | Content | 8080 | HTTP | WALLABAG_PORT | Common port - conflicts likely |
| Miniflux | Content | 8080 | HTTP | MINIFLUX_PORT | Common port - conflicts likely |
| **Dashboards** |
| Homepage | Dashboards | 3000 | HTTP | HOMEPAGE_PORT | Conflicts with Metabase |
| **Data Streaming** |
| Kafka | Data Streaming | 9092 (Kafka), 9093 (UI) | TCP/HTTP | KAFKA_PORT, KAFKA_UI_PORT | |
| RabbitMQ | Data Streaming | 5672 (AMQP), 15672 (Management) | AMQP/HTTP | RABBITMQ_PORT, RABBITMQ_MANAGEMENT_PORT | |
| NATS | Data Streaming | 4222 (Client), 8222 (Monitoring) | TCP/HTTP | NATS_PORT, NATS_MONITORING_PORT | |
| Pulsar | Data Streaming | 6650 (Broker), 8080 (Admin) | TCP/HTTP | PULSAR_BROKER_PORT, PULSAR_ADMIN_PORT | Conflicts with common 8080 |
| **Databases** |
| PostgreSQL | Database | 5432 | TCP | POSTGRES_PORT | |
| MySQL | Database | 3306 | TCP | MYSQL_PORT | |
| MS SQL Server | Database | 1433 | TCP | MSSQL_PORT | |
| Oracle | Database | 1521 | TCP | ORACLE_PORT | |
| MongoDB | Database | 27017 | TCP | MONGO_PORT | |
| Redis | Database | 6379 | TCP | REDIS_PORT | |
| Elasticsearch | Database | 9200 (HTTP), 9300 (Transport) | HTTP/TCP | ES_HTTP_PORT, ES_TRANSPORT_PORT | |
| MariaDB | Database | 3306 (DB), 8080 (Adminer) | TCP/HTTP | MARIADB_PORT, ADMINER_PORT | Conflicts with common 8080 |
| Neo4j | Database | 7474 (HTTP), 7687 (Bolt) | HTTP/TCP | NEO4J_HTTP_PORT, NEO4J_BOLT_PORT | |
| InfluxDB | Database | 8086 | HTTP | INFLUXDB_PORT | |
| Typesense | Database | 8108 | HTTP | TYPESENSE_PORT | |
| **Development** |
| Coder | Development | 7080 | HTTP | CODER_PORT | |
| Ollama | Development | 11434 | HTTP | OLLAMA_PORT | |
| **DevOps** |
| GitLab | DevOps | 80 (HTTP), 443 (HTTPS), 22 (SSH) | HTTP/HTTPS/SSH | GITLAB_HTTP_PORT, GITLAB_HTTPS_PORT, GITLAB_SSH_PORT | |
| Gitea | DevOps | 3000 (HTTP), 22 (SSH) | HTTP/SSH | GITEA_HTTP_PORT, GITEA_SSH_PORT | Conflicts with Metabase |
| Nexus | DevOps | 8081 | HTTP | NEXUS_PORT | |
| Flyway | DevOps | N/A | N/A | N/A | CLI tool, no exposed ports |
| **Diagrams** |
| Draw.io | Diagrams | 8080 | HTTP | DRAWIO_PORT | Common port - conflicts likely |
| Excalidraw | Diagrams | 80 | HTTP | EXCALIDRAW_PORT | Standard HTTP port |
| **Document Management** |
| Paperless-ngx | Document Mgmt | 8000 | HTTP | PAPERLESS_PORT | Conflicts with ArchiveBox |
| Stirling PDF | Document Mgmt | 8080 | HTTP | STIRLING_PORT | Common port - conflicts likely |
| Docspell | Document Mgmt | 7880 | HTTP | DOCSPELL_PORT | |
| OnlyOffice Docs | Document Mgmt | 8080 (HTTP), 8443 (HTTPS) | HTTP/HTTPS | ONLYOFFICE_PORT, ONLYOFFICE_HTTPS_PORT | Conflicts with common 8080 |
| **Documentation** |
| Docusaurus | Documentation | 3000 | HTTP | DOCUSAURUS_PORT | Conflicts with Metabase |
| Structurizr | Documentation | 8080 | HTTP | STRUCTURIZR_PORT | Common port - conflicts likely |
| Outline | Documentation | 3000 | HTTP | OUTLINE_PORT | Conflicts with Metabase |
| AppFlowy | Documentation | 8080 | HTTP | APPFLOWY_PORT | Common port - conflicts likely |
| BookStack | Documentation | 6875 | HTTP | BOOKSTACK_PORT | |
| Wiki.js | Documentation | 3000 | HTTP | WIKIJS_PORT | Conflicts with Metabase |
| HedgeDoc | Documentation | 3000 | HTTP | HEDGEDOC_PORT | Conflicts with Metabase |
| Typemill | Documentation | 8080 | HTTP | TYPEMILL_PORT | Common port - conflicts likely |
| Gollum | Documentation | 4567 | HTTP | GOLLUM_PORT | |
| **Finance** |
| Firefly III | Finance | 8080 | HTTP | FIREFLY_PORT | Common port - conflicts likely |
| Actual Budget | Finance | 5006 | HTTP | ACTUAL_PORT | |
| **Home** |
| Tandoor Recipes | Home | 8080 | HTTP | TANDOOR_PORT | Common port - conflicts likely |
| Grocy | Home | 8080 | HTTP | GROCY_PORT | Common port - conflicts likely |
| Homebox | Home | 7745 | HTTP | HOMEBOX_PORT | |
| **Inventory** |
| Snipe-IT | Inventory | 8080 | HTTP | SNIPEIT_PORT | Common port - conflicts likely |
| **Logging** |
| Seq | Logging | 5341 (Ingestion), 80 (UI) | HTTP | SEQ_INGESTION_PORT, SEQ_UI_PORT | |
| ELK Stack | Logging | 9200 (ES), 5601 (Kibana), 5044 (Logstash) | HTTP/TCP | ES_PORT, KIBANA_PORT, LOGSTASH_PORT | |
| Loki | Logging | 3100 (Loki), 3000 (Grafana) | HTTP | LOKI_PORT, GRAFANA_PORT | Conflicts with Metabase |
| **Mail** |
| Mailpit | Mail | 1025 (SMTP), 8025 (Web) | SMTP/HTTP | SMTP_PORT, WEB_PORT | |
| Postfix Mail | Mail | 25 (SMTP), 587 (Submission) | SMTP | SMTP_PORT, SUBMISSION_PORT | |
| Mailhog | Mail | 1025 (SMTP), 8025 (Web) | SMTP/HTTP | SMTP_PORT, WEB_PORT | Same as Mailpit |
| **Media** |
| Immich | Media | 2283 | HTTP | IMMICH_PORT | |
| PhotoPrism | Media | 2342 | HTTP | PHOTOPRISM_PORT | |
| Audiobookshelf | Media | 13378 | HTTP | AUDIOBOOKSHELF_PORT | |
| Navidrome | Media | 4533 | HTTP | NAVIDROME_PORT | |
| **Monitoring** |
| Grafana | Monitoring | 3000 | HTTP | GRAFANA_PORT | Conflicts with Metabase |
| Prometheus | Monitoring | 9090 | HTTP | PROMETHEUS_PORT | |
| Uptime Kuma | Monitoring | 3001 | HTTP | UPTIMEKUMA_PORT | |
| **Network** |
| Speedtest Tracker | Network | 8080 | HTTP | SPEEDTEST_PORT | Common port - conflicts likely |
| **Notes** |
| Joplin Server | Notes | 22300 | HTTP | JOPLIN_PORT | |
| Trilium Notes | Notes | 8080 | HTTP | TRILIUM_PORT | Common port - conflicts likely |
| Memos | Notes | 5230 | HTTP | MEMOS_PORT | |
| Standard Notes | Notes | 3000 (Web), 3104 (Sync) | HTTP | STANDARDNOTES_WEB_PORT, STANDARDNOTES_SYNC_PORT | Conflicts with Metabase |
| **Notifications** |
| Gotify | Notifications | 8080 | HTTP | GOTIFY_PORT | Common port - conflicts likely |
| Apprise API | Notifications | 8000 | HTTP | APPRISE_PORT | Conflicts with ArchiveBox |
| Ntfy | Notifications | 80 | HTTP | NTFY_PORT | Standard HTTP port |
| **Orchestration** |
| Airflow | Orchestration | 8080 | HTTP | AIRFLOW_PORT | Common port - conflicts likely |
| Hangfire | Orchestration | 8080 | HTTP | HANGFIRE_PORT | Common port - conflicts likely |
| Quartz | Orchestration | 8080 | HTTP | QUARTZ_PORT | Common port - conflicts likely |
| n8n | Orchestration | 5678 | HTTP | N8N_PORT | |
| **Productivity** |
| Radicale | Productivity | 5232 | HTTP | RADICALE_PORT | |
| Baïkal | Productivity | 80 | HTTP | BAIKAL_PORT | Standard HTTP port |
| **Security** |
| Keycloak | Security | 8080 | HTTP | KEYCLOAK_PORT | Common port - conflicts likely |
| **Spreadsheets** |
| Grist | Spreadsheets | 8484 | HTTP | GRIST_PORT | |
| Baserow | Spreadsheets | 8000 | HTTP | BASEROW_PORT | Conflicts with ArchiveBox |
| **Storage** |
| Nextcloud | Storage | 8080 | HTTP | NEXTCLOUD_PORT | Common port - conflicts likely |
| File Browser | Storage | 8080 | HTTP | FILEBROWSER_PORT | Common port - conflicts likely |
| Syncthing | Storage | 8384 (Web), 22000 (Sync), 21027 (Discovery) | HTTP/TCP/UDP | SYNCTHING_WEB_PORT, SYNCTHING_LISTEN_PORT, SYNCTHING_DISCOVERY_PORT | |
| Seafile | Storage | 80 (HTTP), 443 (HTTPS) | HTTP/HTTPS | SEAFILE_PORT, SEAFILE_HTTPS_PORT | |
| PairDrop | Storage | 3000 | HTTP | PAIRDROP_PORT | Conflicts with Metabase |
| **Testing** |
| Windows Containers | Testing | Varies | Various | N/A | Port mapping depends on use case |
| WireMock | Testing | 8080 | HTTP | WIREMOCK_PORT | Common port - conflicts likely |
| MockServer | Testing | 1080 | HTTP | MOCKSERVER_PORT | |
| Swagger Editor | Testing | 8081 | HTTP | SWAGGER_PORT | |
| Hoppscotch | Testing | 3000 | HTTP | HOPPSCOTCH_PORT | Conflicts with Metabase |
| **Tools** |
| Portainer | Tools | 9000 (HTTP), 8000 (Edge) | HTTP | PORTAINER_HTTP_PORT, PORTAINER_EDGE_PORT | |
| SonarQube | Tools | 9000 | HTTP | SONARQUBE_PORT | Conflicts with Portainer |
| Verdaccio | Tools | 4873 | HTTP | VERDACCIO_PORT | |
| Cloudbeaver | Tools | 8978 | HTTP | CLOUDBEAVER_PORT | |
| SchemaSpy | Tools | 8080 | HTTP | SCHEMASPY_PORT | Common port - conflicts likely |
| Dozzle | Tools | 8080 | HTTP | DOZZLE_PORT | Common port - conflicts likely |
| **Utilities** |
| IT Tools | Utilities | 8080 | HTTP | ITTOOLS_PORT | Common port - conflicts likely |
| CyberChef | Utilities | 8000 | HTTP | CYBERCHEF_PORT | Conflicts with ArchiveBox |

## Port Conflict Groups

### Port 80 (Standard HTTP)
- LinkAce
- Excalidraw
- Seafile
- Baïkal
- Ntfy
- Seq (UI)
- GitLab (HTTP)

**Resolution**: Use environment variables to assign unique ports (8080, 8081, 8082, etc.)

### Port 3000 (Common Development Port)
- Metabase
- Huginn
- Redmine
- Plane
- Homepage
- Gitea
- Docusaurus
- Outline
- Wiki.js
- HedgeDoc
- Loki (Grafana)
- Grafana
- Standard Notes (Web)
- Hoppscotch
- PairDrop

**Resolution**: Assign sequential ports (3000, 3001, 3002, 3003, etc.)

**Recommended Assignments**:
```bash
Metabase: 3000
Grafana: 3001
Uptime Kuma: 3002
Huginn: 3003
Redmine: 3004
Plane: 3005
Homepage: 3006
Gitea: 3007
Docusaurus: 3008
Outline: 3009
Wiki.js: 3010
HedgeDoc: 3011
Standard Notes: 3012
Hoppscotch: 3013
PairDrop: 3014
```

### Port 8080 (Most Common Conflict)
Services using 8080 by default:
- LubeLogger
- Shiori
- Wallabag
- Miniflux
- Pulsar (Admin)
- MariaDB (Adminer)
- Draw.io
- Stirling PDF
- OnlyOffice Docs
- Structurizr
- AppFlowy
- Typemill
- Firefly III
- Tandoor Recipes
- Grocy
- Snipe-IT
- Speedtest Tracker
- Trilium Notes
- Gotify
- Airflow
- Hangfire
- Quartz
- Keycloak
- Nextcloud
- File Browser
- WireMock
- SchemaSpy
- Dozzle
- IT Tools
- Wekan

**Resolution**: This is the most congested port. Strongly recommend using .env files to assign unique ports.

**Recommended Assignments**:
```bash
# Primary services (keep 8080)
Nextcloud: 8080

# Reassign others
Firefly III: 8081
Trilium Notes: 8082
Gotify: 8083
Draw.io: 8084
Tandoor Recipes: 8085
Snipe-IT: 8086
IT Tools: 8087
Speedtest Tracker: 8088
Dozzle: 8089
WireMock: 8090
Stirling PDF: 8091
OnlyOffice Docs: 8092
Wallabag: 8093
Miniflux: 8094
Shiori: 8095
LubeLogger: 8096
Grocy: 8097
File Browser: 8098
Keycloak: 8099
```

### Port 8000
- ArchiveBox
- Focalboard
- Paperless-ngx
- Apprise API
- Baserow
- CyberChef
- Portainer (Edge)
- Taiga (Backend)

**Recommended Assignments**:
```bash
ArchiveBox: 8000
Paperless-ngx: 8001
Focalboard: 8002
Apprise API: 8003
Baserow: 8004
CyberChef: 8005
Taiga Backend: 8006
```

### Port 5000
- Redash
- Changedetection.io
- Kavita

**Recommended Assignments**:
```bash
Redash: 5000
Kavita: 5001
Changedetection.io: 5002
```

## Configuration Guide

### Using .env Files

Each service includes a `.env.example` file. To customize ports:

1. Copy the example file:
   ```bash
   cp .env.example .env
   ```

2. Edit the port variable:
   ```bash
   # Example for Firefly III
   FIREFLY_PORT=8081
   ```

3. Start the service:
   ```bash
   docker compose -f firefly-iii.yaml up -d
   ```

### Checking Port Availability

Before starting a service, check if the port is available:

**Windows (PowerShell)**:
```powershell
Test-NetConnection -ComputerName localhost -Port 8080
```

**Windows (CMD)**:
```cmd
netstat -an | findstr :8080
```

**Linux/macOS**:
```bash
lsof -i :8080
# or
netstat -tuln | grep 8080
```

### Running Multiple Services

When running multiple services, create a custom `.env` file for each with unique ports:

```bash
# Service 1: Nextcloud
NEXTCLOUD_PORT=8080

# Service 2: Firefly III
FIREFLY_PORT=8081

# Service 3: Gotify
GOTIFY_PORT=8083
```

## Database Ports (Internal Only)

These ports are typically not exposed to the host and are used for internal container communication:

| Database | Internal Port | Notes |
|----------|---------------|-------|
| PostgreSQL | 5432 | Used by many services |
| MySQL/MariaDB | 3306 | Used by several services |
| MongoDB | 27017 | Used by Wekan, etc. |
| Redis | 6379 | Used for caching |
| Memcached | 11211 | Used by Seafile |
| Solr | 8983 | Used by Docspell |

## Special Port Considerations

### SMTP Ports
- **Port 25**: Standard SMTP (Postfix)
- **Port 587**: Submission (Postfix)
- **Port 1025**: Testing SMTP (Mailpit, Mailhog)

### SSH Ports
- **Port 22**: Standard SSH (GitLab, Gitea)
- Recommend mapping to alternative ports (2222, 2223) to avoid conflicts with host SSH

### HTTPS Ports
- **Port 443**: Standard HTTPS (GitLab, Seafile, OnlyOffice)
- **Port 8443**: Alternative HTTPS (OnlyOffice)

## Quick Port Assignment Tool

Use this formula to avoid conflicts:
- **Analytics**: 3000-3099
- **Collaboration**: 3100-3199  
- **Development**: 7000-7099
- **Documentation**: 3200-3299
- **Finance**: 8100-8199
- **Media**: 2200-2399
- **Storage**: 8200-8299
- **Testing**: 8300-8399
- **Utilities**: 8400-8499

## Notes

1. **All ports are configurable** via environment variables in `.env` files
2. **Default ports** are shown for reference - customize as needed
3. **Port conflicts** are common with 8080, 3000, and 8000
4. **Database ports** are typically internal and not exposed to host
5. **Production deployments** should use reverse proxies (nginx, Traefik) with SSL/TLS

## See Also

- Individual service README files for detailed port configuration
- `.env.example` files in each service directory
- Main README.md for service overview
