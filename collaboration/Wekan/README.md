# Wekan

An open-source kanban board application. Wekan offers a simple, visual way to manage projects and tasks with boards, lists, and cards. Perfect for teams who need a self-hosted Trello alternative with full data control.

**Official Sites:**
- [Wekan](https://wekan.github.io/) | [Docker Hub](https://quay.io/repository/wekan/wekan)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f wekan.yaml up -d
```

## Services

### Wekan Application
- **URL**: http://localhost:8080
- **Container**: `wekan_app`
- **Note**: Create your account on first visit

### MongoDB Database
- **Port**: 27017 (internal)
- **Container**: `wekan_db`
- **Database**: `wekan`
- **Root Username**: `root`
- **Root Password**: `P@ss0rd123`

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f wekan.yaml up -d`
3. Wait for initialization (check logs: `docker logs wekan_app`)
4. Navigate to http://localhost:8080
5. Create your account (first user becomes admin)
6. Create your first board

## Configuration

### Environment Variables (.env)

- `WEKAN_PORT` - Web interface port (default: 8080)
- `ROOT_URL` - The URL where Wekan is accessible
- `WITH_API` - Enable REST API (default: true)
- `RICHER_EDITOR` - Enable rich text editor for comments (default: true)
- `CARD_WEBHOOK` - Enable card opened webhooks (default: false)
- `MAIL_URL` - SMTP server URL for email notifications (optional)
- `MAIL_FROM` - Email sender address (optional)
- `MONGO_HOST` - MongoDB hostname (use container name)
- `MONGO_DATABASE` - MongoDB database name
- `MONGO_USERNAME` - MongoDB username
- `MONGO_PASSWORD` - MongoDB password (change for production)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Configuration

Edit the compose file to change ports or add environment variables. See the [official documentation](https://github.com/wekan/wekan/wiki) for all available options.

## Volumes

- `wekan-db-data` - MongoDB database files
- `wekan-db-dump` - Database backup location

## Common Tasks

### Create a Board

1. Log in to Wekan
2. Click "Add Board" or "+"
3. Enter board title
4. Choose board color
5. Click "Create"

### Create a List

1. Open a board
2. Click "Add a list"
3. Enter list title
4. Press Enter or click outside

### Create a Card

1. Open a board
2. Click "Add a card" in a list
3. Enter card title
4. Press Enter to create
5. Click card to add details

### Add Card Details

1. Click a card to open
2. Add description, checklists, attachments
3. Set due date and labels
4. Assign members
5. Add comments

### Move Cards

1. Drag and drop cards between lists
2. Or use the card menu → Move
3. Select destination list
4. Card moves to new list

### Share a Board

1. Open a board
2. Click the board menu (top right)
3. Select "Share Board"
4. Add members by username or email
5. Set permissions (view, comment, edit, admin)

### Backup Data

```bash
# Backup MongoDB database
docker exec wekan_db mongodump --username root --password P@ss0rd123 --authenticationDatabase admin --out /dump/wekan_backup

# Copy backup to host
docker cp wekan_db:/dump/wekan_backup ./wekan_backup
```

### Restore Database

```bash
# Copy backup to container
docker cp ./wekan_backup wekan_db:/dump/

# Restore database
docker exec wekan_db mongorestore --username root --password P@ss0rd123 --authenticationDatabase admin /dump/wekan_backup
```

### Update Wekan

```bash
# Pull the latest image
docker compose -f wekan.yaml pull

# Restart with new image
docker compose -f wekan.yaml up -d
```

## Features

- **Kanban Boards**: Visual project management
- **Lists**: Organize cards into workflow stages
- **Cards**: Tasks with rich details
- **Checklists**: Break down tasks into subtasks
- **Labels**: Color-coded categorization
- **Due Dates**: Set deadlines and reminders
- **Attachments**: Add files to cards
- **Comments**: Collaborate with team comments
- **Members**: Assign cards to team members
- **Activities**: Track all board changes
- **Filters**: Filter cards by labels, members, due dates
- **Archive**: Archive completed cards and lists
- **Templates**: Create board templates
- **Custom Fields**: Add custom attributes to cards
- **Webhooks**: Integrate with external services
- **REST API**: Automate with API access
- **Import/Export**: Import from Trello, export to JSON

## Board Management

### Board Settings

Configure board options:
1. Click board menu → Settings
2. Set board permissions
3. Configure card cover images
4. Enable/disable features
5. Set default labels

### Labels

Create custom labels:
1. Click board menu → Labels
2. Click "Add Label"
3. Set label name and color
4. Apply labels to cards

### Custom Fields

Add custom fields to cards:
1. Click board menu → Custom Fields
2. Click "Add Custom Field"
3. Choose field type (text, number, date, dropdown)
4. Set field name and options
5. Fields appear on all cards

## Integrations

### Webhooks

Set up webhooks for automation:
1. Click board menu → Webhooks
2. Click "Add Webhook"
3. Enter webhook URL
4. Select trigger events
5. External service receives notifications

### REST API

Access Wekan via API:
- API documentation: http://localhost:8080/api
- Requires authentication token
- Full CRUD operations on boards, lists, cards
- Automate workflows and integrations

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs wekan_app`. Ensure MongoDB is running and accessible.

### Database Connection Failed

- **Symptoms**: "Cannot connect to MongoDB" error
- **Solution**: Verify MONGO_HOST matches the database container name. Check MongoDB credentials.

### Cannot Create Account

- **Symptoms**: Registration fails
- **Solution**: Check ROOT_URL is correctly set. Ensure it matches the URL you're accessing Wekan from.

### Email Notifications Not Working

- **Symptoms**: Users don't receive email notifications
- **Solution**: Configure MAIL_URL with valid SMTP server. Test SMTP connection.

### Cards Not Moving

- **Symptoms**: Drag and drop doesn't work
- **Solution**: Clear browser cache. Try a different browser. Check for JavaScript errors in console.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Change all MongoDB passwords (root and application user)
- Use HTTPS with a reverse proxy
- Configure SMTP for email notifications
- Restrict access with firewall rules
- Regular backups are essential
- Keep Wekan updated to the latest version
- Enable authentication and set strong passwords

## Resources

- [Official Documentation](https://github.com/wekan/wekan/wiki)
- [GitHub Repository](https://github.com/wekan/wekan)
- [Community Forum](https://github.com/wekan/wekan/discussions)
- [Docker Hub](https://quay.io/repository/wekan/wekan)
