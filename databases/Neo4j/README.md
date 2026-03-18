# Neo4j

Neo4j is the world's leading graph database platform. It's designed to store, query, and manage highly connected data using the property graph model. Neo4j excels at handling complex relationships and is ideal for use cases like social networks, recommendation engines, fraud detection, and knowledge graphs.

**Official Sites:**
- [Neo4j](https://neo4j.com/) | [Docker Hub](https://hub.docker.com/_/neo4j)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f neo4j.yaml up -d
```

## Services

### Neo4j
- **Browser URL**: http://localhost:7474
- **Bolt URL**: bolt://localhost:7687
- **Container**: `neo4j_container`
- **Username**: `neo4j`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure your settings
2. Change the default password (recommended for production)
3. Start the service with `docker compose -f neo4j.yaml up -d`
4. Navigate to http://localhost:7474
5. Login with the credentials configured in your `.env` file (default: neo4j/P@ss0rd123)
6. You'll be prompted to change the password on first login

## Configuration

### Environment Variables (.env)

- `NEO4J_HTTP_PORT` - HTTP browser interface port (default: 7474)
- `NEO4J_HTTPS_PORT` - HTTPS port (default: 7473)
- `NEO4J_BOLT_PORT` - Bolt protocol port for database connections (default: 7687)
- `NEO4J_AUTH` - Authentication in format username/password (change for production)
- `NEO4J_ACCEPT_LICENSE_AGREEMENT` - Accept license agreement (default: yes)
- `NEO4J_HEAP_INITIAL` - Initial heap size (default: 512m)
- `NEO4J_HEAP_MAX` - Maximum heap size (default: 1G)
- `NEO4J_PAGECACHE` - Page cache size (default: 512m)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

For advanced configuration, you can mount a custom neo4j.conf file:

```yaml
volumes:
  - ./neo4j.conf:/var/lib/neo4j/conf/neo4j.conf
  - neo4j-data:/data
```

## Connecting to Neo4j

### From Host Machine (Cypher Shell)

```bash
# Using cypher-shell inside container
docker exec -it neo4j_container cypher-shell -u neo4j -p P@ss0rd123

# Or install cypher-shell on host and connect
cypher-shell -a bolt://localhost:7687 -u neo4j -p P@ss0rd123
```

### From Application (Bolt Protocol)

#### Python (neo4j driver)

```python
from neo4j import GraphDatabase

driver = GraphDatabase.driver(
    "bolt://localhost:7687",
    auth=("neo4j", "P@ss0rd123")
)

with driver.session() as session:
    # Create a node
    result = session.run(
        "CREATE (p:Person {name: $name, age: $age}) RETURN p",
        name="Alice",
        age=30
    )
    
    # Query nodes
    result = session.run("MATCH (p:Person) RETURN p.name, p.age")
    for record in result:
        print(f"{record['p.name']}, {record['p.age']}")

driver.close()
```

#### JavaScript (neo4j-driver)

```javascript
const neo4j = require('neo4j-driver');

const driver = neo4j.driver(
    'bolt://localhost:7687',
    neo4j.auth.basic('neo4j', 'P@ss0rd123')
);

const session = driver.session();

// Create a node
session.run(
    'CREATE (p:Person {name: $name, age: $age}) RETURN p',
    { name: 'Alice', age: 30 }
).then(result => {
    console.log(result.records[0].get('p'));
    return session.close();
}).then(() => {
    return driver.close();
});
```

#### Java (neo4j-java-driver)

```java
import org.neo4j.driver.*;

public class Neo4jExample {
    public static void main(String[] args) {
        Driver driver = GraphDatabase.driver(
            "bolt://localhost:7687",
            AuthTokens.basic("neo4j", "P@ss0rd123")
        );
        
        try (Session session = driver.session()) {
            // Create a node
            session.run(
                "CREATE (p:Person {name: $name, age: $age}) RETURN p",
                Values.parameters("name", "Alice", "age", 30)
            );
            
            // Query nodes
            Result result = session.run("MATCH (p:Person) RETURN p.name, p.age");
            while (result.hasNext()) {
                Record record = result.next();
                System.out.println(record.get("p.name") + ", " + record.get("p.age"));
            }
        }
        
        driver.close();
    }
}
```

## Volumes

- `neo4j-data` - Graph database data storage
- `neo4j-logs` - Log files
- `neo4j-import` - Directory for importing CSV and other data files
- `neo4j-plugins` - Custom plugins and extensions

## Cypher Query Examples

### Create Nodes

```cypher
// Create a single node
CREATE (p:Person {name: 'Alice', age: 30})
RETURN p

// Create multiple nodes
CREATE (p1:Person {name: 'Bob', age: 25}),
       (p2:Person {name: 'Charlie', age: 35})
RETURN p1, p2

// Create nodes with multiple labels
CREATE (p:Person:Employee {name: 'David', age: 28, department: 'Engineering'})
RETURN p
```

### Create Relationships

```cypher
// Create relationship between existing nodes
MATCH (a:Person {name: 'Alice'}), (b:Person {name: 'Bob'})
CREATE (a)-[r:KNOWS {since: 2020}]->(b)
RETURN a, r, b

// Create nodes and relationships in one query
CREATE (a:Person {name: 'Eve'})-[r:WORKS_WITH]->(b:Person {name: 'Frank'})
RETURN a, r, b
```

### Query Data

```cypher
// Find all persons
MATCH (p:Person)
RETURN p

// Find persons by property
MATCH (p:Person {name: 'Alice'})
RETURN p

// Find relationships
MATCH (a:Person)-[r:KNOWS]->(b:Person)
RETURN a.name, b.name, r.since

// Find paths
MATCH path = (a:Person {name: 'Alice'})-[:KNOWS*1..3]-(b:Person)
RETURN path

// Aggregate queries
MATCH (p:Person)
RETURN avg(p.age) AS averageAge, count(p) AS totalPersons
```

### Update Data

```cypher
// Update node properties
MATCH (p:Person {name: 'Alice'})
SET p.age = 31, p.city = 'New York'
RETURN p

// Add labels
MATCH (p:Person {name: 'Bob'})
SET p:Manager
RETURN p

// Update relationships
MATCH (a:Person {name: 'Alice'})-[r:KNOWS]->(b:Person {name: 'Bob'})
SET r.strength = 'strong'
RETURN r
```

### Delete Data

```cypher
// Delete a node (must delete relationships first)
MATCH (p:Person {name: 'Alice'})
DETACH DELETE p

// Delete relationships only
MATCH (a:Person {name: 'Bob'})-[r:KNOWS]->(b:Person)
DELETE r

// Delete all data (use with caution!)
MATCH (n)
DETACH DELETE n
```

### Advanced Queries

```cypher
// Shortest path
MATCH path = shortestPath(
  (a:Person {name: 'Alice'})-[:KNOWS*]-(b:Person {name: 'Charlie'})
)
RETURN path

// Recommendation query
MATCH (p:Person {name: 'Alice'})-[:KNOWS]->(friend)-[:LIKES]->(item)
WHERE NOT (p)-[:LIKES]->(item)
RETURN item.name, count(*) AS recommendations
ORDER BY recommendations DESC

// Pattern matching with WHERE
MATCH (p:Person)-[r:KNOWS]->(friend)
WHERE p.age > 25 AND r.since > 2019
RETURN p.name, friend.name, r.since
```

## Common Tasks

### Import CSV Data

```bash
# Copy CSV file to import directory
docker cp data.csv neo4j_container:/var/lib/neo4j/import/

# Import using Cypher
docker exec -it neo4j_container cypher-shell -u neo4j -p P@ss0rd123 \
  "LOAD CSV WITH HEADERS FROM 'file:///data.csv' AS row
   CREATE (p:Person {name: row.name, age: toInteger(row.age)})"
```

### Backup Database

```bash
# Stop the database
docker compose -f neo4j.yaml stop

# Backup data directory
docker run --rm -v neo4j-data:/data -v $(pwd):/backup ubuntu \
  tar czf /backup/neo4j-backup.tar.gz /data

# Start the database
docker compose -f neo4j.yaml start
```

### Restore Database

```bash
# Stop the database
docker compose -f neo4j.yaml stop

# Restore data directory
docker run --rm -v neo4j-data:/data -v $(pwd):/backup ubuntu \
  tar xzf /backup/neo4j-backup.tar.gz -C /

# Start the database
docker compose -f neo4j.yaml start
```

### View Database Statistics

```cypher
// Count nodes by label
MATCH (n)
RETURN labels(n) AS label, count(*) AS count
ORDER BY count DESC

// Count relationships by type
MATCH ()-[r]->()
RETURN type(r) AS type, count(*) AS count
ORDER BY count DESC

// Database size
CALL dbms.queryJmx("org.neo4j:instance=kernel#0,name=Store file sizes")
YIELD attributes
RETURN attributes.TotalStoreSize.value AS totalSize
```

### Access Neo4j Browser

Navigate to http://localhost:7474 in your web browser to access the Neo4j Browser interface, which provides:
- Interactive Cypher query editor
- Visual graph exploration
- Query result visualization
- Database statistics and monitoring
- Built-in guides and tutorials

### View Logs

```bash
docker logs neo4j_container
```

### Execute Cypher from File

```bash
# Create a Cypher script file
cat > queries.cypher << 'EOF'
CREATE (p:Person {name: 'Alice', age: 30});
CREATE (p:Person {name: 'Bob', age: 25});
MATCH (a:Person {name: 'Alice'}), (b:Person {name: 'Bob'})
CREATE (a)-[:KNOWS]->(b);
EOF

# Execute the script
docker exec -i neo4j_container cypher-shell -u neo4j -p P@ss0rd123 < queries.cypher
```

## Features

- **Property Graph Model**: Store data as nodes, relationships, and properties
- **Cypher Query Language**: Intuitive and powerful graph query language
- **ACID Transactions**: Full transactional support for data integrity
- **Native Graph Storage**: Optimized storage engine for graph traversals
- **Indexing**: Support for indexes and constraints on nodes and relationships
- **High Performance**: Efficient traversal of millions of relationships per second
- **Scalability**: Horizontal scaling with Neo4j Causal Clustering (Enterprise)
- **Browser Interface**: Built-in web interface for data exploration and visualization
- **Multiple Language Drivers**: Official drivers for Python, Java, JavaScript, .NET, Go, and more
- **APOC Library**: Extensive library of procedures and functions for common tasks
- **Graph Algorithms**: Built-in support for graph algorithms (shortest path, PageRank, etc.)
- **Full-Text Search**: Integrated full-text search capabilities

## Troubleshooting

### Container Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs neo4j_container`. Ensure the authentication format is correct (username/password) and volumes have proper permissions.

### Cannot Access Browser

- **Symptoms**: Connection refused on port 7474
- **Solution**: Verify the container is running with `docker ps`. Check that port 7474 is not in use by another service. Wait a few seconds for Neo4j to fully start.

### Authentication Failed

- **Symptoms**: "Invalid username or password" error
- **Solution**: Verify your credentials are correct. The default is neo4j/P@ss0rd123. Check the NEO4J_AUTH environment variable format.

### Out of Memory Errors

- **Symptoms**: Container crashes or queries fail with memory errors
- **Solution**: Increase heap size and page cache in the .env file. Adjust NEO4J_HEAP_MAX and NEO4J_PAGECACHE based on your available memory.

### Slow Query Performance

- **Symptoms**: Queries take a long time to execute
- **Solution**: Create indexes on frequently queried properties. Use EXPLAIN and PROFILE to analyze query plans. Consider increasing page cache size.

### Data Not Persisting

- **Symptoms**: Data lost after container restart
- **Solution**: Ensure volumes are properly mounted. Check volume permissions with `docker volume inspect neo4j-data`.

### Connection Timeout

- **Symptoms**: "Unable to connect to bolt://localhost:7687"
- **Solution**: Verify the Bolt port (7687) is exposed and not blocked by firewall. Check that the container is running and healthy.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change the default password immediately (neo4j will prompt on first login)
- Use strong passwords with mixed case, numbers, and special characters
- Use HTTPS with a reverse proxy (nginx, Traefik, Caddy)
- Restrict network access with firewall rules
- Enable authentication and role-based access control
- Regular backups are essential for production data
- Consider using Neo4j Enterprise for additional security features
- Keep Neo4j updated to the latest stable version
- Monitor logs for suspicious activity
- Use encrypted connections (Bolt+TLS) for production

## Resources

- [Official Documentation](https://neo4j.com/docs/)
- [Cypher Query Language Reference](https://neo4j.com/docs/cypher-manual/current/)
- [Neo4j Browser Guide](https://neo4j.com/docs/browser-manual/current/)
- [Graph Data Modeling](https://neo4j.com/developer/data-modeling/)
- [Docker Hub](https://hub.docker.com/_/neo4j)
- [Neo4j Community Forum](https://community.neo4j.com/)
- [GitHub Repository](https://github.com/neo4j/neo4j)
- [APOC Documentation](https://neo4j.com/labs/apoc/)
- [Graph Algorithms](https://neo4j.com/docs/graph-data-science/current/)
