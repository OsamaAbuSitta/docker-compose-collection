# MongoDB

MongoDB is deployed with Mongo Express for web-based administration.

**Official Sites:**
- [MongoDB](https://www.mongodb.com/) | [Docker Hub](https://hub.docker.com/_/mongo)
- [Mongo Express](https://github.com/mongo-express/mongo-express) | [Docker Hub](https://hub.docker.com/_/mongo-express)

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
