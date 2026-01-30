# SchemaSpy

SchemaSpy generates database documentation from a configuration file.

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Notes

- Update `schemaspy.properties` with your database connection details.
- Output is written to the `./output` directory.
- The compose file expects an existing Docker network named `backend`.
