# MongoDB

MongoDB is deployed with Mongo Express for web-based administration.

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **MongoDB:** mongodb://localhost:27017
- **Mongo Express:** http://localhost:8081

## Default credentials

- **MongoDB root user:** root / test1234
- **Mongo Express basic auth:** admin / admin

## Notes

- Initialization scripts can be placed in the `./mongo` directory.
