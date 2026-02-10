# Draw.io (diagrams.net)

A free online diagram software for making flowcharts, process diagrams, org charts, UML, ER diagrams, network diagrams, and more. Self-hosted version of the popular diagrams.net application.

**Official Sites:**
- [Draw.io](https://www.diagrams.net/) | [Docker Hub](https://hub.docker.com/r/jgraph/drawio)

## Quick Start

```bash
docker compose -f drawio.yaml up -d
```

## Services

### Draw.io
- **URL**: http://localhost:8080
- **HTTPS URL**: https://localhost:8443
- **Container**: `drawio`
- **Note**: No authentication required (local storage)

## Initial Setup

1. Start the service with `docker compose -f drawio.yaml up -d`
2. Navigate to http://localhost:8080
3. Choose storage location (Browser, Device, Google Drive, OneDrive, etc.)
4. Start creating diagrams
5. Save diagrams locally or to cloud storage

## Storage Options

Draw.io supports multiple storage backends:

- **Browser**: Store in browser local storage
- **Device**: Save to local file system
- **Google Drive**: Sync with Google Drive
- **OneDrive**: Sync with Microsoft OneDrive
- **Dropbox**: Sync with Dropbox
- **GitHub**: Store in GitHub repositories
- **GitLab**: Store in GitLab repositories

## Common Tasks

### Create a New Diagram

1. Click "Create New Diagram"
2. Choose a template or start blank
3. Select diagram type (Flowchart, UML, Network, etc.)
4. Start drawing with drag-and-drop shapes

### Export Diagrams

Supported export formats:
- PNG (image)
- JPEG (image)
- SVG (vector)
- PDF (document)
- HTML (embedded)
- XML (source)
- VSDX (Visio)

To export:
1. Click File > Export as
2. Choose format
3. Configure export options
4. Download file

### Import Diagrams

Supported import formats:
- .drawio / .xml (native format)
- .vsdx (Microsoft Visio)
- Lucidchart files
- Gliffy diagrams

To import:
1. Click File > Import from
2. Choose source
3. Select file
4. Edit imported diagram

### Use Templates

1. Click "Create New Diagram"
2. Browse template categories:
   - Flowcharts
   - UML diagrams
   - Network diagrams
   - Org charts
   - Floor plans
   - And many more
3. Select template
4. Customize for your needs

### Collaborate on Diagrams

For collaboration, save diagrams to cloud storage:
1. File > Save as
2. Choose Google Drive, OneDrive, or GitHub
3. Share the file with collaborators
4. Multiple users can edit (with cloud storage sync)

## Configuration

### Environment Variables

- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Port

To change the HTTP port, modify the ports section:

```yaml
ports:
  - "9000:8080"  # Access on port 9000 instead
  - "9443:8443"
```

### Enable Plugins

Draw.io supports plugins for extended functionality. Configure in the application settings.

### Offline Mode

Draw.io works completely offline when using browser or device storage. No internet connection required for diagram creation.

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:8080
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### Diagrams Not Saving

- **Symptoms**: Changes are lost after closing browser
- **Solution**: Ensure you're saving to device or cloud storage, not just browser cache. Use File > Save as.

### Cloud Storage Not Connecting

- **Symptoms**: Cannot connect to Google Drive, OneDrive, etc.
- **Solution**: Check browser permissions. Allow pop-ups for authentication. Verify internet connectivity.

### Export Fails

- **Symptoms**: Cannot export diagram
- **Solution**: Try different export format. Check browser download settings. Ensure sufficient disk space.

## Features

- **Rich Shape Library**: Thousands of shapes and icons
- **Templates**: Pre-built templates for common diagrams
- **Multiple Storage**: Browser, device, cloud storage
- **Export Formats**: PNG, SVG, PDF, VSDX, and more
- **Import Support**: Visio, Lucidchart, Gliffy
- **Layers**: Organize complex diagrams with layers
- **Styling**: Extensive formatting and styling options
- **Collaboration**: Real-time collaboration via cloud storage
- **Offline Capable**: Works without internet
- **Free and Open Source**: No licensing costs

## Diagram Types

Draw.io supports creating:

- **Flowcharts**: Process flows and workflows
- **UML Diagrams**: Class, sequence, activity diagrams
- **Network Diagrams**: Infrastructure and topology
- **Org Charts**: Organizational structures
- **ER Diagrams**: Database entity relationships
- **Mind Maps**: Brainstorming and planning
- **Floor Plans**: Office and building layouts
- **Wireframes**: UI/UX mockups
- **BPMN**: Business process modeling
- **Gantt Charts**: Project timelines
- **And many more...**

## Keyboard Shortcuts

- **Ctrl+N**: New diagram
- **Ctrl+S**: Save diagram
- **Ctrl+Z**: Undo
- **Ctrl+Y**: Redo
- **Ctrl+C**: Copy
- **Ctrl+V**: Paste
- **Ctrl+D**: Duplicate
- **Delete**: Delete selected
- **Ctrl+G**: Group
- **Ctrl+Shift+U**: Ungroup

## Security Notes

⚠️ **Important**: For production/remote access:
- Use HTTPS (port 8443) for encrypted communication
- Configure a reverse proxy with authentication if needed
- Be cautious with cloud storage permissions
- Use device storage for sensitive diagrams
- Restrict access with firewall rules

## Resources

- [Official Documentation](https://www.diagrams.net/doc/)
- [GitHub Repository](https://github.com/jgraph/drawio)
- [Docker Hub](https://hub.docker.com/r/jgraph/drawio)
- [Video Tutorials](https://www.youtube.com/c/drawio)
- [Shape Libraries](https://www.diagrams.net/blog/shape-libraries)
