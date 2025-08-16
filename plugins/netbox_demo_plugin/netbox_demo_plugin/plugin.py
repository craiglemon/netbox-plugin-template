from netbox.plugins import PluginConfig

class NetBoxDemoPluginConfig(PluginConfig):
    name = "netbox_demo_plugin"
    verbose_name = "NetBox Demo Plugin"
    description = "A simple demo plugin"
    version = "0.1"
    author = "Craig Lemon"
    author_email = "Craig.Lemon@gmail.com"
    base_url = "demo"
