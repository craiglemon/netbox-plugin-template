from extras.plugins import PluginConfig

class DemoPluginConfig(PluginConfig):
    name = "demo_plugin"
    verbose_name = "Demo Plugin"
    version = "0.1"
    author = "Craig Lemon"
    description = "A bare-bones NetBox plugin."

config = DemoPluginConfig