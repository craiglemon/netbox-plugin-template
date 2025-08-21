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
#
# Attaching the debugger outputs the following warning:
#   Debugger warning: It seems that frozen modules are being used, which may make the debugger miss breakpoints. 
#   Please pass -Xfrozen_modules=off to python to disable frozen modules. 
#   Note: Debugging will proceed. Set PYDEVD_DISABLE_FILE_VALIDATION=1 to disable this validation.
#
# FIXME: Fix debugger warning about frozen modules above
#
echo "🛠 Starting NetBox server..."
exec python3 -m debugpy --listen 0.0.0.0:5678 --wait-for-client /opt/netbox/netbox/manage.py runserver 0.0.0.0:8000
