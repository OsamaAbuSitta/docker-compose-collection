# SchemaSpy

SchemaSpy generates database documentation from a configuration file.

## Quick Start

```bash
docker compose -f docker-compose.yaml up
```

## Notes

- Edit `schemaspy.properties` to point to your database.
- The compose file expects an external network named `backend`.
- Output is written to the `output/` directory.
