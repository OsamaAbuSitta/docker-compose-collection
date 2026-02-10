# Typesense

Typesense is a modern, privacy-friendly, open-source search engine that is optimized for instant search-as-you-type experiences and ease of use. It's a fast, typo-tolerant search engine designed for building delightful search experiences with minimal configuration.

**Official Sites:**
- [Typesense](https://typesense.org/) | [Docker Hub](https://hub.docker.com/r/typesense/typesense)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f typesense.yaml up -d
```

## Services

### Typesense
- **API URL**: http://localhost:8108
- **Health Check**: http://localhost:8108/health
- **Container**: `typesense_container`
- **API Key**: `P@ss0rd123` (change for production)

## Initial Setup

1. Copy `.env.example` to `.env` and configure your settings
2. Generate a secure API key (recommended for production)
3. Start the service with `docker compose -f typesense.yaml up -d`
4. Verify the service is running: `curl http://localhost:8108/health`
5. Check the version: `curl http://localhost:8108/debug`

## Configuration

### Environment Variables (.env)

- `TYPESENSE_PORT` - API service port (default: 8108)
- `TYPESENSE_API_KEY` - Bootstrap admin API key for all operations (change for production)
- `TYPESENSE_ENABLE_CORS` - Enable CORS for browser access (default: true)
- `TYPESENSE_API_ADDRESS` - Address to bind the API service (default: 0.0.0.0)

### Custom Configuration

For advanced configuration, you can add additional environment variables:

```yaml
environment:
  - TYPESENSE_API_KEY=${TYPESENSE_API_KEY:-P@ss0rd123}
  - TYPESENSE_DATA_DIR=/data
  - TYPESENSE_ENABLE_CORS=${TYPESENSE_ENABLE_CORS:-true}
  - TYPESENSE_LOG_SLOW_REQUESTS_TIME_MS=1000
  - TYPESENSE_THREAD_POOL_SIZE=64
```

## Connecting to Typesense

### From Host Machine (cURL)

```bash
# Health check
curl http://localhost:8108/health

# Check version
curl http://localhost:8108/debug

# Create a collection
curl "http://localhost:8108/collections" \
  -X POST \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "books",
    "fields": [
      {"name": "title", "type": "string"},
      {"name": "author", "type": "string"},
      {"name": "publication_year", "type": "int32"},
      {"name": "ratings_count", "type": "int32"}
    ],
    "default_sorting_field": "ratings_count"
  }'

# Index a document
curl "http://localhost:8108/collections/books/documents" \
  -X POST \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "The Great Gatsby",
    "author": "F. Scott Fitzgerald",
    "publication_year": 1925,
    "ratings_count": 1000
  }'

# Search documents
curl "http://localhost:8108/collections/books/documents/search?q=gatsby&query_by=title,author" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123"
```

### From JavaScript

```javascript
// Install: npm install typesense

const Typesense = require('typesense');

const client = new Typesense.Client({
  nodes: [{
    host: 'localhost',
    port: '8108',
    protocol: 'http'
  }],
  apiKey: 'P@ss0rd123',
  connectionTimeoutSeconds: 2
});

// Create a collection
const schema = {
  name: 'books',
  fields: [
    {name: 'title', type: 'string'},
    {name: 'author', type: 'string'},
    {name: 'publication_year', type: 'int32'},
    {name: 'ratings_count', type: 'int32'}
  ],
  default_sorting_field: 'ratings_count'
};

client.collections().create(schema)
  .then(data => console.log(data));

// Index a document
const document = {
  title: 'The Great Gatsby',
  author: 'F. Scott Fitzgerald',
  publication_year: 1925,
  ratings_count: 1000
};

client.collections('books').documents().create(document)
  .then(data => console.log(data));

// Search
const searchParameters = {
  q: 'gatsby',
  query_by: 'title,author'
};

client.collections('books').documents().search(searchParameters)
  .then(searchResults => {
    console.log(searchResults);
  });
```

### From Python

```python
# Install: pip install typesense

import typesense

client = typesense.Client({
  'nodes': [{
    'host': 'localhost',
    'port': '8108',
    'protocol': 'http'
  }],
  'api_key': 'P@ss0rd123',
  'connection_timeout_seconds': 2
})

# Create a collection
schema = {
  'name': 'books',
  'fields': [
    {'name': 'title', 'type': 'string'},
    {'name': 'author', 'type': 'string'},
    {'name': 'publication_year', 'type': 'int32'},
    {'name': 'ratings_count', 'type': 'int32'}
  ],
  'default_sorting_field': 'ratings_count'
}

client.collections.create(schema)

# Index a document
document = {
  'title': 'The Great Gatsby',
  'author': 'F. Scott Fitzgerald',
  'publication_year': 1925,
  'ratings_count': 1000
}

client.collections['books'].documents.create(document)

# Search
search_parameters = {
  'q': 'gatsby',
  'query_by': 'title,author'
}

results = client.collections['books'].documents.search(search_parameters)
print(results)
```

### From PHP

```php
// Install: composer require typesense/typesense-php

use Typesense\Client;

$client = new Client([
  'nodes' => [
    [
      'host' => 'localhost',
      'port' => '8108',
      'protocol' => 'http',
    ],
  ],
  'api_key' => 'P@ss0rd123',
  'connection_timeout_seconds' => 2,
]);

// Create a collection
$schema = [
  'name' => 'books',
  'fields' => [
    ['name' => 'title', 'type' => 'string'],
    ['name' => 'author', 'type' => 'string'],
    ['name' => 'publication_year', 'type' => 'int32'],
    ['name' => 'ratings_count', 'type' => 'int32']
  ],
  'default_sorting_field' => 'ratings_count'
];

$client->collections->create($schema);

// Index a document
$document = [
  'title' => 'The Great Gatsby',
  'author' => 'F. Scott Fitzgerald',
  'publication_year' => 1925,
  'ratings_count' => 1000
];

$client->collections['books']->documents->create($document);

// Search
$searchParameters = [
  'q' => 'gatsby',
  'query_by' => 'title,author'
];

$results = $client->collections['books']->documents->search($searchParameters);
```

## Volumes

- `typesense-data` - Search index and data storage

## API Usage Examples

### Create a Collection

```bash
curl "http://localhost:8108/collections" \
  -X POST \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "products",
    "fields": [
      {"name": "name", "type": "string"},
      {"name": "description", "type": "string"},
      {"name": "price", "type": "float"},
      {"name": "category", "type": "string", "facet": true},
      {"name": "in_stock", "type": "bool"}
    ]
  }'
```

### Index Multiple Documents

```bash
curl "http://localhost:8108/collections/products/documents/import?action=create" \
  -X POST \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -H "Content-Type: text/plain" \
  -d '{"name":"Laptop","description":"High-performance laptop","price":999.99,"category":"Electronics","in_stock":true}
{"name":"Desk Chair","description":"Ergonomic office chair","price":299.99,"category":"Furniture","in_stock":true}
{"name":"Coffee Maker","description":"Automatic coffee maker","price":79.99,"category":"Appliances","in_stock":false}'
```

### Search with Filters

```bash
curl "http://localhost:8108/collections/products/documents/search" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -d 'q=laptop&query_by=name,description&filter_by=in_stock:true&sort_by=price:asc'
```

### Faceted Search

```bash
curl "http://localhost:8108/collections/products/documents/search" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -d 'q=*&query_by=name&facet_by=category'
```

### Update a Document

```bash
curl "http://localhost:8108/collections/products/documents/1" \
  -X PATCH \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -H "Content-Type: application/json" \
  -d '{"price": 899.99}'
```

### Delete a Document

```bash
curl "http://localhost:8108/collections/products/documents/1" \
  -X DELETE \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123"
```

### List Collections

```bash
curl "http://localhost:8108/collections" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123"
```

### Delete a Collection

```bash
curl "http://localhost:8108/collections/products" \
  -X DELETE \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123"
```

## Common Tasks

### Create Search-Only API Key

For security, create a search-only API key to use in browser applications:

```bash
curl "http://localhost:8108/keys" \
  -X POST \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -H "Content-Type: application/json" \
  -d '{
    "description": "Search-only key",
    "actions": ["documents:search"],
    "collections": ["*"]
  }'
```

### Backup Data

```bash
# Export collection data
curl "http://localhost:8108/collections/books/documents/export" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  > books_backup.jsonl

# Or backup the entire data directory
docker run --rm -v typesense-data:/data -v $(pwd):/backup ubuntu \
  tar czf /backup/typesense-backup.tar.gz /data
```

### Restore Data

```bash
# Import collection data
curl "http://localhost:8108/collections/books/documents/import?action=create" \
  -X POST \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -H "Content-Type: text/plain" \
  --data-binary @books_backup.jsonl
```

### View Collection Schema

```bash
curl "http://localhost:8108/collections/books" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123"
```

### View Logs

```bash
docker logs typesense_container
```

### Access Container Shell

```bash
docker exec -it typesense_container sh
```

## Search Endpoint Details

### Basic Search

**Endpoint**: `GET /collections/{collection}/documents/search`

**Required Parameters**:
- `q` - The search query
- `query_by` - Comma-separated list of fields to search

**Optional Parameters**:
- `filter_by` - Filter conditions (e.g., `category:Electronics && in_stock:true`)
- `sort_by` - Sort order (e.g., `price:asc,ratings_count:desc`)
- `facet_by` - Fields to facet by
- `max_facet_values` - Maximum number of facet values to return
- `page` - Page number (default: 1)
- `per_page` - Results per page (default: 10, max: 250)
- `group_by` - Group results by field
- `include_fields` - Comma-separated fields to include in response
- `exclude_fields` - Comma-separated fields to exclude from response
- `highlight_full_fields` - Fields to highlight fully
- `num_typos` - Number of typos to tolerate (default: 2)
- `prefix` - Enable prefix searching (default: true)

### Example Search Query

```bash
curl "http://localhost:8108/collections/books/documents/search" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123" \
  -d 'q=harry potter&query_by=title,author&filter_by=publication_year:>2000&sort_by=ratings_count:desc&per_page=20'
```

### Typo Tolerance

Typesense automatically handles typos in search queries:

```bash
# Searching for "gatbsy" will find "gatsby"
curl "http://localhost:8108/collections/books/documents/search?q=gatbsy&query_by=title" \
  -H "X-TYPESENSE-API-KEY: P@ss0rd123"
```

## Features

- **Typo Tolerance**: Automatically handles typos in search queries
- **Fast Search**: Optimized for instant search-as-you-type experiences
- **Faceting & Filtering**: Support for faceted search and complex filters
- **Sorting**: Multi-field sorting with custom ranking
- **Grouping**: Group results by field values
- **Highlighting**: Highlight matching terms in results
- **Geo Search**: Search by geographic location
- **Vector Search**: Semantic search using embeddings
- **Synonyms**: Define custom synonyms for better search results
- **Curation**: Override search results for specific queries
- **API Keys**: Fine-grained access control with scoped API keys
- **CORS Support**: Direct browser access with CORS enabled
- **High Availability**: Clustering support for production deployments
- **RESTful API**: Simple HTTP API for all operations
- **Client Libraries**: Official libraries for JavaScript, Python, PHP, Ruby, and more

## Troubleshooting

### Container Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs typesense_container`. Ensure the API key is set and volumes have proper permissions.

### Cannot Access API

- **Symptoms**: Connection refused on port 8108
- **Solution**: Verify the container is running with `docker ps`. Check that port 8108 is not in use by another service.

### Authentication Failed

- **Symptoms**: "Unauthorized" or "Invalid API key" error
- **Solution**: Verify your API key is correct. Check the TYPESENSE_API_KEY environment variable. Ensure you're passing the key in the X-TYPESENSE-API-KEY header.

### Search Returns No Results

- **Symptoms**: Search queries return empty results
- **Solution**: Verify documents are indexed with `curl http://localhost:8108/collections/your_collection`. Check that the query_by fields exist in your schema. Try a broader search query.

### Slow Search Performance

- **Symptoms**: Search queries take a long time
- **Solution**: Ensure you're using appropriate field types. Consider increasing TYPESENSE_THREAD_POOL_SIZE. Check container resource limits.

### Data Not Persisting

- **Symptoms**: Data lost after container restart
- **Solution**: Ensure volumes are properly mounted. Check volume permissions with `docker volume inspect typesense-data`.

### CORS Errors in Browser

- **Symptoms**: "CORS policy" errors in browser console
- **Solution**: Ensure TYPESENSE_ENABLE_CORS is set to true. Use a search-only API key in browser applications, not the admin key.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Generate a secure API key using a cryptographically secure random string (at least 32 characters)
- Create search-only API keys for browser applications using the key management API
- Never expose the admin API key to browser JavaScript clients
- Use HTTPS with a reverse proxy (nginx, Traefik, Caddy)
- Restrict network access with firewall rules
- Regular backups are essential for production data
- Consider using Typesense Cloud for managed hosting with built-in security
- Monitor API usage and set up rate limiting if needed
- Keep Typesense updated to the latest stable version

## Resources

- [Official Documentation](https://typesense.org/docs/)
- [API Reference](https://typesense.org/docs/latest/api/)
- [Search Guide](https://typesense.org/docs/guide/)
- [Docker Hub](https://hub.docker.com/r/typesense/typesense)
- [GitHub Repository](https://github.com/typesense/typesense)
- [Community Forum](https://github.com/typesense/typesense/discussions)
- [Client Libraries](https://typesense.org/docs/latest/api/api-clients.html)
- [Typesense Cloud](https://cloud.typesense.org/)
