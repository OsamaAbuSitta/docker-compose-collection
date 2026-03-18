# Memos

A privacy-first, lightweight note-taking service. Memos is designed for quickly capturing and organizing thoughts with a clean, minimalist interface inspired by Flomo and Twitter.

**Official Sites:**
- [Memos](https://usememos.com/) | [Docker Hub](https://hub.docker.com/r/neosmemo/memos)

## Quick Start

```bash
docker compose -f memos.yaml up -d
```

## Services

### Memos
- **URL**: http://localhost:5230
- **Container**: `memos`
- **Note**: Create admin account on first visit

## Initial Setup

1. Start the service with `docker compose -f memos.yaml up -d`
2. Navigate to http://localhost:5230
3. Create your admin account
4. Start creating memos
5. Explore tags and filters for organization

## Volumes

- `memos-data` - All memos and application data (SQLite database)

## Common Tasks

### Create a Memo

1. Click the text area at the top
2. Type your memo (supports Markdown)
3. Press Ctrl+Enter or click "Save" to create
4. Add tags with #hashtag syntax

### Organize with Tags

```bash
# Use hashtags in your memos
#work #personal #ideas

# Filter by tags in the sidebar
# Click on a tag to view all related memos
```

### Search Memos

Use the search bar to find memos by:
- Content text
- Tags
- Date ranges

### Share a Memo

1. Click on a memo
2. Click the share icon
3. Copy the public link
4. Share with others (memo becomes publicly accessible)

### Backup Memos

```bash
# Backup the data volume
docker run --rm -v memos-data:/data -v $(pwd):/backup alpine tar czf /backup/memos-backup.tar.gz /data
```

### Restore Memos

```bash
# Restore from backup
docker run --rm -v memos-data:/data -v $(pwd):/backup alpine tar xzf /backup/memos-backup.tar.gz -C /
```

### Export Memos

Use the built-in export feature:
1. Go to Settings
2. Navigate to Data section
3. Click "Export" to download all memos

## Configuration

### Environment Variables

- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "8080:5230"  # Access on port 8080 instead
```

### Database Location

Memos uses SQLite by default. The database is stored in the mounted volume at `/var/opt/memos`.

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:5230
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### Memos Not Saving

- **Symptoms**: Memos disappear after restart
- **Solution**: Verify the volume is properly mounted. Check container logs with `docker logs memos`.

### Forgot Password

- **Symptoms**: Cannot log in
- **Solution**: Access the SQLite database directly or recreate the container with a fresh volume.

### Slow Performance

- **Symptoms**: Application is slow with many memos
- **Solution**: Memos uses SQLite which is efficient for most use cases. Consider archiving old memos.

## Features

- **Quick Capture**: Fast memo creation with keyboard shortcuts
- **Markdown Support**: Rich text formatting with Markdown
- **Tags**: Organize with hashtags
- **Search**: Full-text search across all memos
- **Public Sharing**: Share individual memos publicly
- **Timeline View**: Chronological display of memos
- **Archive**: Hide old memos without deleting
- **Resources**: Attach images and files
- **API**: RESTful API for integrations
- **Lightweight**: Minimal resource usage

## Security Notes

⚠️ **Important**: For production/remote access:
- Use a strong admin password
- Enable HTTPS with a reverse proxy
- Be cautious with public sharing
- Restrict access with firewall rules
- Regular backups are recommended

## Resources

- [Official Documentation](https://usememos.com/docs)
- [GitHub Repository](https://github.com/usememos/memos)
- [Docker Hub](https://hub.docker.com/r/neosmemo/memos)
- [Demo Instance](https://demo.usememos.com/)
