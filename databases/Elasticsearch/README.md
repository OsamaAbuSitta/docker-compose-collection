# Elasticsearch

Elasticsearch is deployed with Kibana for visualization.

**Official Sites:**
- [Elasticsearch](https://www.elastic.co/elasticsearch/) | [Docker Hub](https://hub.docker.com/_/elasticsearch)
- [Kibana](https://www.elastic.co/kibana/) | [Docker Hub](https://hub.docker.com/_/kibana)

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **Elasticsearch:** http://localhost:9200
- **Kibana:** http://localhost:5601

## Notes

- Data is persisted in the `local-es` volume.
