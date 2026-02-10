# Hoppscotch

An open-source API development ecosystem that helps you create, test, and document APIs. Hoppscotch (formerly Postwoman) is a lightweight, fast alternative to Postman with a beautiful interface and powerful features.

**Official Sites:**
- [Hoppscotch](https://hoppscotch.io/) | [Docker Hub](https://hub.docker.com/r/hoppscotch/hoppscotch)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f hoppscotch.yaml up -d
```

## Services

### Hoppscotch
- **URL**: http://localhost:3000
- **Container**: `hoppscotch`
- **Description**: API development and testing platform

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Create a `collections` directory for your API collections
3. Start the service with `docker compose -f hoppscotch.yaml up -d`
4. Navigate to http://localhost:3000
5. Start testing your APIs

## Configuration

### Environment Variables (.env)

- `HOPPSCOTCH_PORT` - Web interface port (default: 3000)
- `TZ` - Timezone for the container (default: UTC)
- `COLLECTIONS_DIR` - Directory for API collections (default: ./collections)
- `PRODUCTION` - Production mode flag (default: false)

### Custom Configuration

Hoppscotch runs entirely in the browser with minimal server-side configuration. Collections can be saved locally or synced with cloud storage.

## Using Hoppscotch

### Making API Requests

1. Open Hoppscotch in your browser
2. Enter your API endpoint URL
3. Select the HTTP method (GET, POST, PUT, DELETE, etc.)
4. Add headers, parameters, and body as needed
5. Click **Send** to execute the request
6. View the response in real-time

### Creating Collections

1. Click **Collections** in the sidebar
2. Create a new collection
3. Add requests to organize your API tests
4. Save collections for reuse

### Testing APIs

- **Real-time**: See responses as they arrive
- **History**: Access previous requests
- **Environments**: Manage variables for different environments
- **Pre-request Scripts**: Run JavaScript before requests
- **Tests**: Write assertions to validate responses

## Volumes

- `collections` - Directory for storing API collections (mounted from host)

## Common Tasks

### Import Postman Collections

```bash
# Click Collections → Import
# Select your Postman collection file
# Collections will be imported automatically
```

### Export Collections

```bash
# Click Collections → Export
# Choose JSON format
# Save to your collections directory
```

### Use Environment Variables

```bash
# Click Environments in the sidebar
# Create a new environment
# Add variables (e.g., base_url, api_key)
# Use {{variable_name}} in requests
```

### Generate Code Snippets

```bash
# After configuring a request
# Click the Code icon
# Select your target language
# Copy the generated code
```

## Features

- **Fast and Lightweight**: Minimal resource usage
- **Real-time Testing**: Instant API responses
- **WebSocket Support**: Test WebSocket connections
- **GraphQL Support**: Query and mutate GraphQL APIs
- **SSE Support**: Server-Sent Events testing
- **MQTT Support**: IoT protocol testing
- **Collections**: Organize requests into collections
- **Environments**: Manage variables across environments
- **History**: Access previous requests
- **Code Generation**: Generate code in multiple languages
- **Import/Export**: Compatible with Postman collections
- **Keyboard Shortcuts**: Efficient workflow
- **Dark Mode**: Easy on the eyes
- **PWA**: Install as a progressive web app

## Integration with Other Tools

### CI/CD Integration

```bash
# Export collections as JSON
# Use Hoppscotch CLI for automated testing
# Integrate with Jenkins, GitHub Actions, etc.
```

### Documentation

```bash
# Document your APIs within collections
# Add descriptions to requests
# Share collections with your team
```

## Troubleshooting

### Cannot Connect to API

- Check CORS settings on your API server
- Verify the API endpoint URL is correct
- Ensure your API server is running and accessible
- Try using the proxy feature for CORS issues

### Collections Not Saving

- Ensure the `collections` directory exists
- Check directory permissions
- Use browser local storage as backup
- Export collections regularly

### WebSocket Connection Failed

- Verify WebSocket URL format (ws:// or wss://)
- Check firewall settings
- Ensure WebSocket server is running
- Test with a simple WebSocket echo server

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Use HTTPS with a reverse proxy
- Restrict access with authentication
- Do not expose sensitive API keys in collections
- Use environment variables for secrets
- Regular backups of collections are recommended

## Resources

- [Hoppscotch Documentation](https://docs.hoppscotch.io/)
- [GitHub Repository](https://github.com/hoppscotch/hoppscotch)
- [Community Forum](https://github.com/hoppscotch/hoppscotch/discussions)
- [Docker Hub](https://hub.docker.com/r/hoppscotch/hoppscotch)
