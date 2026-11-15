# Aider AI in Docker

A Docker setup for [Aider](https://aider.chat/), an AI coding assistant that works directly in your terminal,
with either **OpenRouter** (cloud models) or a local **Ollama**.

Aider also publishes official images (`paulgauthier/aider`, `paulgauthier/aider-full`), see
[Aider with docker](https://aider.chat/docs/install/docker.html). This repository builds its own image and adds
a Compose file with both setups.

---

## 🚀 Quick Start

### 1. Clone and build
```bash
git clone https://github.com/larsmw/aider-docker.git
cd aider-docker
docker compose build
```

### 2. Run it on your project

Aider has to see a git repository. Point `PROJECT_DIR` at it (default: this directory), and run as your own user,
so that git accepts the repository and the files Aider writes belong to you:

```bash
export PROJECT_DIR=/path/to/your/git/repo
docker compose run --rm --user "$(id -u):$(id -g)" aider-openrouter
```

The container doesn't have your global git config. Set your name and email in the project once:
```bash
git -C "$PROJECT_DIR" config user.name "Your Name"
git -C "$PROJECT_DIR" config user.email "you@example.com"
```

---

### Option A: OpenRouter

1. Copy `.env.example` to `.env` and add your key (or `export OPENROUTER_API_KEY=...`).
2. Run:
   ```bash
   docker compose run --rm --user "$(id -u):$(id -g)" aider-openrouter
   ```

The model defaults to `openrouter/anthropic/claude-sonnet-4.6`. Set `OPENROUTER_MODEL` to change it, and list what's
available with:
```bash
docker compose run --rm aider-openrouter --list-models openrouter/
```

---

### Option B: Ollama (local model)

1. Install Ollama and pull a model:
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ollama pull qwen2.5-coder:7b
   ```
2. **Let the container reach Ollama.** Ollama binds `127.0.0.1:11434` by default, which a container can't reach.
   Make it listen on all interfaces, e.g. with `sudo systemctl edit ollama`:
   ```ini
   [Service]
   Environment="OLLAMA_HOST=0.0.0.0:11434"
   ```
   then `sudo systemctl restart ollama`. This also exposes Ollama to your network, so firewall port 11434 if
   the machine isn't private.
3. Run:
   ```bash
   docker compose run --rm --user "$(id -u):$(id -g)" aider-ollama
   ```

The Compose file adds `host.docker.internal` (Docker only does that by itself on Docker Desktop) and sets
`OLLAMA_API_BASE=http://host.docker.internal:11434`. Aider has no `--api-base` option; it reads the Ollama address
from that variable. The model defaults to `ollama_chat/qwen2.5-coder:7b`; set `OLLAMA_MODEL` to use another one.
Aider recommends the `ollama_chat/` prefix over `ollama/`.

---

## ⚙️ Configuration

Aider reads `.aider.conf.yml` from your home directory, the root of the git repo it works on and the current
directory. In the container that's your project (`PROJECT_DIR`), so copy this repository's `.aider.conf.yml` there
if you want to use it. Keys are aider's command-line options without the dashes:

```yaml
model: openrouter/anthropic/claude-sonnet-4.6
editor: nano          # used by the /editor command
```

---

## 🔄 Updating Aider

```bash
docker compose build --pull --no-cache
```

---

## 📌 Notes

- `aider-chat` 0.86 needs Python 3.10–3.12, hence the `python:3.12-slim` base.
- `/run` inside Aider runs commands in the container, not on your machine.
- Keep `.env` secret and **never commit your API keys** (`.env` is in `.gitignore`).
- Model lists: [OpenRouter](https://openrouter.ai/models), [Ollama](https://ollama.com/library).

More background, with sources for each step: [How to Run Aider in Docker on Linux](https://www.linkhub.dk/how-run-aider-ai-chat-docker-linux)
