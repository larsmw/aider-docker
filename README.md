# Aider AI in Docker

This repository provides a ready-to-use Docker setup for [Aider](https://aider.chat/),
an AI coding assistant that works directly in your terminal.

## Features
- Run Aider via **OpenRouter** (Claude, GPT, Mistral, etc.)
- Run Aider locally with **Ollama** (LLaMA 3, Mistral, CodeLlama, etc.)
- Docker + Docker Compose setup
- Easy `.aider.conf.yml` for defaults

---

## 🚀 Quick Start

### 1. Clone repo
```bash
git clone https://github.com/YOURNAME/aider-docker.git
cd aider-docker
```

### 2. Build image
```bash
docker build -t aider .
```

---

### Option A: Use OpenRouter

1. Copy `.env.example` to `.env` and add your key.
2. Run:
```bash
docker-compose run --rm aider-openrouter
```

---

### Option B: Use Ollama (local model)

1. Install Ollama:  
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ```
2. Pull a model:
   ```bash
   ollama run llama3
   ```
3. Run:
   ```bash
   docker-compose run --rm aider-ollama
   ```

---

## ⚙️ Configuration

Default settings live in `.aider.conf.yml`.  
Edit it to choose your favorite model/editor.

Examples:

```yaml
# OpenRouter example
model: openrouter/anthropic/claude-3.5-sonnet
editor: nano
```

```yaml
# Ollama example
model: ollama/llama3
api_base: http://host.docker.internal:11434/v1
editor: nano
```

---

## 🔄 Updating Aider

Rebuild the image for the latest version:

```bash
docker build --no-cache -t aider .
```

---

## 📌 Notes

- On Linux, replace `host.docker.internal` with your host IP (often `172.17.0.1`).
- Keep `.env` secret and **never commit your API keys**.
- Check available models:  
  - OpenRouter: https://openrouter.ai/models  
  - Ollama: https://ollama.com/library

See more on my website|https://www.linkhub.dk/how-run-aider-ai-chat-docker-linux
