# Dev Container Template

This repository provides a simple template for setting up a development container using [Visual Studio Code Remote - Containers]
It allows you to define a consistent development environment using Docker, making it easier to onboard new developers and maintain reproducibility across machines.

## 📦 Features

- Pre-configured development environment using Docker
- Supports VS Code Remote Containers
- Easy to customize for different languages or frameworks
- Includes basic tooling (e.g., Git, curl, language runtimes)

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- Docker
- Visual Studio Code
- Remote - Containers extension

### Usage

1. **Clone this repository**:

   ```bash
   git clone https://github.com/your-org/dev-container-template.git
   cd dev-container-template
   ```

## 🛠️ Customization

### `devcontainer.json`

This file defines the container configuration. You can:

- Add VS Code extensions
- Set environment variables
- Configure post-create commands

Example snippet:

```json
{
  "name": "My Dev Container",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "settings": {
    "terminal.integrated.shell.linux": "/bin/bash"
  },
  "extensions": [
    "ms-python.python",
    "esbenp.prettier-vscode"
  ],
  "postCreateCommand": "echo 'Container setup complete!'"
}
````

### `Dockerfile`

The `Dockerfile` defines the base image and installs any required tools or dependencies for your development environment.

Here’s a basic example:

```Dockerfile
# Use a base image from Microsoft's dev containers
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# Install common tools
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    python3 \
    python3-pip \
    nodejs \
    npm

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
```

## 📁 File Structure

```
📁 Project Root
|-- .devcontainer
|   |-- devcontainer.json
|   |-- docker-compose.yml
|   |-- Dockerfile
|-- app
|   |-- app.py
|-- dev-container-template.code-workspace
|-- README.md

```

