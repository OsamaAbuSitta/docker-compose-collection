# Docusaurus

Docusaurus is a static site generator designed for building documentation websites.

**Official Sites:**
- [Docusaurus](https://docusaurus.io/) | [GitHub](https://github.com/facebook/docusaurus)

## Quick Start

### Build Development Image

```bash
docker build --target development -t docs:dev .
```

### Run Development Server

```bash
docker run -p 3000:3000 docs:dev
```

## Access

- **URL**: http://localhost:3000

## Features

- Fast static site generation
- Built-in documentation versioning
- Full-text search
- Markdown/MDX support
- React-based customization
- Dark mode support

## Production Build

```bash
docker build --target production -t docs:prod .
docker run -p 3000:80 docs:prod
```

## Resources

- [Docusaurus Documentation](https://docusaurus.io/)
- [How to Dockerize Docusaurus v2](https://dev.to/cindyledev/how-to-dockerize-a-docusaurus-v2-application-fp7)