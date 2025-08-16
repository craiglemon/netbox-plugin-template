# NEtBox Plugin Dev Container Template

This repository provides a simple template for setting up a NetBox plugin development container using [Visual Studio Code Remote - Containers], also delivering a basic Netbox plugin that is correctly configured within the Dev Container.  It allows you to define a consistent development environment using Docker, that is ready to go allowing focus to be put on the plugin development rather than the environment setup.

## 📦 Features

- Pre-configured development environment using Docker
- Supports VS Code Remote Containers
- A working instance of NetBox using the netboxcommunity/netbox:latest base image
- 

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

