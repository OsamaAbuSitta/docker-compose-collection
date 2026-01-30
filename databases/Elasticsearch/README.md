# Elasticsearch with Kibana

Elasticsearch single-node cluster with Kibana for visualization.

## Quick Start

```bash
docker compose -f docker-compose.yaml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| Elasticsearch | 9200 | REST API. |
| Elasticsearch | 9300 | Transport port. |
| Kibana | 5601 | Web UI at http://localhost:5601 |

## Notes

- This configuration runs Elasticsearch in single-node mode.
