# Keycloak

Keycloak provides identity and access management backed by PostgreSQL.

**Official Sites:**
- [Keycloak](https://www.keycloak.org/) | [Docker Hub](https://hub.docker.com/r/jboss/keycloak)

## Quick start

```bash
docker compose -f keycloak-postgres.yml up -d
```

## Access

- **URL:** http://localhost:8080

## Default credentials

- **Username:** admin
- **Password:** Pa55w0rd

## Notes

- PostgreSQL data persists in the `postgres_data` volume.
