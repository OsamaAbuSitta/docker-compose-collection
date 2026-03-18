# Gollum

A simple, Git-powered wiki with a sweet API and local frontend. Gollum is the wiki system that powers GitHub Wikis. It stores all content in a Git repository, providing version control for your documentation.

**Official Sites:**
- [Gollum](https://github.com/gollum/gollum) | [Docker Hub](https://hub.docker.com/r/gollumwiki/gollum)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f gollum.yaml up -d
```

## Services

### Gollum Application
- **URL**: http://localhost:4567
- **Container**: `gollum_app`
- **Note**: No authentication by default (add via reverse proxy if needed)

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f gollum.yaml up -d`
3. Wait for the application to initialize (check logs: `docker logs gollum_app`)
4. Navigate to http://localhost:4567
5. Click "Create the home page" to start
6. Begin creating your wiki pages

## Configuration

### Environment Variables (.env)

- `GOLLUM_PORT` - Web interface port (default: 4567)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Command-Line Options

The compose file includes several Gollum options:
- `--allow-uploads page` - Allow file uploads on pages
- `--emoji` - Enable emoji support
- `--user-icons gravatar` - Use Gravatar for user icons
- `--live-preview` - Enable live preview while editing

Additional options can be added to the command in the compose file:
- `--no-edit` - Disable editing (read-only mode)
- `--h1-title` - Use first H1 as page title
- `--mathjax` - Enable MathJax for math equations
- `--css` - Use custom CSS
- `--js` - Use custom JavaScript

See the [Gollum documentation](https://github.com/gollum/gollum#configuration) for all options.

## Using Gollum

### Creating Pages

1. Navigate to http://localhost:4567
2. Click "New Page" or edit an existing page link
3. Enter page name (use hyphens or underscores for spaces)
4. Write content using Markdown or other supported formats
5. Add a commit message
6. Click "Save Page"

### Editing Pages

1. Click "Edit" on any page
2. Modify the content
3. Preview changes with the live preview
4. Add a commit message describing changes
5. Click "Save Page"

### Page Formats

Gollum supports multiple markup formats:
- **Markdown** (.md, .markdown) - Default
- **Org Mode** (.org)
- **Textile** (.textile)
- **RDoc** (.rdoc)
- **AsciiDoc** (.asciidoc)
- **MediaWiki** (.mediawiki)
- **reStructuredText** (.rest, .rst)

### Linking Pages

Create links to other pages:
- `[[Page Name]]` - Link to a page
- `[[Link Text|Page Name]]` - Link with custom text
- `[[Page Name#section]]` - Link to a section
- `[[/path/to/page]]` - Link with path

### Including Images

Upload and include images:
- Upload via the web interface
- Reference with `[[image.png]]`
- Add alt text: `[[image.png|Alt text]]`
- Resize: `[[image.png|width=300]]`

## Features

- **Git-Backed**: All content stored in Git repository
- **Version Control**: Full history of all changes
- **Multiple Formats**: Support for Markdown, Org, Textile, and more
- **Live Preview**: See changes as you type
- **File Uploads**: Upload images and files
- **Search**: Full-text search across all pages
- **Emoji Support**: Use emoji in your content
- **Math Equations**: MathJax support for equations
- **Syntax Highlighting**: Code blocks with syntax highlighting
- **Page History**: View and compare revisions
- **Revert Changes**: Roll back to previous versions
- **API**: RESTful API for automation
- **Lightweight**: Minimal resource usage
- **No Database**: Everything in Git

## Volumes

- `gollum-wiki` - Git repository containing all wiki content

## Common Tasks

### Backup Wiki

```bash
# Backup the Git repository
docker run --rm -v gollum-wiki:/wiki -v $(pwd):/backup alpine tar czf /backup/gollum-backup.tar.gz /wiki
```

### Restore Wiki

```bash
# Restore from backup
docker run --rm -v gollum-wiki:/wiki -v $(pwd):/backup alpine tar xzf /backup/gollum-backup.tar.gz -C /
```

### Clone Wiki Repository

```bash
# Access the Git repository
docker exec gollum_app git -C /wiki remote add origin https://github.com/user/repo.git
docker exec gollum_app git -C /wiki push -u origin master
```

### View Git History

```bash
# View commit history
docker exec gollum_app git -C /wiki log --oneline
```

### Revert to Previous Version

1. Click "History" on a page
2. View previous versions
3. Click "Revert" on the desired version
4. Add a commit message
5. Confirm revert

### Export Pages

```bash
# Export all pages as Markdown
docker exec gollum_app sh -c 'cd /wiki && find . -name "*.md" -exec cat {} \;'
```

### Search Content

Use the search box in the web interface:
1. Enter search terms
2. View matching pages
3. Click a result to view the page

## Troubleshooting

### Application Won't Start

- **Symptoms**: Container exits immediately
- **Solution**: Check logs with `docker logs gollum_app`. Ensure the gollum-wiki volume is accessible.

### Cannot Save Pages

- **Symptoms**: "Error saving page" message
- **Solution**: Check volume permissions. Ensure gollum-wiki volume is writable. Check container logs for Git errors.

### Git Errors

- **Symptoms**: Git-related error messages
- **Solution**: Check Git configuration. Ensure the repository is initialized. Try resetting the repository if corrupted.

### Images Not Displaying

- **Symptoms**: Uploaded images show broken links
- **Solution**: Verify images were uploaded successfully. Check file paths. Ensure uploads are enabled in the command options.

### Search Not Working

- **Symptoms**: Search returns no results
- **Solution**: Ensure pages exist in the wiki. Check that content is committed to Git. Try restarting the container.

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Add authentication via reverse proxy (Gollum has no built-in auth)
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Regular backups are essential (backup the Git repository)
- Consider using `--no-edit` for read-only wikis
- Keep the application updated
- Review Git commit history regularly

## Resources

- [Official Documentation](https://github.com/gollum/gollum/wiki)
- [GitHub Repository](https://github.com/gollum/gollum)
- [Docker Hub](https://hub.docker.com/r/gollumwiki/gollum)
- [Markup Formats](https://github.com/gollum/gollum/wiki#page-files)
