# Docker Compose Collection

A collection of Docker Compose for quickly spinning up development environments for various databases, tools, and services.

## 🚀 Quick Start

1. Clone this repository
2. Navigate to the service directory you need
3. Run `docker-compose up -d` (or `docker compose up -d` for Docker Compose V2)
4. Access the service using the credentials and ports specified in each section

## 📦 Available Services

### Docker Management Tools
- **[Portainer](./tools/Portainer/)** - Docker management UI
  - [Official Site](https://www.portainer.io/)

### Databases

#### Relational Databases
- **[PostgreSQL](./databases/Postgresql/)** - Open-source relational database with pgAdmin
  - [PostgreSQL](https://www.postgresql.org/) | [pgAdmin](https://www.pgadmin.org/)
  
- **[MySQL](./databases/MySql/)** - Popular open-source relational database
  - [Official Site](https://www.mysql.com/)
  
- **[MS SQL Server](./databases/MsSql/)** - Microsoft SQL Server (Express, Developer, and Windows editions)
  - [Official Site](https://www.microsoft.com/en-us/sql-server)

- **[Oracle](./databases/Oracle/)** - Oracle Database
  - [Official Site](https://www.oracle.com/database/)

- **[MariaDB](./databases/MariaDB/)** - MySQL-compatible relational database with Adminer
  - [Official Site](https://mariadb.org/)

#### NoSQL Databases
- **[MongoDB](./databases/Mongodb/)** - Document-oriented NoSQL database
  - [Official Site](https://www.mongodb.com/)
  
- **[Redis](./databases/Redis/)** - In-memory data structure store
  - [Official Site](https://redis.io/)
  
- **[Elasticsearch](./databases/Elasticsearch/)** - Distributed search and analytics engine
  - [Official Site](https://www.elastic.co/elasticsearch/)

- **[Neo4j](./databases/Neo4j/)** - Graph database for connected data
  - [Official Site](https://neo4j.com/)

#### Time Series & Search
- **[InfluxDB](./databases/InfluxDB/)** - Time series database
  - [Official Site](https://www.influxdata.com/)

- **[Typesense](./databases/Typesense/)** - Fast, typo-tolerant search engine
  - [Official Site](https://typesense.org/)

### Data Processing & Streaming
- **[Apache Kafka](./data-streaming/Kafka/)** - Distributed event streaming platform with UI
  - [Official Site](https://kafka.apache.org/)

- **[RabbitMQ](./data-streaming/RabbitMQ/)** - Message broker with management UI
  - [Official Site](https://www.rabbitmq.com/)

- **[NATS](./data-streaming/NATS/)** - Cloud-native messaging system
  - [Official Site](https://nats.io/)

- **[Apache Pulsar](./data-streaming/Pulsar/)** - Distributed messaging and streaming platform
  - [Official Site](https://pulsar.apache.org/)
  
- **[Apache Airflow](./orchestration/Airflow/)** - Workflow orchestration platform
  - [Official Site](https://airflow.apache.org/)

### Analytics & Business Intelligence
- **[Metabase](./analytics/Metabase/)** - Business intelligence and analytics
  - [Official Site](https://www.metabase.com/)

- **[Apache Superset](./analytics/Superset/)** - Data exploration and visualization
  - [Official Site](https://superset.apache.org/)

- **[Redash](./analytics/Redash/)** - Data visualization and dashboards
  - [Official Site](https://redash.io/)

- **[Jupyter Notebook](./analytics/Jupyter/)** - Interactive computing and data science
  - [Official Site](https://jupyter.org/)

### Monitoring & Observability
- **[Grafana](./monitoring/Grafana/)** - Analytics and monitoring platform
  - [Official Site](https://grafana.com/)
  
- **[Prometheus](./monitoring/Prometheus/)** - Monitoring system and time series database
  - [Official Site](https://prometheus.io/)

- **[Uptime Kuma](./monitoring/UptimeKuma/)** - Self-hosted uptime monitoring
  - [Official Site](https://uptime.kuma.pet/)
  
- **[Seq](./logging/SeqLog/)** - Structured log server
  - [Official Site](https://datalust.co/seq)

- **[ELK Stack](./logging/ELK/)** - Elasticsearch, Logstash, and Kibana for log management
  - [Official Site](https://www.elastic.co/elastic-stack)

- **[Loki](./logging/Loki/)** - Log aggregation system with Grafana
  - [Official Site](https://grafana.com/oss/loki/)

### Development Tools
- **[SonarQube](./tools/Sonarqube/)** - Code quality and security analysis
  - [Official Site](https://www.sonarsource.com/products/sonarqube/)
  
- **[Verdaccio](./tools/Verdaccio/)** - Private npm registry proxy
  - [Official Site](https://verdaccio.org/)
  
- **[Cloudbeaver](./tools/Cloudbeaver/)** - Web-based database management tool
  - [Official Site](https://cloudbeaver.io/)
  
- **[SchemaSpy](./tools/Schemaspy/)** - Database documentation generator
  - [Official Site](https://schemaspy.org/)

- **[Dozzle](./tools/Dozzle/)** - Real-time Docker log viewer
  - [Official Site](https://dozzle.dev/)

- **[Coder](./development/Coder/)** - Self-hosted remote development environments
  - [Official Site](https://coder.com/)

- **[Ollama](./development/Ollama/)** - Run large language models locally
  - [Official Site](https://ollama.ai/)

### DevOps & CI/CD
- **[GitLab](./devops/GitLab/)** - Complete DevOps platform
  - [Official Site](https://about.gitlab.com/)

- **[Gitea](./devops/Gitea/)** - Lightweight Git service
  - [Official Site](https://gitea.io/)

- **[Nexus Repository](./devops/Nexus/)** - Artifact repository manager
  - [Official Site](https://www.sonatype.com/products/nexus-repository)

- **[Flyway](./devops/Flyway/)** - Database migration tool
  - [Official Site](https://flywaydb.org/)

### Documentation & Architecture
- **[Docusaurus](./documentation/Docusaurus/)** - Documentation website generator
  - [Official Site](https://docusaurus.io/)
  
- **[Structurizr](./documentation/Structurizr/)** - Architecture documentation tool
  - [Official Site](https://structurizr.com/)

- **[Outline](./documentation/Outline/)** - Team knowledge base and wiki
  - [Official Site](https://www.getoutline.com/)

- **[AppFlowy](./documentation/AppFlowy/)** - Open-source Notion alternative
  - [Official Site](https://appflowy.io/)

- **[BookStack](./documentation/BookStack/)** - Simple wiki platform
  - [Official Site](https://www.bookstackapp.com/)

- **[Wiki.js](./documentation/WikiJS/)** - Modern wiki application
  - [Official Site](https://js.wiki/)

- **[HedgeDoc](./documentation/HedgeDoc/)** - Collaborative markdown editor
  - [Official Site](https://hedgedoc.org/)

- **[Typemill](./documentation/Typemill/)** - Flat-file CMS
  - [Official Site](https://typemill.net/)

- **[Gollum](./documentation/Gollum/)** - Git-powered wiki
  - [Official Site](https://github.com/gollum/gollum)

### Collaboration & Project Management
- **[Redmine](./collaboration/Redmine/)** - Project management web application
  - [Official Site](https://www.redmine.org/)

- **[Mattermost](./collaboration/Mattermost/)** - Open-source team communication
  - [Official Site](https://mattermost.com/)

- **[Plane](./collaboration/Plane/)** - Open-source project management
  - [Official Site](https://plane.so/)

- **[Focalboard](./collaboration/Focalboard/)** - Project management and kanban
  - [Official Site](https://www.focalboard.com/)

- **[Vikunja](./collaboration/Vikunja/)** - Task management and to-do lists
  - [Official Site](https://vikunja.io/)

- **[Taiga](./collaboration/Taiga/)** - Agile project management platform
  - [Official Site](https://www.taiga.io/)

- **[Wekan](./collaboration/Wekan/)** - Open-source kanban board
  - [Official Site](https://wekan.github.io/)

### Security & Identity
- **[Keycloak](./security/Keycloak/)** - Open-source identity and access management
  - [Official Site](https://www.keycloak.org/)

### Testing
- **[Windows Containers](./tools/Windows/)** - Windows-based container environments
  - [GitHub](https://github.com/dockur/windows)

- **[WireMock](./testing/WireMock/)** - API mocking and stubbing
  - [Official Site](https://wiremock.org/)

- **[MockServer](./testing/MockServer/)** - Mock HTTP and HTTPS services
  - [Official Site](https://www.mock-server.com/)

- **[Swagger Editor](./testing/SwaggerEditor/)** - OpenAPI specification editor
  - [Official Site](https://swagger.io/tools/swagger-editor/)

- **[Hoppscotch](./testing/Hoppscotch/)** - API development and testing
  - [Official Site](https://hoppscotch.io/)

### Workflow & Job Scheduling
- **[Hangfire](./orchestration/Hangfire/)** - Background job processing for .NET
  - [Official Site](https://www.hangfire.io/)

- **[Quartz.NET](./orchestration/Quartz/)** - Job scheduling for .NET
  - [Official Site](https://www.quartz-scheduler.net/)

- **[n8n](./orchestration/n8n/)** - Workflow automation platform
  - [Official Site](https://n8n.io/)

### Document Management
- **[Paperless-ngx](./document-management/PaperlessNgx/)** - Document management with OCR
  - [Official Site](https://docs.paperless-ngx.com/)

- **[Stirling PDF](./document-management/StirlingPDF/)** - PDF manipulation tool
  - [Official Site](https://github.com/Frooodle/Stirling-PDF)

- **[Docspell](./document-management/Docspell/)** - Document organizer and archive
  - [Official Site](https://docspell.org/)

- **[OnlyOffice Docs](./document-management/OnlyOfficeDocs/)** - Online office suite
  - [Official Site](https://www.onlyoffice.com/)

### File Storage & Sync
- **[Nextcloud](./storage/Nextcloud/)** - Self-hosted productivity platform
  - [Official Site](https://nextcloud.com/)

- **[File Browser](./storage/FileBrowser/)** - Web-based file manager
  - [Official Site](https://filebrowser.org/)

- **[Syncthing](./storage/Syncthing/)** - Continuous file synchronization
  - [Official Site](https://syncthing.net/)

- **[Seafile](./storage/Seafile/)** - File sync and share platform
  - [Official Site](https://www.seafile.com/)

- **[PairDrop](./storage/PairDrop/)** - Local file sharing (AirDrop alternative)
  - [Official Site](https://github.com/schlagmichdoch/PairDrop)

### Content & Reading
- **[Calibre-Web](./content/CalibreWeb/)** - eBook library manager
  - [Official Site](https://github.com/janeczku/calibre-web)

- **[Kavita](./content/Kavita/)** - Comics, manga, and book server
  - [Official Site](https://www.kavitareader.com/)

- **[Wallabag](./content/Wallabag/)** - Read-it-later application
  - [Official Site](https://wallabag.org/)

- **[Miniflux](./content/Miniflux/)** - Minimalist RSS feed reader
  - [Official Site](https://miniflux.app/)

### Bookmarks & Archives
- **[LinkAce](./bookmarks/LinkAce/)** - Bookmark manager with backups
  - [Official Site](https://www.linkace.org/)

- **[Shiori](./bookmarks/Shiori/)** - Simple bookmark manager
  - [Official Site](https://github.com/go-shiori/shiori)

- **[ArchiveBox](./bookmarks/ArchiveBox/)** - Web archiving solution
  - [Official Site](https://archivebox.io/)

### Productivity
- **[Radicale](./productivity/Radicale/)** - CalDAV and CardDAV server
  - [Official Site](https://radicale.org/)

- **[Baïkal](./productivity/Baikal/)** - Calendar and contacts server
  - [Official Site](https://sabre.io/baikal/)

### Email & Mail Services
- **[Mailpit](./mail/Mailpit/)** - Email testing tool
  - [Official Site](https://github.com/axllent/mailpit)

- **[Postfix Mail](./mail/PostfixMail/)** - SMTP mail server
  - [Official Site](http://www.postfix.org/)

- **[Mailhog](./mail/Mailhog/)** - Email capture for testing
  - [Official Site](https://github.com/mailhog/MailHog)

### Personal Finance
- **[Firefly III](./finance/FireflyIII/)** - Personal finance manager
  - [Official Site](https://www.firefly-iii.org/)

- **[Actual Budget](./finance/ActualBudget/)** - Budget management
  - [Official Site](https://actualbudget.com/)

### Note-Taking
- **[Joplin Server](./notes/JoplinServer/)** - Note-taking sync server
  - [Official Site](https://joplinapp.org/)

- **[Trilium Notes](./notes/TriliumNotes/)** - Hierarchical note-taking
  - [Official Site](https://github.com/zadam/trilium)

- **[Memos](./notes/Memos/)** - Lightweight note-taking service
  - [Official Site](https://usememos.com/)

- **[Standard Notes](./notes/StandardNotes/)** - Encrypted note-taking
  - [Official Site](https://standardnotes.com/)

### Automation & Monitoring
- **[Changedetection.io](./automation/Changedetection/)** - Website change monitoring
  - [Official Site](https://changedetection.io/)

- **[Huginn](./automation/Huginn/)** - Automation and workflow platform
  - [Official Site](https://github.com/huginn/huginn)

### Notifications
- **[Gotify](./notifications/Gotify/)** - Self-hosted notification server
  - [Official Site](https://gotify.net/)

- **[Apprise API](./notifications/AppriseAPI/)** - Multi-platform notifications
  - [Official Site](https://github.com/caronc/apprise-api)

- **[Ntfy](./notifications/Ntfy/)** - Simple pub-sub notification service
  - [Official Site](https://ntfy.sh/)

### Diagramming & Visual Tools
- **[Draw.io](./diagrams/Drawio/)** - Diagram and flowchart editor
  - [Official Site](https://www.diagrams.net/)

- **[Excalidraw](./diagrams/Excalidraw/)** - Virtual whiteboard for sketching
  - [Official Site](https://excalidraw.com/)

### Spreadsheets & Databases
- **[Grist](./spreadsheets/Grist/)** - Modern spreadsheet with database features
  - [Official Site](https://www.getgrist.com/)

- **[Baserow](./spreadsheets/Baserow/)** - No-code database platform
  - [Official Site](https://baserow.io/)

### Home Management
- **[Tandoor Recipes](./home/TandoorRecipes/)** - Recipe manager
  - [Official Site](https://tandoor.dev/)

- **[Grocy](./home/Grocy/)** - Grocery and household management
  - [Official Site](https://grocy.info/)

- **[Homebox](./home/Homebox/)** - Home inventory management
  - [Official Site](https://github.com/hay-kot/homebox)

### Inventory & Asset Management
- **[Snipe-IT](./inventory/SnipeIT/)** - IT asset management
  - [Official Site](https://snipeitapp.com/)

### Media Management
- **[Immich](./media/Immich/)** - Photo and video management
  - [Official Site](https://immich.app/)

- **[PhotoPrism](./media/PhotoPrism/)** - AI-powered photo management
  - [Official Site](https://www.photoprism.app/)

- **[Audiobookshelf](./media/Audiobookshelf/)** - Audiobook and podcast server
  - [Official Site](https://www.audiobookshelf.org/)

- **[Navidrome](./media/Navidrome/)** - Music streaming server
  - [Official Site](https://www.navidrome.org/)

### Utilities
- **[IT Tools](./utilities/ITTools/)** - Collection of developer tools
  - [Official Site](https://it-tools.tech/)

- **[CyberChef](./utilities/CyberChef/)** - Data encoding and analysis
  - [Official Site](https://gchq.github.io/CyberChef/)

### Dashboards
- **[Homepage](./dashboards/Homepage/)** - Customizable application dashboard
  - [Official Site](https://gethomepage.dev/)

### Network Monitoring
- **[Speedtest Tracker](./network/SpeedtestTracker/)** - Internet speed monitoring
  - [Official Site](https://github.com/alexjustesen/speedtest-tracker)

### Automotive
- **[LubeLogger](./automotive/LubeLogger/)** - Vehicle maintenance tracker
  - [Official Site](https://github.com/hargata/lubelogger)


## 💡 Usage Tips

### Starting a Service
```bash
cd databases/postgresql
docker compose up -d
```

### Stopping a Service
```bash
docker compose down
```

### Stopping and Removing Volumes
```bash
docker compose down -v
```

### Viewing Logs
```bash
docker compose logs -f
```

### Checking Service Status
```bash
docker compose ps
```

## 🔐 Default Credentials

**⚠️ Security Warning**: The default credentials in these configurations are for development purposes only. Always change them for production use.

Common default credentials used across services:
- Username: `admin` / `postgres` / `root` (varies by service)
- Password: `P@ssw0rd` / `P@ss0rd123` / `P@ssw0rd@123`

Check individual service directories for specific credentials.

## 📝 Configuration

Each service directory contains:
- `docker-compose.yaml` - Main compose configuration
- `README.md` - Service-specific documentation (where applicable)
- Configuration files and volumes as needed

You can customize any service by:
1. Copying the compose file
2. Modifying environment variables, ports, or volumes
3. Running with your custom configuration

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow existing naming conventions
- Include a README.md for new services
- Use environment variables for configuration
- Document default ports and credentials
- Test configurations before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Acknowledgments

- All the amazing open-source projects included in this collection
- The Docker community for excellent documentation and support

## 🐛 Issues & Support

If you encounter any issues or have questions:
1. Check the service-specific README
2. Review Docker logs: `docker compose logs`
3. Open an issue on GitHub with details about your environment and the problem

## 🔗 Useful Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/)

---

**Note**: This is a development environment collection. For production deployments, ensure you:
- Change all default passwords
- Configure proper security settings
- Set up appropriate backup strategies
- Use secrets management
- Review the configurations
