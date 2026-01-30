#!/bin/bash

# Docker Development Environments Setup Script
# This script helps you quickly start services

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🐳 Docker Development Environments Setup"
echo "========================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed${NC}"
    echo "Please install Docker from https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is available
if ! docker compose version &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not available${NC}"
    echo "Please install Docker Compose V2"
    exit 1
fi

echo -e "${GREEN}✅ Docker is installed${NC}"
echo -e "${GREEN}✅ Docker Compose is available${NC}"
echo ""

# List available services
echo "Available Services:"
echo "==================="
echo ""
echo "Databases:"
echo "  1. PostgreSQL (with pgAdmin)"
echo "  2. MySQL"
echo "  3. MS SQL Server"
echo "  4. MongoDB"
echo "  5. Redis"
echo "  6. Oracle"
echo "  7. Elasticsearch"
echo ""
echo "Tools:"
echo "  8. Portainer (Docker Management)"
echo "  9. Kafka (with UI)"
echo "  10. Grafana"
echo "  11. Prometheus"
echo "  12. SonarQube"
echo ""
echo "Other:"
echo "  13. Airflow"
echo "  14. Keycloak"
echo "  15. Seq Log"
echo ""

read -p "Enter service number to start (or 'q' to quit): " choice

case $choice in
    1)
        echo -e "${YELLOW}Starting PostgreSQL...${NC}"
        cd Postgresql
        docker compose -f postgresql.yaml up -d
        echo -e "${GREEN}✅ PostgreSQL started${NC}"
        echo "PostgreSQL: localhost:5432 (postgres/P@ss0rd123)"
        echo "pgAdmin: http://localhost:8888 (postgres@domain.com/P@ss0rd123)"
        ;;
    2)
        echo -e "${YELLOW}Starting MySQL...${NC}"
        cd MySql
        docker compose up -d
        echo -e "${GREEN}✅ MySQL started${NC}"
        ;;
    3)
        echo -e "${YELLOW}Starting MS SQL Server...${NC}"
        cd MsSqlServer
        docker compose -f sql-express-edition.yaml up -d
        echo -e "${GREEN}✅ MS SQL Server started${NC}"
        echo "SQL Server: localhost:1431 (sa/P@ssw0rd)"
        ;;
    4)
        echo -e "${YELLOW}Starting MongoDB...${NC}"
        cd Mongodb
        docker compose up -d
        echo -e "${GREEN}✅ MongoDB started${NC}"
        ;;
    5)
        echo -e "${YELLOW}Starting Redis...${NC}"
        cd Redis
        docker compose -f Redis.yaml up -d
        echo -e "${GREEN}✅ Redis started${NC}"
        ;;
    6)
        echo -e "${YELLOW}Starting Oracle...${NC}"
        cd Oracle
        docker compose up -d
        echo -e "${GREEN}✅ Oracle started${NC}"
        ;;
    7)
        echo -e "${YELLOW}Starting Elasticsearch...${NC}"
        cd Elasticsearch
        docker compose up -d
        echo -e "${GREEN}✅ Elasticsearch started${NC}"
        ;;
    8)
        echo -e "${YELLOW}Starting Portainer...${NC}"
        cd Portainer
        docker compose up -d
        echo -e "${GREEN}✅ Portainer started${NC}"
        echo "Portainer: http://localhost:9000"
        ;;
    9)
        echo -e "${YELLOW}Starting Kafka...${NC}"
        cd Kafka
        docker compose -f kafka-with-ui.yaml up -d
        echo -e "${GREEN}✅ Kafka started${NC}"
        ;;
    10)
        echo -e "${YELLOW}Starting Grafana...${NC}"
        cd Grafana
        docker compose -f grafana.yaml up -d
        echo -e "${GREEN}✅ Grafana started${NC}"
        ;;
    11)
        echo -e "${YELLOW}Starting Prometheus...${NC}"
        cd Prometheus
        docker compose up -d
        echo -e "${GREEN}✅ Prometheus started${NC}"
        ;;
    12)
        echo -e "${YELLOW}Starting SonarQube...${NC}"
        cd Sonarqube
        docker compose -f sonarqube.yaml up -d
        echo -e "${GREEN}✅ SonarQube started${NC}"
        ;;
    13)
        echo -e "${YELLOW}Starting Airflow...${NC}"
        cd Airflow
        docker compose up -d
        echo -e "${GREEN}✅ Airflow started${NC}"
        ;;
    14)
        echo -e "${YELLOW}Starting Keycloak...${NC}"
        cd Keycloak
        docker compose -f keycloak-postgres.yml up -d
        echo -e "${GREEN}✅ Keycloak started${NC}"
        ;;
    15)
        echo -e "${YELLOW}Starting Seq Log...${NC}"
        cd SeqLog
        docker compose up -d
        echo -e "${GREEN}✅ Seq Log started${NC}"
        ;;
    q|Q)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo "To view logs: docker compose logs -f"
echo "To stop: docker compose down"
echo "To stop and remove data: docker compose down -v"
