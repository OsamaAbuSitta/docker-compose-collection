# MockServer

A powerful tool for mocking HTTP and HTTPS services. MockServer enables you to mock any server or service via HTTP or HTTPS, including REST, RPC, and SOAP services. It provides advanced request matching, verification, and expectation management.

**Official Sites:**
- [MockServer](https://www.mock-server.com/) | [Docker Hub](https://hub.docker.com/r/mockserver/mockserver)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env

# Create config directory
mkdir -p config

# Start the service
docker compose -f mockserver.yaml up -d
```

## Services

### MockServer
- **URL**: http://localhost:1080
- **Dashboard**: http://localhost:1080/mockserver/dashboard
- **Container**: `mockserver`
- **Note**: No authentication required by default

## Initial Setup

1. Copy `.env.example` to `.env` and configure if needed
2. Create `config/` directory for initialization files
3. Start the service with `docker compose -f mockserver.yaml up -d`
4. Navigate to http://localhost:1080/mockserver/dashboard to view the dashboard
5. Create expectations via API or initialization file

## Configuration

### Environment Variables (.env)

- `MOCKSERVER_PORT` - Server port (default: 1080)
- `TZ` - Timezone
- `CONFIG_DIR` - Directory for configuration files (default: ./config)

### Initialization File

Create `config/initializerJson.json` to define expectations on startup:

```json
[
  {
    "httpRequest": {
      "method": "GET",
      "path": "/api/hello"
    },
    "httpResponse": {
      "statusCode": 200,
      "body": "Hello, World!"
    }
  }
]
```

## Creating Expectations

### Simple GET Expectation

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/users"
    },
    "httpResponse": {
      "statusCode": 200,
      "body": "{\"users\": []}",
      "headers": {
        "Content-Type": ["application/json"]
      }
    }
  }'
```

Test it:
```bash
curl http://localhost:1080/api/users
```

### Path Parameter Matching

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/users/{id}",
      "pathParameters": {
        "id": ["[0-9]+"]
      }
    },
    "httpResponse": {
      "statusCode": 200,
      "body": "{\"id\": 1, \"name\": \"John Doe\"}",
      "headers": {
        "Content-Type": ["application/json"]
      }
    }
  }'
```

### Query Parameter Matching

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/search",
      "queryStringParameters": {
        "q": [".*"],
        "limit": ["10"]
      }
    },
    "httpResponse": {
      "statusCode": 200,
      "body": "{\"results\": [], \"total\": 0}"
    }
  }'
```

### POST with Body Matching

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "POST",
      "path": "/api/users",
      "body": {
        "type": "JSON",
        "json": {
          "name": ".*",
          "email": ".*@.*"
        },
        "matchType": "MATCHES"
      }
    },
    "httpResponse": {
      "statusCode": 201,
      "body": "{\"id\": 123, \"message\": \"User created\"}",
      "headers": {
        "Content-Type": ["application/json"],
        "Location": ["/api/users/123"]
      }
    }
  }'
```

### Header Matching

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/protected",
      "headers": {
        "Authorization": ["Bearer .*"]
      }
    },
    "httpResponse": {
      "statusCode": 200,
      "body": "{\"message\": \"Authorized\"}"
    }
  }'
```

### Response with Delay

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/slow"
    },
    "httpResponse": {
      "statusCode": 200,
      "body": "Delayed response",
      "delay": {
        "timeUnit": "SECONDS",
        "value": 3
      }
    }
  }'
```

### Error Response

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/error"
    },
    "httpResponse": {
      "statusCode": 500,
      "body": "{\"error\": \"Internal Server Error\"}",
      "headers": {
        "Content-Type": ["application/json"]
      }
    }
  }'
```

### Response Template

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/echo"
    },
    "httpResponseTemplate": {
      "template": "{\"path\": \"$!request.path\", \"method\": \"$!request.method\"}",
      "templateType": "VELOCITY"
    }
  }'
```

## Request Verification

### Verify Request Was Made

```bash
curl -X PUT http://localhost:1080/mockserver/verify \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "GET",
      "path": "/api/users"
    }
  }'
```

### Verify Request Count

```bash
curl -X PUT http://localhost:1080/mockserver/verify \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "POST",
      "path": "/api/users"
    },
    "times": {
      "atLeast": 1,
      "atMost": 3
    }
  }'
```

### Verify Request Sequence

```bash
curl -X PUT http://localhost:1080/mockserver/verifySequence \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequests": [
      {
        "method": "POST",
        "path": "/api/login"
      },
      {
        "method": "GET",
        "path": "/api/profile"
      }
    ]
  }'
```

## Retrieving Requests

### Get All Recorded Requests

```bash
curl -X PUT http://localhost:1080/mockserver/retrieve \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "path": "/api/.*"
    }
  }'
```

### Get Active Expectations

```bash
curl -X PUT http://localhost:1080/mockserver/retrieve \
  -H "Content-Type: application/json" \
  -d '{
    "format": "JSON"
  }'
```

## Management Operations

### Clear All Expectations

```bash
curl -X PUT http://localhost:1080/mockserver/clear \
  -H "Content-Type: application/json" \
  -d '{
    "type": "EXPECTATIONS"
  }'
```

### Clear Specific Expectation

```bash
curl -X PUT http://localhost:1080/mockserver/clear \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "path": "/api/users"
    }
  }'
```

### Clear Request Log

```bash
curl -X PUT http://localhost:1080/mockserver/clear \
  -H "Content-Type: application/json" \
  -d '{
    "type": "LOG"
  }'
```

### Reset MockServer

```bash
curl -X PUT http://localhost:1080/mockserver/reset
```

## Advanced Features

### Times Limit

Limit how many times an expectation matches:

```json
{
  "httpRequest": {
    "path": "/api/limited"
  },
  "httpResponse": {
    "body": "Available"
  },
  "times": {
    "remainingTimes": 3,
    "unlimited": false
  }
}
```

### Time to Live

Set expiration for expectations:

```json
{
  "httpRequest": {
    "path": "/api/temporary"
  },
  "httpResponse": {
    "body": "Temporary response"
  },
  "timeToLive": {
    "timeUnit": "MINUTES",
    "timeToLive": 5,
    "unlimited": false
  }
}
```

### Priority

Control matching order (higher number = higher priority):

```json
{
  "priority": 10,
  "httpRequest": {
    "path": "/api/special"
  },
  "httpResponse": {
    "body": "Special case"
  }
}
```

### Forward Requests

Forward unmatched requests to another server:

```bash
curl -X PUT http://localhost:1080/mockserver/expectation \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "path": "/api/.*"
    },
    "httpForward": {
      "host": "api.example.com",
      "port": 443,
      "scheme": "HTTPS"
    }
  }'
```

### Callback

Execute callback for matched requests:

```json
{
  "httpRequest": {
    "path": "/api/callback"
  },
  "httpResponseCallback": {
    "callbackClass": "com.example.MyCallback"
  }
}
```

## Client Libraries

MockServer provides client libraries for multiple languages:

### Java

```java
MockServerClient mockServer = new MockServerClient("localhost", 1080);

mockServer
    .when(request().withPath("/api/users"))
    .respond(response().withStatusCode(200).withBody("[]"));
```

### JavaScript/Node.js

```javascript
const mockServerClient = require('mockserver-client').mockServerClient;

mockServerClient("localhost", 1080)
  .mockAnyResponse({
    httpRequest: {
      path: '/api/users'
    },
    httpResponse: {
      statusCode: 200,
      body: JSON.stringify([])
    }
  });
```

### Python

```python
from mockserver import MockServerClient

client = MockServerClient("localhost", 1080)

client.stub(
    request={"method": "GET", "path": "/api/users"},
    response={"statusCode": 200, "body": "[]"}
)
```

## Common Use Cases

### Mock REST API

```json
{
  "httpRequest": {
    "method": "GET",
    "path": "/api/products/{id}"
  },
  "httpResponse": {
    "statusCode": 200,
    "body": "{\"id\": \"${id}\", \"name\": \"Product\", \"price\": 99.99}"
  }
}
```

### Simulate Authentication

```json
{
  "httpRequest": {
    "method": "POST",
    "path": "/api/login",
    "body": {
      "type": "JSON",
      "json": {
        "username": "admin",
        "password": "password"
      }
    }
  },
  "httpResponse": {
    "statusCode": 200,
    "body": "{\"token\": \"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...\"}"
  }
}
```

### Test Error Scenarios

```json
{
  "httpRequest": {
    "path": "/api/flaky"
  },
  "httpResponse": {
    "statusCode": 503,
    "body": "{\"error\": \"Service temporarily unavailable\"}"
  }
}
```

### Integration Testing

Use verification to ensure your application makes expected calls:

```bash
# After running tests
curl -X PUT http://localhost:1080/mockserver/verify \
  -H "Content-Type: application/json" \
  -d '{
    "httpRequest": {
      "method": "POST",
      "path": "/api/orders"
    },
    "times": {
      "atLeast": 1
    }
  }'
```

## Troubleshooting

### Expectation Not Matching

- **Symptoms**: Requests return 404 or unexpected responses
- **Solution**: Check the dashboard at `/mockserver/dashboard` to see active expectations. Use retrieve API to see recorded requests. Verify path, method, and matching criteria.

### Cannot Access Dashboard

- **Symptoms**: Dashboard page not loading
- **Solution**: Ensure container is running. Check logs with `docker logs mockserver`. Verify port is accessible.

### Initialization File Not Loading

- **Symptoms**: Expectations from initializerJson.json not available
- **Solution**: Verify the `config/` directory is correctly mounted. Check JSON syntax. Restart the container.

### Port Already in Use

- **Symptoms**: Container fails to start with port binding error
- **Solution**: Change `MOCKSERVER_PORT` in `.env` file to an available port.

## Features

- **HTTP/HTTPS Mocking**: Mock any HTTP-based service
- **Advanced Matching**: Path, query, headers, body, cookies
- **Request Verification**: Verify expected requests were made
- **Response Templates**: Dynamic responses using Velocity
- **Request Forwarding**: Proxy unmatched requests
- **Delays and Errors**: Simulate network conditions
- **Dashboard UI**: Visual interface for managing expectations
- **Client Libraries**: Java, JavaScript, Python, Ruby, etc.
- **Hot Reload**: Watch initialization file for changes
- **Request Recording**: Record and replay requests
- **OpenAPI Integration**: Generate expectations from OpenAPI specs

## Security Notes

⚠️ **Important**: MockServer is designed for testing and development. For production use:
- Enable authentication
- Restrict network access
- Use HTTPS for sensitive data
- Do not expose publicly without proper security

## Resources

- [Official Documentation](https://www.mock-server.com/)
- [Expectations](https://www.mock-server.com/mock_server/creating_expectations.html)
- [Request Matching](https://www.mock-server.com/mock_server/getting_started.html#request_matchers)
- [Verification](https://www.mock-server.com/mock_server/verification.html)
- [Client Libraries](https://www.mock-server.com/mock_server/mockserver_clients.html)
- [Docker Hub](https://hub.docker.com/r/mockserver/mockserver)
