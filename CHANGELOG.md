# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive README.md with project overview
- CONTRIBUTING.md with contribution guidelines
- QUICK_REFERENCE.md for common Docker commands
- Service-specific documentation for PostgreSQL, MS SQL Server, Portainer, and Docusaurus
- GitHub issue templates (bug report, feature request)
- GitHub pull request template
- CI/CD workflow for validating Docker Compose files
- Interactive setup scripts (setup.sh for Linux/Mac, setup.bat for Windows)
- .gitignore to exclude data files and sensitive information
- PROJECT_SUMMARY.md documenting the reorganization

### Changed
- Updated Portainer/Readme.md with better formatting and structure
- Updated Docusaurus/Readme.md with improved documentation

### Security
- Added security warnings for default credentials
- Documented development-only password usage
- Added .gitignore to prevent committing sensitive data
- Move creditionals to .env file

## [1.0.0] - 2026-01-30

### Added
- Initial collection of Docker Compose configurations
- PostgreSQL with pgAdmin
- MySQL
- MS SQL Server (Express, Developer, Windows editions)
- MongoDB
- Redis
- Oracle
- Elasticsearch
- Apache Kafka with UI
- Apache Airflow
- Grafana
- Prometheus
- Seq Log Server
- Portainer
- SonarQube
- Verdaccio
- Cloudbeaver
- SchemaSpy
- Docusaurus
- Structurizr
- Keycloak
- Windows containers
- MIT License

[Unreleased]: https://github.com/yourusername/docker-dev-environments/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/yourusername/docker-dev-environments/releases/tag/v1.0.0
