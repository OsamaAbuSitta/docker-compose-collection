# PhotoPrism

AI-powered photos app for the decentralized web. Browse, organize, and share your photo collection with automatic tagging, face recognition, and powerful search.

**Official Sites:**
- [PhotoPrism](https://photoprism.app/) | [Docker Hub](https://hub.docker.com/r/photoprism/photoprism)

## Quick Start

```bash
docker compose -f photoprism.yaml up -d
```

## Services

### PhotoPrism
- **URL**: http://localhost:2342
- **Container**: `photoprism`
- **Username**: `admin`
- **Password**: `P@ss0rd123`

### MariaDB Database
- **Port**: 3306 (internal)
- **Container**: `photoprism_db`

## Initial Setup

1. Start services with `docker compose -f photoprism.yaml up -d`
2. Navigate to http://localhost:2342
3. Log in with admin/P@ss0rd123
4. Change password in settings
5. Upload photos or mount existing library
6. Start indexing

## Volumes

- `photoprism-originals` - Original photos and videos
- `photoprism-storage` - Thumbnails, sidecar files, cache
- `photoprism-db-data` - MariaDB database

## Common Tasks

### Import Photos

1. Copy photos to originals volume
2. Go to Library > Index
3. Click "Start" to index photos
4. Wait for completion

### Search Photos

Use powerful search:
- By content: "beach", "sunset", "cat"
- By location: "Paris", "New York"
- By date: "2023", "January"
- By person: Face recognition
- By color, camera, lens, etc.

### Organize Albums

1. Select photos
2. Click "Add to Album"
3. Create or select album
4. Share album with others

### Backup Photos

```bash
# Backup originals
docker run --rm -v photoprism-originals:/data -v $(pwd):/backup alpine tar czf /backup/photoprism-originals-backup.tar.gz /data

# Backup database
docker exec photoprism_db mysqldump -u photoprism -pP@ss0rd123 photoprism > photoprism_backup.sql
```

## Features

- **AI Tagging**: Automatic content recognition
- **Face Recognition**: Identify people
- **Powerful Search**: Natural language search
- **Albums**: Organize collections
- **Sharing**: Share albums publicly
- **Timeline**: Chronological view
- **Map View**: Browse by location
- **RAW Support**: Process RAW images
- **Video Support**: Index and play videos
- **Mobile Friendly**: Responsive design

## Security Notes

⚠️ **Important**: For production use:
- Change admin password immediately
- Change database passwords
- Use HTTPS with reverse proxy
- Regular backups essential

## Resources

- [Official Documentation](https://docs.photoprism.app/)
- [GitHub Repository](https://github.com/photoprism/photoprism)
- [Docker Hub](https://hub.docker.com/r/photoprism/photoprism)
