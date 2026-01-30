# SonarQube

SonarQube for code quality and security analysis, backed by Postgres.

## Quick Start

```bash
docker compose -f sonarqube.yaml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| SonarQube | 9001 | Web UI at http://localhost:9001 |
| Postgres | 5432 | Internal database for SonarQube. |

## Default Credentials

**SonarQube**
- **Username**: `admin`
- **Password**: `admin`

**Postgres**
- **Username**: `sonar`
- **Password**: `sonar`
- **Database**: `sonar`

## Notes

- SonarQube can take a few minutes to become ready on first startup.
