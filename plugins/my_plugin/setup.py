from setuptools import find_packages, setup

setup(
    name="my_plugin",
    version="0.1",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[],
    entry_points={
        'netbox.plugins': [
            'my_plugin = my_plugin.plugin:MyPluginConfig'
        ]
    }
)