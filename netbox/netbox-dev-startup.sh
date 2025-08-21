#!/usr/bin/env bash

# Locate this script’s directory so we can include common.sh relative to it, and . source it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/common.sh"

echo "🛠 Executing netbox-dev-startup.sh..."

link_config_file

wait_for_startup

install_plugins

apply_updates

create_superuser

echo "✅ Done!"

# Start debugpy and NetBox runserver
echo "🛠 Starting NetBox server..."
exec python3 -Xfrozen_modules=off -m debugpy --listen 0.0.0.0:5678 --wait-for-client /opt/netbox/netbox/manage.py runserver 0.0.0.0:8000
