# Excalidraw

A virtual collaborative whiteboard tool that lets you easily sketch diagrams with a hand-drawn feel. Perfect for wireframes, mockups, system diagrams, and brainstorming.

**Official Sites:**
- [Excalidraw](https://excalidraw.com/) | [Docker Hub](https://hub.docker.com/r/excalidraw/excalidraw)

## Quick Start

```bash
docker compose -f excalidraw.yaml up -d
```

## Services

### Excalidraw
- **URL**: http://localhost:3000
- **Container**: `excalidraw`
- **Note**: No authentication required (local storage)

## Initial Setup

1. Start the service with `docker compose -f excalidraw.yaml up -d`
2. Navigate to http://localhost:3000
3. Start drawing immediately
4. Drawings are saved to browser local storage automatically

## Common Tasks

### Create a Drawing

1. Open http://localhost:3000
2. Start drawing with the toolbar:
   - Rectangle, Circle, Diamond, Arrow
   - Line, Text, Image
   - Hand-drawn style or architect mode
3. Drawings auto-save to browser storage

### Export Drawings

Supported export formats:
- PNG (image)
- SVG (vector)
- Excalidraw format (.excalidraw)
- Clipboard (copy to paste elsewhere)

To export:
1. Click the menu icon (three lines)
2. Select "Export image"
3. Choose format and options
4. Download or copy to clipboard

### Import Drawings

To import:
1. Click the menu icon
2. Select "Open"
3. Choose .excalidraw file
4. Drawing loads into canvas

### Collaborate in Real-Time

For collaboration:
1. Click "Live collaboration" in the menu
2. Share the generated link with collaborators
3. Multiple users can draw simultaneously
4. Changes sync in real-time

### Use Libraries

Excalidraw supports shape libraries:
1. Click the library icon (books)
2. Browse built-in libraries
3. Or import custom libraries
4. Drag shapes onto canvas

### Embed in Websites

```html
<!-- Embed Excalidraw drawing -->
<iframe src="http://localhost:3000/#json=..." width="800" height="600"></iframe>
```

## Configuration

### Environment Variables

- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Custom Port

To change the port, modify the ports section:

```yaml
ports:
  - "8080:3000"  # Access on port 8080 instead
```

### Persistent Storage

By default, drawings are stored in browser local storage. For persistent server-side storage, you can:
1. Export drawings regularly
2. Use the collaboration feature with saved links
3. Integrate with cloud storage via browser extensions

## Troubleshooting

### Cannot Access Web Interface

- **Symptoms**: Browser cannot connect to http://localhost:3000
- **Solution**: Ensure the container is running with `docker ps`. Check for port conflicts.

### Drawings Not Saving

- **Symptoms**: Drawings disappear after closing browser
- **Solution**: Excalidraw uses browser local storage. Export important drawings. Clear browser cache may delete drawings.

### Collaboration Not Working

- **Symptoms**: Cannot share or join collaboration session
- **Solution**: Ensure the server is accessible from all participants. Check firewall rules. Verify network connectivity.

### Performance Issues

- **Symptoms**: Slow or laggy drawing
- **Solution**: Reduce number of elements. Close other browser tabs. Use a modern browser (Chrome, Firefox, Edge).

## Features

- **Hand-Drawn Style**: Sketchy, hand-drawn aesthetic
- **Infinite Canvas**: Unlimited drawing space
- **Collaboration**: Real-time multi-user editing
- **Libraries**: Built-in and custom shape libraries
- **Export Options**: PNG, SVG, Excalidraw format
- **Dark Mode**: Toggle between light and dark themes
- **Keyboard Shortcuts**: Fast workflow with shortcuts
- **Touch Support**: Works on tablets and touch screens
- **Offline Capable**: Works without internet
- **Free and Open Source**: No licensing costs

## Drawing Tools

- **Shapes**: Rectangle, circle, diamond, ellipse
- **Lines**: Straight lines and arrows
- **Free Draw**: Hand-drawn lines
- **Text**: Add labels and annotations
- **Images**: Insert images into drawings
- **Eraser**: Remove elements
- **Selection**: Move and resize elements
- **Colors**: Customize stroke and fill colors
- **Opacity**: Adjust transparency
- **Layers**: Bring forward, send backward

## Keyboard Shortcuts

- **V**: Selection tool
- **R**: Rectangle
- **D**: Diamond
- **O**: Ellipse
- **A**: Arrow
- **L**: Line
- **T**: Text
- **Ctrl+Z**: Undo
- **Ctrl+Y**: Redo
- **Ctrl+C**: Copy
- **Ctrl+V**: Paste
- **Delete**: Delete selected
- **Ctrl+D**: Duplicate
- **Ctrl+G**: Group
- **Ctrl+Shift+G**: Ungroup

## Use Cases

- **Wireframes**: UI/UX mockups and prototypes
- **System Diagrams**: Architecture and infrastructure
- **Flowcharts**: Process flows and workflows
- **Brainstorming**: Mind maps and idea sketches
- **Presentations**: Visual slides and diagrams
- **Teaching**: Educational diagrams and illustrations
- **Documentation**: Technical documentation visuals
- **Collaboration**: Remote team whiteboarding

## Security Notes

⚠️ **Important**: For production/remote access:
- Use HTTPS with a reverse proxy
- Be cautious with collaboration links (anyone with link can access)
- Export important drawings regularly
- Restrict access with firewall rules
- Consider authentication via reverse proxy

## Resources

- [Official Documentation](https://docs.excalidraw.com/)
- [GitHub Repository](https://github.com/excalidraw/excalidraw)
- [Docker Hub](https://hub.docker.com/r/excalidraw/excalidraw)
- [Libraries](https://libraries.excalidraw.com/)
- [Blog](https://blog.excalidraw.com/)
