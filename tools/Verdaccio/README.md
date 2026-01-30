# Verdaccio

Verdaccio provides a private npm registry with an Nginx front end.

**Official Sites:**
- [Verdaccio](https://verdaccio.org/) | [Docker Hub](https://hub.docker.com/r/verdaccio/verdaccio)

## Quick start

```bash
docker compose -f verdaccio.yaml up -d
```

## Access

- **Verdaccio:** http://localhost:4873
- **Nginx:** http://localhost:5030

## Notes

- Registry data is persisted in the `verdaccio` volume.
