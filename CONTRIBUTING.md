# Contributing

Thank you for considering contributing to this project! This document provides guidelines and instructions for contributing.

## How to Contribute

### Reporting Issues

- Use the GitHub issue tracker
- Check if the issue already exists
- Provide detailed information:
  - Service name and version
  - Docker version
  - Operating system
  - Steps to reproduce
  - Expected vs actual behavior
  - Relevant logs

### Adding New Services

When adding a new service:

1. **Choose the Right Category**
   - Place in appropriate directory (databases/, tools/, etc.)
   - Create new category if needed

2. **File Structure**
   ```
   service-name/
   ├── docker-compose.yaml
   ├── README.md
   └── config/ (if needed)
   ```

### Pull Request Process

1. **Fork the Repository**
   ```bash
   git clone https://github.com/YOUR-USERNAME/docker-dev-environments.git
   cd docker-dev-environments
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/service-name
   ```

3. **Make Your Changes**
   - Add your service
   - Create/update documentation
   - Test thoroughly

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Add [service-name] with [brief description]"
   ```

5. **Push to Your Fork**
   ```bash
   git push origin feature/service-name
   ```

6. **Open a Pull Request**
   - Provide clear description
   - Reference any related issues
   - Include testing steps

## Security Considerations

- Never commit real credentials or secrets
- Use placeholder passwords clearly marked as examples
- Document security best practices
- Warn about development-only configurations

## Documentation

- Keep README.md up to date
- Document breaking changes
- Update version numbers
- Add examples for common use cases

## Questions?

Feel free to open an issue for:
- Questions about contributing
- Suggestions for improvements
- Discussion about new features

Thank you for contributing! 🎉
