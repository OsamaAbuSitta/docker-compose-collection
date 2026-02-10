# Trilium Notes

A hierarchical note-taking application with focus on building large personal knowledge bases. Trilium features rich WYSIWYG editing, code notes with syntax highlighting, and powerful note organization with relations and attributes.

**Official Sites:**
- [Trilium Notes](https://github.com/zadam/trilium) | [Docker Hub](https://hub.docker.com/r/zadam/trilium)

## Quick Start

```bash
docker compose -f trilium-notes.yaml up -d
```

## Services

### Trilium Notes
- **URL**: http://localhost:8080
- **Container**: `trilium_notes`
- **Note**: Set password on first visit

## Initial Setup

1. Start the service with `docker compose -f trilium-notes.yaml up -d`
2. Navigate to http://localhost:8080
3. Set your password for the application
4. Start creating your note hierarchy
5. Explore the demo notes to learn features

## Volumes

- `trilium-data` - All notes, attachments, and application data

## Common Tasks

### Create a New Note

1. Click the "+" button or press Ctrl+O
2. Enter note title
3. Choose note type (text, code, relation map, etc.)
4. Start writing

### Organize Notes with Relations

```bash
# Use the relation editor in the UI
# Create parent-child relationships
# Add custom relations between notes
# Use attributes for metadata
```

### Backup Notes

```bash
# Backup the data volume
docker run --rm -v trilium-data:/data -v $(pwd):/backup alpine tar czf /backup/trilium-backup.tar.gz /data
```

### Restore Notes

```bash
# Restore from backup
docker run --rm -v trilium-data:/data -v $(pwd):/backup alpine tar xzf /backup/trilium-backup.tar.gz -C /
```

### Export Notes

Use the built-in export feature:
1. Right-click on a note
2. Select "Export"
3. Choose format (HTML, Markdown, OPML)

### Sync Between Devices

Trilium supports server-client sync:
1. Run Trilium server (this Docker setup)
2. Install Trilium desktop client
3. Configure sync in client settings
4. Enter server URL and credentials

## Configuration

### Environment Variables

- `TRILIUM_DATA_DIR` - Directory for storing notes and data

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "3000:8080"  # Access on port 3000 instead
```

### Password Protection

Password is set on first access. To reset:

```bash
docker exec trilium_notes node src/tools/reset_password.js
```

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:8080
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### Notes Not Saving

- **Symptoms**: Changes are lost after restart
- **Solution**: Verify the volume is properly mounted. Check container logs with `docker logs trilium_notes`.

### Forgot Password

- **Symptoms**: Cannot log in
- **Solution**: Reset password using the command above.

### Sync Issues

- **Symptoms**: Desktop client cannot sync
- **Solution**: Verify server is accessible. Check sync credentials and server URL.

## Features

- **Hierarchical Notes**: Organize notes in a tree structure
- **Rich Text Editor**: WYSIWYG editing with formatting
- **Code Notes**: Syntax highlighting for multiple languages
- **Note Relations**: Create connections between notes
- **Attributes**: Add metadata and custom properties
- **Full-Text Search**: Fast search across all notes
- **Note Encryption**: Protect sensitive notes
- **Scripting**: Automate with JavaScript
- **Web Clipper**: Save web pages as notes
- **Sync**: Synchronize across devices

## Security Notes

⚠️ **Important**: For production/remote access:
- Use a strong password
- Enable HTTPS with a reverse proxy
- Use note encryption for sensitive content
- Restrict access with firewall rules
- Regular backups are essential

## Resources

- [Official Documentation](https://github.com/zadam/trilium/wiki)
- [GitHub Repository](https://github.com/zadam/trilium)
- [Docker Hub](https://hub.docker.com/r/zadam/trilium)
- [Demo Instance](https://trilium.cc/demo)
