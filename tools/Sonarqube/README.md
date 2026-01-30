# SonarQube

SonarQube provides code quality and security analysis backed by PostgreSQL.

**Official Sites:**
- [SonarQube](https://www.sonarsource.com/products/sonarqube/) | [Docker Hub](https://hub.docker.com/_/sonarqube)

## Quick start

```bash
docker compose -f sonarqube.yaml up -d
```

## Access

- **URL:** http://localhost:9001

## Default credentials

- **Username:** admin
- **Password:** admin

## Notes

- PostgreSQL is provisioned as the `db` service.
