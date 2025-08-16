#!/usr/bin/env bash

chmod +x /workspace/netbox/dev-entrypoint.sh
exec /workspace/netbox/dev-entrypoint.sh "$@"
