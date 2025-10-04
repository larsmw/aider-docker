FROM python:3.11-slim

RUN apt-get update && apt-get install -y git curl     && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir aider-chat

ENV PATH=$PATH:/root/.local/bin

ENTRYPOINT ["aider"]
