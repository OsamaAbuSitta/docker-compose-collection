# Tandoor Recipes

A recipe manager that allows you to manage your ever growing collection of digital recipes. Tandoor features meal planning, shopping lists, cookbook management, and recipe sharing.

**Official Sites:**
- [Tandoor Recipes](https://docs.tandoor.dev/) | [Docker Hub](https://hub.docker.com/r/vabene1111/recipes)

## Quick Start

```bash
docker compose -f tandoor-recipes.yaml up -d
```

## Services

### Tandoor Recipes
- **URL**: http://localhost:8080
- **Container**: `tandoor_recipes`
- **Note**: Create admin account on first visit

### PostgreSQL Database
- **Port**: 5432 (internal)
- **Container**: `tandoor_db`
- **Database**: `tandoor`
- **Username**: `tandoor`
- **Password**: `P@ss0rd123`

## Initial Setup

1. Start the services with `docker compose -f tandoor-recipes.yaml up -d`
2. Wait for initialization (check logs: `docker logs tandoor_recipes`)
3. Navigate to http://localhost:8080
4. Create your admin account
5. Start adding recipes

## Volumes

- `tandoor-staticfiles` - Static assets (CSS, JS, images)
- `tandoor-mediafiles` - Recipe images and attachments
- `tandoor-db-data` - PostgreSQL database files

## Common Tasks

### Add a Recipe

1. Click "Recipes" > "Create"
2. Enter recipe name and description
3. Add ingredients with amounts
4. Add preparation steps
5. Upload recipe image
6. Save recipe

### Import Recipes

Supported import methods:
- URL import (from recipe websites)
- File import (JSON, PDF)
- Manual entry

To import from URL:
1. Click "Recipes" > "Import"
2. Paste recipe URL
3. Tandoor extracts recipe data
4. Review and save

### Create Meal Plan

1. Click "Meal Plan"
2. Select date range
3. Drag recipes to days
4. Adjust servings
5. Generate shopping list

### Generate Shopping List

1. Go to "Meal Plan"
2. Select meals
3. Click "Shopping List"
4. Review ingredients
5. Check off items as you shop

### Share Recipes

1. Open a recipe
2. Click "Share"
3. Generate share link
4. Send to friends/family
5. Recipients can view without account

### Backup Recipes

```bash
# Backup the database
docker exec tandoor_db pg_dump -U tandoor tandoor > tandoor_backup.sql

# Backup media files
docker run --rm -v tandoor-mediafiles:/data -v $(pwd):/backup alpine tar czf /backup/tandoor-media-backup.tar.gz /data
```

## Configuration

### Environment Variables

- `SECRET_KEY` - Django secret key (50+ characters)
- `DB_ENGINE` - Database engine
- `POSTGRES_HOST` - Database hostname
- `POSTGRES_DB` - Database name
- `POSTGRES_USER` - Database username
- `POSTGRES_PASSWORD` - Database password

### Generate Secret Key

```bash
# Generate a secure secret key
openssl rand -hex 50
```

## Features

- **Recipe Management**: Store unlimited recipes
- **Meal Planning**: Plan meals for weeks ahead
- **Shopping Lists**: Auto-generate from meal plans
- **Cookbooks**: Organize recipes into collections
- **Import**: Import from URLs and files
- **Sharing**: Share recipes with others
- **Scaling**: Adjust serving sizes automatically
- **Search**: Full-text search across recipes
- **Tags**: Categorize with custom tags
- **Nutrition**: Track nutritional information
- **Multi-User**: Support for multiple users
- **Mobile Friendly**: Responsive design

## Security Notes

⚠️ **Important**: For production use:
- Generate a secure SECRET_KEY (50+ characters)
- Change the database password
- Use HTTPS with a reverse proxy
- Regular backups are essential

## Resources

- [Official Documentation](https://docs.tandoor.dev/)
- [GitHub Repository](https://github.com/TandoorRecipes/recipes)
- [Docker Hub](https://hub.docker.com/r/vabene1111/recipes)
