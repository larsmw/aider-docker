# aider-chat 0.86.x requires Python >=3.10,<3.13 (requires_python on PyPI), so 3.12 is the newest base that works.
FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends git curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir aider-chat

# The container runs with your own UID (see README), which has no home directory in the image.
# Give it a writable HOME for aider's caches and settings.
ENV HOME=/tmp/home
RUN mkdir -p /tmp/home && chmod 1777 /tmp/home

WORKDIR /workspace
ENTRYPOINT ["aider"]
