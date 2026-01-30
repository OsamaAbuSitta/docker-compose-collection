# Apache Airflow

This setup runs Apache Airflow with a Postgres database and Redis broker.

## Quick Start

```bash
docker compose -f docker-compose.yaml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| Airflow Webserver | 8081 | Web UI at http://localhost:8081 |
| Postgres | 5433 | Database for Airflow metadata. |
| Redis | 6380 | Celery broker and result backend. |

## Default Database Credentials

- **Username**: `airflow`
- **Password**: `airflow`
- **Database**: `airflow`

## Creating an Airflow Admin User

Airflow does not ship with a user by default. Create one after the stack is up:

```bash
docker compose -f docker-compose.yaml run --rm airflow-webserver \
  airflow users create \
  --username admin \
  --password admin \
  --firstname Admin \
  --lastname User \
  --role Admin \
  --email admin@example.com
```
