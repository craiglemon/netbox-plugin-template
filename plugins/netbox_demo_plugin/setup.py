# setup.py
from setuptools import find_packages, setup

setup(
    name="netbox_demo_plugin",
    version="0.1",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[],
    entry_points={
        'netbox.extras.plugins': [
            'netbox_demo_plugin = netbox_demo_plugin.plugin:NetBoxDemoPluginConfig'
        ]
    }
)