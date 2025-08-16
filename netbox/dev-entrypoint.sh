#!/usr/bin/env bash
set -euo pipefail

cd /opt/netbox/netbox

# Create symbolic link to the configuration.py file if it does not exist
echo "Creating symbolic link to configuration.py..."

if [ ! -e  /opt/netbox/netbox/configuration.flag ]; then
    
    # Remove existing file first - this is the one delivered with the NetBox image
    rm -f /opt/netbox/netbox/netbox/configuration.py

    # Create the symbolic link to the configuration file in the workspace    
    ln -s /workspace/netbox/configuration.py /opt/netbox/netbox/netbox/configuration.py
    touch /opt/netbox/netbox/configuration.flag
fi

# Finish configuration of NetBox
echo "Finalizing configuration and starting NetBox development server..."

exec /opt/netbox/docker-entrypoint.sh "$@"
