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

#### NoSQL Databases
- **[MongoDB](./databases/Mongodb/)** - Document-oriented NoSQL database
  - [Official Site](https://www.mongodb.com/)
  
- **[Redis](./databases/Redis/)** - In-memory data structure store
  - [Official Site](https://redis.io/)
  
- **[Elasticsearch](./databases/Elasticsearch/)** - Distributed search and analytics engine
  - [Official Site](https://www.elastic.co/elasticsearch/)

### Data Processing & Streaming
- **[Apache Kafka](./data-streaming/Kafka/)** - Distributed event streaming platform with UI
  - [Official Site](https://kafka.apache.org/)
  
- **[Apache Airflow](./orchestration/Airflow/)** - Workflow orchestration platform
  - [Official Site](https://airflow.apache.org/)

### Monitoring & Observability
- **[Grafana](./monitoring/Grafana/)** - Analytics and monitoring platform
  - [Official Site](https://grafana.com/)
  
- **[Prometheus](./monitoring/Prometheus/)** - Monitoring system and time series database
  - [Official Site](https://prometheus.io/)
  
- **[Seq](./logging/SeqLog/)** - Structured log server
  - [Official Site](https://datalust.co/seq)

### Development Tools
- **[SonarQube](./tools/Sonarqube/)** - Code quality and security analysis
  - [Official Site](https://www.sonarsource.com/products/sonarqube/)
  
- **[Verdaccio](./tools/Verdaccio/)** - Private npm registry proxy
  - [Official Site](https://verdaccio.org/)
  
- **[Cloudbeaver](./tools/Cloudbeaver/)** - Web-based database management tool
  - [Official Site](https://cloudbeaver.io/)
  
- **[SchemaSpy](./tools/Schemaspy/)** - Database documentation generator
  - [Official Site](https://schemaspy.org/)

### Documentation & Architecture
- **[Docusaurus](./documentation/Docusaurus/)** - Documentation website generator
  - [Official Site](https://docusaurus.io/)
  
- **[Structurizr](./documentation/Structurizr/)** - Architecture documentation tool
  - [Official Site](https://structurizr.com/)

### Security & Identity
- **[Keycloak](./security/Keycloak/)** - Open-source identity and access management
  - [Official Site](https://www.keycloak.org/)

### Testing
- **[Windows Containers](./tools/Windows/)** - Windows-based container environments
  - [GitHub](https://github.com/dockur/windows)


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
