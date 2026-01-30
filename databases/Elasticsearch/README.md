# Elasticsearch

Elasticsearch is deployed with Kibana for visualization.

## Quick start

```bash
docker compose -f docker-compose.yaml up -d
```

## Access

- **Elasticsearch:** http://localhost:9200
- **Kibana:** http://localhost:5601

## Notes

- Data is persisted in the `local-es` volume.
