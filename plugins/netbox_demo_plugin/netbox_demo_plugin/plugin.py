# netbox_plugin_example/plugin.py
from extras.plugins import PluginConfig

class NetBoxDemoPluginConfig(PluginConfig):
    name = "netbox_demo_plugin"
    verbose_name = "NetBox Demo Plugin"
    description = "A simple demo plugin"
    version = "0.1"
    author = "Craig Lemon"
    base_url = "demo"