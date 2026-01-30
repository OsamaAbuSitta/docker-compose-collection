# Keycloak with Postgres

Keycloak identity server backed by a Postgres database.

## Quick Start

```bash
docker compose -f keycloak-postgres.yml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| Keycloak | 8080 | Web UI at http://localhost:8080 |
| Postgres | 5432 | Internal database for Keycloak. |

## Default Credentials

**Keycloak Admin**
- **Username**: `admin`
- **Password**: `Pa55w0rd`

**Postgres**
- **Username**: `keycloak`
- **Password**: `password`
- **Database**: `keycloak`
