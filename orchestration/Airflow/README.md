# Apache Airflow

Apache Airflow is deployed with PostgreSQL and Redis for the Celery executor.

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **URL:** http://localhost:8081

## Notes

- The compose file initializes the Airflow database using the `airflow-init` service.
