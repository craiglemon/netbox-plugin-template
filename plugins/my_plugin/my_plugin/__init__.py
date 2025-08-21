from netbox.plugins import PluginConfig

class MyPluginConfig(PluginConfig):
    name = "my_plugin"
    verbose_name = "Sample Netbox Plugin"
    description = "Simple Netbox Plugin"
    version = "0.1"
    author = "Craig Lemon"
    author_email = "Craig.Lemon@gmail.com"
    required_settings = []
    default_settings = {}

config = MyPluginConfig