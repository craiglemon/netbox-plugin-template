#!/usr/bin/env bash
set -euo pipefail

cd /opt/netbox/netbox

# 1. Create symbolic link from our plugins source to the netbox plugins directory. 
if [ ! -d /opt/netbox/netbox/plugins ]; then
    echo "Creating symbolic link to plugins directory..."
    ln -s /workspace/plugins /opt/netbox/netbox/plugins
fi

# 2. Finish configuration of NetBox
echo "Finalizing configuration and starting NetBox development server..."
exec /opt/netbox/docker-entrypoint.sh "$@"

# 3. Start the NetBox service
#echo "Starting NetBox development server..."
#exec "$@"
