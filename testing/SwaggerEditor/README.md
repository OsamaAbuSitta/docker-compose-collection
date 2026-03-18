# Swagger Editor

A browser-based editor for designing and documenting RESTful APIs using the OpenAPI Specification (formerly Swagger Specification). Swagger Editor provides real-time validation, syntax highlighting, and preview of your API documentation.

**Official Sites:**
- [Swagger Editor](https://swagger.io/tools/swagger-editor/) | [Docker Hub](https://hub.docker.com/r/swaggerapi/swagger-editor)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f swagger-editor.yaml up -d
```

## Services

### Swagger Editor
- **URL**: http://localhost:8081
- **Container**: `swagger-editor`
- **Description**: Web-based OpenAPI/Swagger specification editor

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Create a `specs` directory for your OpenAPI files
3. Start the service with `docker compose -f swagger-editor.yaml up -d`
4. Navigate to http://localhost:8081
5. Start designing your API or load an existing specification

## Configuration

### Environment Variables (.env)

- `SWAGGER_PORT` - Web interface port (default: 8081)
- `TZ` - Timezone for the container (default: UTC)
- `SPECS_DIR` - Directory for OpenAPI specification files (default: ./specs)

### Custom Configuration

The editor runs entirely in the browser, so no server-side configuration is needed. Your specifications can be saved locally or exported.

## Using Swagger Editor

### Creating a New API

1. Open the editor in your browser
2. Start with the default template or clear it
3. Write your OpenAPI specification in YAML or JSON
4. The editor provides real-time validation and preview

### Loading Existing Specifications

1. Click **File** → **Import File**
2. Select your OpenAPI/Swagger file
3. Edit and validate your specification
4. Export when complete

### Saving Specifications

- **Download**: File → Download as YAML/JSON
- **Volume Mount**: Save files to the mounted `specs` directory

## Volumes

- `specs` - Directory for storing OpenAPI specification files (mounted from host)

## Common Tasks

### Validate an OpenAPI Specification

```bash
# Place your spec file in the specs directory
# Open the editor and import the file
# Validation errors will appear in real-time
```

### Generate Server/Client Code

```bash
# Use the "Generate Server" or "Generate Client" options
# Select your target language/framework
# Download the generated code
```

### Export Documentation

```bash
# File → Download as YAML or JSON
# Or use the Swagger UI for rendered documentation
```

## Features

- **Real-time Validation**: Instant feedback on specification errors
- **Syntax Highlighting**: Color-coded YAML/JSON editing
- **Auto-completion**: Smart suggestions for OpenAPI keywords
- **Live Preview**: See your API documentation as you type
- **Import/Export**: Load and save specifications in multiple formats
- **Code Generation**: Generate server stubs and client SDKs
- **OpenAPI 3.0 Support**: Full support for the latest specification

## Integration with Other Tools

### Swagger UI

To view your API documentation with Swagger UI:

```bash
# Export your specification from the editor
# Use Swagger UI to render the documentation
# See the Swagger UI service in this repository
```

### API Testing

After designing your API:
- Export the specification
- Use tools like Postman, Hoppscotch, or Insomnia
- Import the OpenAPI spec for automated testing

## Troubleshooting

### Editor Not Loading

- Check that port 8081 is not in use
- Verify the container is running: `docker ps`
- Check logs: `docker logs swagger-editor`

### Specifications Not Persisting

- Ensure the `specs` directory exists and has proper permissions
- Save files explicitly to the mounted volume
- Use File → Download to save locally

### Validation Errors

- Ensure your specification follows OpenAPI 3.0 or 2.0 format
- Check for proper YAML/JSON syntax
- Review the error messages in the editor

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Use HTTPS with a reverse proxy (nginx, Traefik)
- Restrict access with authentication
- Do not expose the editor publicly without protection
- Keep your API specifications secure

## Resources

- [OpenAPI Specification](https://swagger.io/specification/)
- [Swagger Editor Documentation](https://swagger.io/docs/open-source-tools/swagger-editor/)
- [OpenAPI Guide](https://swagger.io/docs/specification/about/)
- [Docker Hub](https://hub.docker.com/r/swaggerapi/swagger-editor)
