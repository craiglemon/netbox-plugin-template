# NetBox Plugin Dev Container Template

This repository provides a simple template for setting up a NetBox plugin development container using [Visual Studio Code Remote - Containers](https://code.visualstudio.com/docs/devcontainers/containers), also delivering a basic Netbox plugin that is correctly configured within the Dev Container and setup for debugging using DebugPy.

It allows you to define a consistent development environment using Docker, that is ready to go allowing focus to be put on the plugin development rather than the environment setup.

This repository is a GitHub template repository, making it easy to create your own repository using this as the base.

For more information on developing NetBox plugins see the following resources:
  - [NetBox Plugin Development Tutorial](https://github.com/netbox-community/netbox-plugin-tutorial) - the official NetBox plugin development community tutorial
  - [Developing NetBox Plugin](https://ttl255.com/developing-netbox-plugin-part-1-setup-and-initial-build/) - a five part series on developing plugins

## 📦 Features

- Pre-configured development environment using Docker
- Supports [Visual Studio Code Remote - Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- A working instance of NetBox using the `netboxcommunity/netbox:latest` Docker image
- Sample plugin that is fully configured within the DevContainer
- Debugging configured with DebugPy - set breakpoints and inspect variables at runtime

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- Docker
- Visual Studio Code
- Remote - Containers extension
- GitHub CLI - https://cli.github.com/

### Usage

As mentioned this GitHub repository is a template repository, meaning that you can use the GitHub CLI to easily create your won repository form thsi template.  
Follow the steps below:

1. Create a plugin repository:

   ```bash
   gh repo create my_plugin --template craiglemon/netbox-plugin-template --private
   ```
2. Rename the default \plugins\myplugin folder(s) as required to suit your plugin name

3. Edit the following files to match your plugin and description:
    - \plugins\<plugin_name>\setup.py
    - \plugins\<plugin_name>\<plugin_name>\__init__.py

4. Edit the NetBox configuration.py file located at: \netbox\configuration.py
    - Change the name of your plugin in the `PLUGINS` and `PLUGINS_CONFIG` sections

    ```python
    PLUGINS = [
      'my_plugin'
   ]

   # Plugin config (optional example)
   PLUGINS_CONFIG = {
      'my_plugin': {
      
      }
   }
    ```

# Running the Dev Container

<span style='color:red;font-weight:bold;background-color:yellow;'>TODO</span>

**Note:** Changes to files within the \plugins folder result in a restart/reload of NetBox to pick up the changes automatically

# 🧑‍💻 Contributions
Contributions are welcome! Please:
  - Fork the repository
  - Create a feature branch
  - Submit a pull request  