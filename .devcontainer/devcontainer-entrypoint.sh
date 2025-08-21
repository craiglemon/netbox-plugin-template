#!/usr/bin/env bash

# Set execution attribute and execute our linked startup script
#   We do this so that we can make changes to the mounted /workspace/netbox-dev-startup.sh script without the need to rebuild the docker image
chmod +x /workspace/netbox/netbox-dev-startup.sh
exec /workspace/netbox/netbox-dev-startup.sh