# Stirling PDF

A locally hosted web-based PDF manipulation tool using Docker. Stirling PDF allows you to perform various operations on PDF files such as splitting, merging, converting, reorganizing, adding images, rotating, compressing, and more. All operations are performed locally without sending files to external servers.

**Official Sites:**
- [Stirling PDF](https://github.com/Frooodle/Stirling-PDF) | [Docker Hub](https://hub.docker.com/r/frooodle/s-pdf)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings

# Start the service
docker compose -f stirling-pdf.yaml up -d
```

## Services

### Stirling PDF
- **URL**: http://localhost:8080
- **Container**: `stirling-pdf`
- **Description**: Web-based PDF manipulation tool

## Initial Setup

1. Copy `.env.example` to `.env` and configure
2. Start the service with `docker compose -f stirling-pdf.yaml up -d`
3. Navigate to http://localhost:8080
4. Start manipulating PDFs

## Configuration

### Environment Variables (.env)

- `STIRLING_PORT` - Web interface port (default: 8080)
- `TZ` - Timezone for the container (default: UTC)
- `ENABLE_SECURITY` - Enable security features (default: false)
- `ENABLE_LOGIN` - Require login (default: false)
- `DEFAULT_LOCALE` - Default language (default: en-US)
- `CONFIGS_DIR` - Configuration directory (default: ./configs)

### Security Configuration

To enable authentication:
1. Set `ENABLE_SECURITY=true` in .env
2. Set `ENABLE_LOGIN=true` in .env
3. Configure users in the configs directory
4. Restart the service

## Using Stirling PDF

### Basic Operations

All operations are performed through the web interface:

1. **Upload PDF**: Click or drag-and-drop your PDF file
2. **Select Operation**: Choose from the available tools
3. **Configure**: Set operation parameters
4. **Process**: Click to perform the operation
5. **Download**: Save the result

### Available Operations

**Page Operations:**
- Split PDF into multiple files
- Merge multiple PDFs into one
- Rotate pages
- Remove pages
- Rearrange pages
- Extract specific pages

**Content Operations:**
- Add images to PDF
- Add watermarks
- Add page numbers
- Add headers/footers
- Extract images from PDF
- Extract text from PDF

**Conversion:**
- PDF to images (PNG, JPEG)
- Images to PDF
- PDF to Word
- PDF to Excel
- PDF to PowerPoint
- HTML to PDF
- Office files to PDF

**Optimization:**
- Compress PDF
- Reduce file size
- Optimize for web
- Remove metadata

**Security:**
- Add password protection
- Remove password
- Add permissions
- Sign PDF
- Sanitize PDF

**OCR:**
- OCR PDF (extract text from scanned documents)
- Make PDF searchable

**Other:**
- Flatten PDF
- Repair PDF
- Compare PDFs
- Auto-split by size
- Scale pages
- Adjust contrast

## Volumes

- `stirling-data` - Tessdata for OCR operations
- `configs` - Configuration files (mounted from host)

## Common Tasks

### Merge Multiple PDFs

```bash
# 1. Upload all PDF files
# 2. Select "Merge PDFs"
# 3. Arrange files in desired order
# 4. Click "Merge"
# 5. Download the merged PDF
```

### Compress Large PDFs

```bash
# 1. Upload your PDF
# 2. Select "Compress PDF"
# 3. Choose compression level
# 4. Click "Compress"
# 5. Download the compressed PDF
```

### Convert Images to PDF

```bash
# 1. Upload image files (PNG, JPEG, etc.)
# 2. Select "Images to PDF"
# 3. Arrange images in order
# 4. Set page size and orientation
# 5. Click "Convert"
# 6. Download the PDF
```

### OCR Scanned Documents

```bash
# 1. Upload scanned PDF
# 2. Select "OCR PDF"
# 3. Choose language
# 4. Click "Process"
# 5. Download searchable PDF
```

### Add Watermark

```bash
# 1. Upload your PDF
# 2. Select "Add Watermark"
# 3. Enter watermark text or upload image
# 4. Configure position and opacity
# 5. Click "Apply"
# 6. Download watermarked PDF
```

## Features

- **100% Local**: All processing happens on your server
- **No File Size Limits**: Process files of any size
- **Privacy**: Files never leave your server
- **No Tracking**: No analytics or tracking
- **Multi-language**: Support for multiple languages
- **Batch Processing**: Process multiple files at once
- **API**: RESTful API for automation
- **Dark Mode**: Easy on the eyes
- **Mobile Friendly**: Responsive design
- **Open Source**: Free and open source

## API Usage

Stirling PDF provides a REST API for automation:

```bash
# Example: Merge PDFs via API
curl -X POST http://localhost:8080/api/v1/merge \
  -F "fileInput=@file1.pdf" \
  -F "fileInput=@file2.pdf" \
  -o merged.pdf
```

## Troubleshooting

### Upload Fails

- Check file size limits
- Verify PDF is not corrupted
- Ensure sufficient disk space
- Check container logs: `docker logs stirling-pdf`

### OCR Not Working

- Verify language data is downloaded
- Check PDF quality (resolution)
- Ensure PDF is not already OCR'd
- Try different OCR settings

### Slow Performance

- Large files take longer to process
- Increase container resources (CPU/RAM)
- Check disk I/O performance
- Process files in smaller batches

### Cannot Access Web Interface

- Verify port 8080 is not in use
- Check firewall settings
- Ensure container is running: `docker ps`
- Check logs: `docker logs stirling-pdf`

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Enable authentication (`ENABLE_LOGIN=true`)
- Use HTTPS with a reverse proxy
- Restrict access with firewall rules
- Keep the application updated
- Regular backups recommended
- Do not expose publicly without authentication

## Resources

- [GitHub Repository](https://github.com/Frooodle/Stirling-PDF)
- [Documentation](https://github.com/Frooodle/Stirling-PDF/blob/main/README.md)
- [API Documentation](https://github.com/Frooodle/Stirling-PDF/blob/main/API.md)
- [Docker Hub](https://hub.docker.com/r/frooodle/s-pdf)
