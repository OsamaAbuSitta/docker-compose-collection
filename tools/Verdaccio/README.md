# Verdaccio

Verdaccio private npm registry with an optional Nginx proxy.

## Quick Start

```bash
docker compose -f verdaccio.yaml up -d
```

## Services

| Service | Port | Notes |
| --- | --- | --- |
| Verdaccio | 4873 | Registry at http://localhost:4873 |
| Nginx | 5030 | Proxy endpoint at http://localhost:5030 |
