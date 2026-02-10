# WireMock

A flexible API mocking tool for stubbing and mocking web services. WireMock allows you to simulate HTTP-based APIs for testing, development, and integration scenarios.

**Official Sites:**
- [WireMock](https://wiremock.org/) | [Docker Hub](https://hub.docker.com/r/wiremock/wiremock)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Create mappings directory
mkdir -p mappings __files

# Start the service
docker compose -f wiremock.yaml up -d
```

## Services

### WireMock
- **URL**: http://localhost:8080
- **Admin API**: http://localhost:8080/__admin
- **Container**: `wiremock`
- **Note**: No authentication required by default

## Initial Setup

1. Copy `.env.example` to `.env` and configure if needed
2. Create `mappings/` directory for stub definitions
3. Create `__files/` directory for response body files
4. Start the service with `docker compose -f wiremock.yaml up -d`
5. Navigate to http://localhost:8080/__admin to verify it's running

## Configuration

### Environment Variables (.env)

- `WIREMOCK_PORT` - Web interface and API port (default: 8080)
- `TZ` - Timezone
- `MAPPINGS_DIR` - Directory for stub mappings (default: ./mappings)
- `FILES_DIR` - Directory for response files (default: ./files)

### Directory Structure

```
testing/WireMock/
├── wiremock.yaml
├── .env.example
├── mappings/          # Stub definitions (JSON)
│   ├── hello.json
│   └── users.json
└── __files/           # Response body files
    ├── user-response.json
    └── error-response.xml
```

## Creating Stubs

### Simple GET Stub

Create `mappings/hello.json`:

```json
{
  "request": {
    "method": "GET",
    "url": "/api/hello"
  },
  "response": {
    "status": 200,
    "body": "Hello, World!",
    "headers": {
      "Content-Type": "text/plain"
    }
  }
}
```

Test it:
```bash
curl http://localhost:8080/api/hello
```

### JSON Response Stub

Create `mappings/user.json`:

```json
{
  "request": {
    "method": "GET",
    "urlPattern": "/api/users/([0-9]+)"
  },
  "response": {
    "status": 200,
    "jsonBody": {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com"
    },
    "headers": {
      "Content-Type": "application/json"
    }
  }
}
```

### POST Stub with Request Matching

Create `mappings/create-user.json`:

```json
{
  "request": {
    "method": "POST",
    "url": "/api/users",
    "headers": {
      "Content-Type": {
        "contains": "application/json"
      }
    },
    "bodyPatterns": [
      {
        "matchesJsonPath": "$.name"
      }
    ]
  },
  "response": {
    "status": 201,
    "jsonBody": {
      "id": 123,
      "message": "User created successfully"
    },
    "headers": {
      "Content-Type": "application/json",
      "Location": "/api/users/123"
    }
  }
}
```

### Response from File

Create `__files/large-response.json`:

```json
{
  "users": [
    {"id": 1, "name": "Alice"},
    {"id": 2, "name": "Bob"},
    {"id": 3, "name": "Charlie"}
  ]
}
```

Create `mappings/users-list.json`:

```json
{
  "request": {
    "method": "GET",
    "url": "/api/users"
  },
  "response": {
    "status": 200,
    "bodyFileName": "large-response.json",
    "headers": {
      "Content-Type": "application/json"
    }
  }
}
```

### Delayed Response

```json
{
  "request": {
    "method": "GET",
    "url": "/api/slow"
  },
  "response": {
    "status": 200,
    "body": "This took a while",
    "fixedDelayMilliseconds": 3000
  }
}
```

### Error Response

```json
{
  "request": {
    "method": "GET",
    "url": "/api/error"
  },
  "response": {
    "status": 500,
    "jsonBody": {
      "error": "Internal Server Error",
      "message": "Something went wrong"
    }
  }
}
```

### Response Templating

Create `mappings/templated.json`:

```json
{
  "request": {
    "method": "GET",
    "urlPattern": "/api/users/([0-9]+)"
  },
  "response": {
    "status": 200,
    "body": "{\"id\": {{request.path.[2]}}, \"timestamp\": \"{{now}}\"}",
    "headers": {
      "Content-Type": "application/json"
    },
    "transformers": ["response-template"]
  }
}
```

## Admin API

### List All Mappings

```bash
curl http://localhost:8080/__admin/mappings
```

### Create Mapping via API

```bash
curl -X POST http://localhost:8080/__admin/mappings \
  -H "Content-Type: application/json" \
  -d '{
    "request": {
      "method": "GET",
      "url": "/api/test"
    },
    "response": {
      "status": 200,
      "body": "Test response"
    }
  }'
```

### Delete All Mappings

```bash
curl -X DELETE http://localhost:8080/__admin/mappings
```

### Reset to Default Mappings

```bash
curl -X POST http://localhost:8080/__admin/mappings/reset
```

### View Request Journal

```bash
curl http://localhost:8080/__admin/requests
```

### Find Unmatched Requests

```bash
curl http://localhost:8080/__admin/requests/unmatched
```

## Advanced Features

### Priority

Control stub matching order with priority (lower number = higher priority):

```json
{
  "priority": 1,
  "request": {
    "method": "GET",
    "url": "/api/special"
  },
  "response": {
    "status": 200,
    "body": "Special case"
  }
}
```

### Scenarios (Stateful Behavior)

```json
{
  "scenarioName": "user-creation",
  "requiredScenarioState": "Started",
  "newScenarioState": "User Created",
  "request": {
    "method": "POST",
    "url": "/api/users"
  },
  "response": {
    "status": 201
  }
}
```

### Request Matching

Match requests by:
- URL (exact, pattern, path)
- Headers
- Query parameters
- Request body (JSON, XML, text)
- Cookies
- Basic authentication

### Response Features

- Status codes
- Headers
- Body (inline, from file)
- Delays (fixed, random)
- Faults (connection reset, empty response)
- Chunked encoding
- Response templating

## Common Use Cases

### Mock External API

Replace external API calls during development:

```json
{
  "request": {
    "method": "GET",
    "urlPattern": "/api/weather/.*"
  },
  "response": {
    "status": 200,
    "jsonBody": {
      "temperature": 72,
      "condition": "sunny"
    }
  }
}
```

### Test Error Handling

Simulate various error conditions:

```json
{
  "request": {
    "method": "GET",
    "url": "/api/flaky"
  },
  "response": {
    "status": 503,
    "body": "Service Unavailable"
  }
}
```

### Integration Testing

Create predictable responses for automated tests:

```json
{
  "request": {
    "method": "POST",
    "url": "/api/payment",
    "bodyPatterns": [
      {
        "matchesJsonPath": "$.amount[?(@.value > 100)]"
      }
    ]
  },
  "response": {
    "status": 200,
    "jsonBody": {
      "status": "approved",
      "transactionId": "TXN-12345"
    }
  }
}
```

## Troubleshooting

### Stub Not Matching

- **Symptoms**: Requests return 404 or unexpected responses
- **Solution**: Check request journal at `/__admin/requests` to see what WireMock received. Verify URL patterns and request matching criteria.

### Mappings Not Loading

- **Symptoms**: Stubs defined in files are not available
- **Solution**: Verify the `mappings/` directory is correctly mounted. Check file permissions. Restart the container.

### Response File Not Found

- **Symptoms**: Error about missing body file
- **Solution**: Ensure the file exists in `__files/` directory. Check the `bodyFileName` matches exactly (case-sensitive).

### Port Already in Use

- **Symptoms**: Container fails to start with port binding error
- **Solution**: Change `WIREMOCK_PORT` in `.env` file to an available port.

## Features

- **HTTP/HTTPS Mocking**: Stub any HTTP-based API
- **Request Matching**: Flexible matching by URL, headers, body, etc.
- **Response Templating**: Dynamic responses using Handlebars
- **Stateful Behavior**: Scenarios for multi-step interactions
- **Request Verification**: Check if expected requests were made
- **Delays and Faults**: Simulate network issues
- **Admin API**: Programmatic control of stubs
- **Request Journal**: Record and inspect all requests
- **File-Based Configuration**: Define stubs as JSON files
- **Hot Reload**: Changes to mappings are detected automatically

## Security Notes

⚠️ **Important**: WireMock is designed for testing and development. For production use:
- Enable authentication on the admin API
- Restrict network access
- Use HTTPS for sensitive data
- Do not expose publicly without proper security

## Resources

- [Official Documentation](https://wiremock.org/docs/)
- [Request Matching](https://wiremock.org/docs/request-matching/)
- [Response Templating](https://wiremock.org/docs/response-templating/)
- [Admin API Reference](https://wiremock.org/docs/api/)
- [Docker Hub](https://hub.docker.com/r/wiremock/wiremock)
