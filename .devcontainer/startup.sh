#!/usr/bin/env bash

chmod +x /workspace/netbox/dev-entrypoint.sh
chmod +x /workspace/netbox/register-plugins.sh

exec /workspace/netbox/dev-entrypoint.sh "$@"
