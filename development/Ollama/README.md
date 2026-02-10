# Ollama

Run large language models locally. Easy setup for LLMs like Llama 2, Code Llama, and more.

**Official Sites:**
- [Ollama](https://ollama.ai/) | [Docker Hub](https://hub.docker.com/r/ollama/ollama)

## Quick Start

```bash
cp .env.example .env
docker compose -f ollama.yaml up -d
```

## Access
- **API**: http://localhost:11434

## Configuration
- `OLLAMA_PORT` - API port (default: 11434)
- `TZ` - Timezone

## Usage

```bash
# Pull a model
docker exec ollama ollama pull llama2

# Run a model
docker exec -it ollama ollama run llama2

# List models
docker exec ollama ollama list
```

## Features
- Run LLMs locally
- Multiple model support
- REST API
- Model library
- GPU acceleration (if available)

## Resources
- [Official Site](https://ollama.ai/)
- [Model Library](https://ollama.ai/library)
- [GitHub](https://github.com/ollama/ollama)
