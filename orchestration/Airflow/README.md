# Apache Airflow

Apache Airflow is deployed with PostgreSQL and Redis for the Celery executor.

**Official Sites:**
- [Apache Airflow](https://airflow.apache.org/) | [Docker Hub](https://hub.docker.com/r/apache/airflow)

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **URL:** http://localhost:8081

## Notes

- The compose file initializes the Airflow database using the `airflow-init` service.
