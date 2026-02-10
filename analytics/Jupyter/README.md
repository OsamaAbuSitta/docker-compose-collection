# Jupyter Notebook

An open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text. Uses include: data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more.

**Official Sites:**
- [Jupyter](https://jupyter.org/) | [Docker Hub](https://hub.docker.com/r/jupyter/datascience-notebook)

## Quick Start

```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your settings (especially JUPYTER_TOKEN)

# Start the service
docker compose -f jupyter.yaml up -d
```

## Services

### Jupyter Notebook/Lab
- **URL**: http://localhost:8888
- **Container**: `jupyter_notebook`
- **Token**: `P@ss0rd123` (configurable via JUPYTER_TOKEN)
- **Interface**: JupyterLab (default) or Classic Notebook

## Initial Setup

1. Copy `.env.example` to `.env` and configure:
   - Set a secure JUPYTER_TOKEN
   - Optionally set NOTEBOOKS_PATH to mount a local directory
2. Start the service with `docker compose -f jupyter.yaml up -d`
3. Navigate to http://localhost:8888
4. Enter your token when prompted
5. Start creating notebooks!

## Configuration

### Environment Variables (.env)

- `JUPYTER_PORT` - Web interface port (default: 8888)
- `JUPYTER_TOKEN` - Access token for authentication (change for production)
- `JUPYTER_ENABLE_LAB` - Use JupyterLab interface (yes/no, default: yes)
- `GRANT_SUDO` - Allow sudo access in notebooks (yes/no, default: yes)
- `NOTEBOOKS_PATH` - Local directory to mount for notebooks (optional)
- `TZ` - Timezone (e.g., America/New_York, Europe/London)

### Access Without Token

To disable token authentication (not recommended for production):

```yaml
command: start-notebook.sh --NotebookApp.token='' --NotebookApp.password=''
```

### Set a Password Instead of Token

```bash
# Generate a password hash
docker exec -it jupyter_notebook python -c "from notebook.auth import passwd; print(passwd())"

# Add to docker-compose.yaml:
command: start-notebook.sh --NotebookApp.password='sha1:...'
```

## Mounting Notebooks

### Option 1: Use Named Volume (Default)

Notebooks are stored in the `jupyter-notebooks` volume and persist across container restarts.

### Option 2: Mount Local Directory

Uncomment and set `NOTEBOOKS_PATH` in `.env`:

```bash
NOTEBOOKS_PATH=./notebooks
```

This mounts a local directory at `/home/jovyan/notebooks` in the container.

## Volumes

- `jupyter-notebooks` - Default notebook storage location
- `${NOTEBOOKS_PATH}` - Optional local directory mount for notebooks

## Common Tasks

### Create a New Notebook

1. Navigate to http://localhost:8888
2. Click "New" → "Python 3" (or other kernel)
3. Write your code in cells
4. Run cells with Shift+Enter
5. Save the notebook

### Install Python Packages

```python
# In a notebook cell
!pip install package-name

# Or use conda
!conda install package-name
```

### Install Packages Permanently

```bash
# Create a requirements.txt file
docker exec jupyter_notebook pip install -r /home/jovyan/work/requirements.txt
```

### Access Terminal

1. In JupyterLab: File → New → Terminal
2. In Classic Notebook: New → Terminal

### Export Notebooks

```bash
# Export to HTML
docker exec jupyter_notebook jupyter nbconvert --to html /home/jovyan/work/notebook.ipynb

# Export to PDF (requires LaTeX)
docker exec jupyter_notebook jupyter nbconvert --to pdf /home/jovyan/work/notebook.ipynb

# Export to Python script
docker exec jupyter_notebook jupyter nbconvert --to script /home/jovyan/work/notebook.ipynb
```

### Backup Notebooks

```bash
# Backup all notebooks
docker run --rm -v jupyter-notebooks:/data -v $(pwd):/backup alpine tar czf /backup/jupyter-notebooks.tar.gz -C /data .
```

### Restore Notebooks

```bash
# Restore notebooks
docker run --rm -v jupyter-notebooks:/data -v $(pwd):/backup alpine tar xzf /backup/jupyter-notebooks.tar.gz -C /data
```

### Install Additional Kernels

```bash
# Install R kernel
docker exec jupyter_notebook conda install -c r r-irkernel

# Install Julia kernel
docker exec jupyter_notebook conda install -c conda-forge julia

# Install additional Python versions
docker exec jupyter_notebook conda create -n py39 python=3.9 ipykernel
docker exec jupyter_notebook conda run -n py39 python -m ipykernel install --user --name py39
```

## Pre-installed Libraries

The `jupyter/datascience-notebook` image includes:

**Python Libraries**:
- NumPy, Pandas, Matplotlib, Seaborn
- Scikit-learn, TensorFlow, PyTorch
- SciPy, SymPy, Statsmodels
- Beautiful Soup, Requests
- And many more

**R Libraries**:
- tidyverse, ggplot2, dplyr
- caret, randomForest
- And many more

**Julia**:
- Core Julia installation

## Features

- **Interactive Computing**: Write and execute code in an interactive environment
- **Rich Output**: Display plots, images, videos, and interactive widgets
- **Multiple Kernels**: Support for Python, R, Julia, and 40+ other languages
- **Markdown Support**: Mix code with formatted text, equations, and images
- **Extensions**: Extend functionality with JupyterLab extensions
- **Collaboration**: Share notebooks with colleagues
- **Version Control**: Integrate with Git for version control
- **Data Visualization**: Built-in support for matplotlib, plotly, bokeh
- **Machine Learning**: Pre-installed ML libraries (scikit-learn, TensorFlow, PyTorch)

## Troubleshooting

### Cannot Access Jupyter

- **Symptoms**: Browser shows "connection refused"
- **Solution**: 
  - Check container is running: `docker ps | grep jupyter_notebook`
  - Check logs: `docker logs jupyter_notebook`
  - Verify port is not in use by another service

### Token Not Working

- **Symptoms**: "Invalid credentials" error
- **Solution**: 
  - Check JUPYTER_TOKEN in .env file
  - Restart container after changing token
  - Check logs for the actual token: `docker logs jupyter_notebook | grep token`

### Package Installation Fails

- **Symptoms**: pip or conda install errors
- **Solution**: 
  - Ensure you have sudo access (GRANT_SUDO=yes)
  - Try using conda instead of pip
  - Check internet connectivity from container

### Notebooks Not Persisting

- **Symptoms**: Notebooks disappear after container restart
- **Solution**: 
  - Ensure you're saving notebooks in `/home/jovyan/work` directory
  - Check volume is properly mounted: `docker volume inspect jupyter-notebooks`
  - Use local directory mount for critical notebooks

### Out of Memory Errors

- **Symptoms**: Kernel dies or restarts during computation
- **Solution**: 
  - Increase Docker memory limit
  - Process data in smaller chunks
  - Use more efficient algorithms
  - Clear unused variables with `del variable`

## Security Notes

⚠️ **Important**: The default configuration is for development only. For production use:
- Set a strong JUPYTER_TOKEN (or use password authentication)
- Disable sudo access (GRANT_SUDO=no) if not needed
- Use HTTPS with a reverse proxy (nginx, Caddy)
- Restrict access with firewall rules
- Regular backups are essential
- Consider using JupyterHub for multi-user environments
- Be cautious with untrusted notebooks (they can execute arbitrary code)

## Resources

- [Official Documentation](https://jupyter.org/documentation)
- [JupyterLab Documentation](https://jupyterlab.readthedocs.io/)
- [Docker Stacks Documentation](https://jupyter-docker-stacks.readthedocs.io/)
- [GitHub Repository](https://github.com/jupyter/notebook)
- [Docker Hub](https://hub.docker.com/r/jupyter/datascience-notebook)
