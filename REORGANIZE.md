# Repository Reorganization Guide

This document outlines the steps to reorganize the repository structure for better organization and discoverability.

## Proposed New Structure

```
docker-dev-environments/
├── databases/
│   ├── postgresql/
│   ├── mysql/
│   ├── mssql/
│   ├── mongodb/
│   ├── redis/
│   ├── oracle/
│   └── elasticsearch/
├── data-streaming/
│   └── kafka/
├── orchestration/
│   └── airflow/
├── monitoring/
│   ├── grafana/
│   └── prometheus/
├── logging/
│   └── seq/
├── tools/
│   ├── portainer/
│   ├── sonarqube/
│   ├── verdaccio/
│   ├── cloudbeaver/
│   └── schemaspy/
├── documentation/
│   ├── docusaurus/
│   └── structurizr/
├── security/
│   └── keycloak/
└── testing/
    └── windows/
```

## Reorganization Commands

### For Linux/Mac:

```bash
# Create new directory structure
mkdir -p databases/{postgresql,mysql,mssql,mongodb,redis,oracle,elasticsearch}
mkdir -p data-streaming/kafka
mkdir -p orchestration/airflow
mkdir -p monitoring/{grafana,prometheus}
mkdir -p logging/seq
mkdir -p tools/{portainer,sonarqube,verdaccio,cloudbeaver,schemaspy}
mkdir -p documentation/{docusaurus,structurizr}
mkdir -p security/keycloak
mkdir -p testing/windows

# Move directories
mv Postgresql/* databases/postgresql/
mv MySql/* databases/mysql/
mv MsSqlServer/* databases/mssql/
mv Mongodb/* databases/mongodb/
mv Redis/* databases/redis/
mv Oracle/* databases/oracle/
mv Elasticsearch/* databases/elasticsearch/

mv Kafka/* data-streaming/kafka/
mv Airflow/* orchestration/airflow/

mv Grafana/* monitoring/grafana/
mv Prometheus/* monitoring/prometheus/

mv SeqLog/* logging/seq/

mv Portainer/* tools/portainer/
mv Sonarqube/* tools/sonarqube/
mv Verdaccio/* tools/verdaccio/
mv Cloudbeaver/* tools/cloudbeaver/
mv Schemaspy/* tools/schemaspy/

mv Docusaurus/* documentation/docusaurus/
mv Structurizr/* documentation/structurizr/

mv Keycloak/* security/keycloak/

mv Windows/* testing/windows/

# Remove old directories
rmdir Postgresql MySql MsSqlServer Mongodb Redis Oracle Elasticsearch
rmdir Kafka Airflow Grafana Prometheus SeqLog
rmdir Portainer Sonarqube Verdaccio Cloudbeaver Schemaspy
rmdir Docusaurus Structurizr Keycloak Windows
```

### For Windows (PowerShell):

```powershell
# Create new directory structure
New-Item -ItemType Directory -Force -Path databases/postgresql,databases/mysql,databases/mssql,databases/mongodb,databases/redis,databases/oracle,databases/elasticsearch
New-Item -ItemType Directory -Force -Path data-streaming/kafka
New-Item -ItemType Directory -Force -Path orchestration/airflow
New-Item -ItemType Directory -Force -Path monitoring/grafana,monitoring/prometheus
New-Item -ItemType Directory -Force -Path logging/seq
New-Item -ItemType Directory -Force -Path tools/portainer,tools/sonarqube,tools/verdaccio,tools/cloudbeaver,tools/schemaspy
New-Item -ItemType Directory -Force -Path documentation/docusaurus,documentation/structurizr
New-Item -ItemType Directory -Force -Path security/keycloak
New-Item -ItemType Directory -Force -Path testing/windows

# Move directories
Move-Item -Path Postgresql/* -Destination databases/postgresql/
Move-Item -Path MySql/* -Destination databases/mysql/
Move-Item -Path MsSqlServer/* -Destination databases/mssql/
Move-Item -Path Mongodb/* -Destination databases/mongodb/
Move-Item -Path Redis/* -Destination databases/redis/
Move-Item -Path Oracle/* -Destination databases/oracle/
Move-Item -Path Elasticsearch/* -Destination databases/elasticsearch/

Move-Item -Path Kafka/* -Destination data-streaming/kafka/
Move-Item -Path Airflow/* -Destination orchestration/airflow/

Move-Item -Path Grafana/* -Destination monitoring/grafana/
Move-Item -Path Prometheus/* -Destination monitoring/prometheus/

Move-Item -Path SeqLog/* -Destination logging/seq/

Move-Item -Path Portainer/* -Destination tools/portainer/
Move-Item -Path Sonarqube/* -Destination tools/sonarqube/
Move-Item -Path Verdaccio/* -Destination tools/verdaccio/
Move-Item -Path Cloudbeaver/* -Destination tools/cloudbeaver/
Move-Item -Path Schemaspy/* -Destination tools/schemaspy/

Move-Item -Path Docusaurus/* -Destination documentation/docusaurus/
Move-Item -Path Structurizr/* -Destination documentation/structurizr/

Move-Item -Path Keycloak/* -Destination security/keycloak/

Move-Item -Path Windows/* -Destination testing/windows/

# Remove old directories
Remove-Item -Path Postgresql,MySql,MsSqlServer,Mongodb,Redis,Oracle,Elasticsearch -Force
Remove-Item -Path Kafka,Airflow,Grafana,Prometheus,SeqLog -Force
Remove-Item -Path Portainer,Sonarqube,Verdaccio,Cloudbeaver,Schemaspy -Force
Remove-Item -Path Docusaurus,Structurizr,Keycloak,Windows -Force
```

## Alternative: Keep Current Structure

If you prefer to keep the current flat structure, you can skip reorganization and just add the main README.md. The current structure is simpler and works well for smaller collections.

## After Reorganization

1. Update any internal path references in compose files
2. Test each service to ensure it still works
3. Update documentation with new paths
4. Commit changes to git

## Git Commands

```bash
# Stage all changes
git add .

# Commit
git commit -m "Reorganize repository structure and add comprehensive documentation"

# Push to GitHub
git push origin main
```
