@echo off
REM Docker Development Environments Setup Script for Windows
REM This script helps you quickly start services

echo Docker Development Environments Setup
echo ========================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker is not installed
    echo Please install Docker Desktop from https://docs.docker.com/desktop/install/windows-install/
    pause
    exit /b 1
)

REM Check if Docker Compose is available
docker compose version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker Compose is not available
    echo Please install Docker Compose V2
    pause
    exit /b 1
)

echo [OK] Docker is installed
echo [OK] Docker Compose is available
echo.

REM List available services
echo Available Services:
echo ===================
echo.
echo Databases:
echo   1. PostgreSQL (with pgAdmin)
echo   2. MySQL
echo   3. MS SQL Server
echo   4. MongoDB
echo   5. Redis
echo   6. Oracle
echo   7. Elasticsearch
echo.
echo Tools:
echo   8. Portainer (Docker Management)
echo   9. Kafka (with UI)
echo   10. Grafana
echo   11. Prometheus
echo   12. SonarQube
echo.
echo Other:
echo   13. Airflow
echo   14. Keycloak
echo   15. Seq Log
echo.

set /p choice="Enter service number to start (or 'q' to quit): "

if "%choice%"=="1" (
    echo Starting PostgreSQL...
    cd Postgresql
    docker compose -f postgresql.yaml up -d
    echo [OK] PostgreSQL started
    echo PostgreSQL: localhost:5432 (postgres/P@ss0rd123^)
    echo pgAdmin: http://localhost:8888 (postgres@domain.com/P@ss0rd123^)
    goto end
)

if "%choice%"=="2" (
    echo Starting MySQL...
    cd MySql
    docker compose up -d
    echo [OK] MySQL started
    goto end
)

if "%choice%"=="3" (
    echo Starting MS SQL Server...
    cd MsSqlServer
    docker compose -f sql-express-edition.yaml up -d
    echo [OK] MS SQL Server started
    echo SQL Server: localhost:1431 (sa/P@ssw0rd^)
    goto end
)

if "%choice%"=="4" (
    echo Starting MongoDB...
    cd Mongodb
    docker compose up -d
    echo [OK] MongoDB started
    goto end
)

if "%choice%"=="5" (
    echo Starting Redis...
    cd Redis
    docker compose -f Redis.yaml up -d
    echo [OK] Redis started
    goto end
)

if "%choice%"=="6" (
    echo Starting Oracle...
    cd Oracle
    docker compose up -d
    echo [OK] Oracle started
    goto end
)

if "%choice%"=="7" (
    echo Starting Elasticsearch...
    cd Elasticsearch
    docker compose up -d
    echo [OK] Elasticsearch started
    goto end
)

if "%choice%"=="8" (
    echo Starting Portainer...
    cd Portainer
    docker compose up -d
    echo [OK] Portainer started
    echo Portainer: http://localhost:9000
    goto end
)

if "%choice%"=="9" (
    echo Starting Kafka...
    cd Kafka
    docker compose -f kafka-with-ui.yaml up -d
    echo [OK] Kafka started
    goto end
)

if "%choice%"=="10" (
    echo Starting Grafana...
    cd Grafana
    docker compose -f grafana.yaml up -d
    echo [OK] Grafana started
    goto end
)

if "%choice%"=="11" (
    echo Starting Prometheus...
    cd Prometheus
    docker compose up -d
    echo [OK] Prometheus started
    goto end
)

if "%choice%"=="12" (
    echo Starting SonarQube...
    cd Sonarqube
    docker compose -f sonarqube.yaml up -d
    echo [OK] SonarQube started
    goto end
)

if "%choice%"=="13" (
    echo Starting Airflow...
    cd Airflow
    docker compose up -d
    echo [OK] Airflow started
    goto end
)

if "%choice%"=="14" (
    echo Starting Keycloak...
    cd Keycloak
    docker compose -f keycloak-postgres.yml up -d
    echo [OK] Keycloak started
    goto end
)

if "%choice%"=="15" (
    echo Starting Seq Log...
    cd SeqLog
    docker compose up -d
    echo [OK] Seq Log started
    goto end
)

if /i "%choice%"=="q" (
    echo Goodbye!
    exit /b 0
)

echo [ERROR] Invalid choice
pause
exit /b 1

:end
echo.
echo To view logs: docker compose logs -f
echo To stop: docker compose down
echo To stop and remove data: docker compose down -v
echo.
pause
