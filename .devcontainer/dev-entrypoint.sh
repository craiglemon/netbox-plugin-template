#!/usr/bin/env bash
set -euo pipefail

exec > /var/log/dev-entrypoint.log 2>&1

# 1. Create symbolic link from our plugins source to the netbox plugins directory. 
#   This allows us to develop plugins in the workspace and have them available in NetBox 
#       without needing to rebuild the container.
if [ ! -d /opt/netbox/netbox/plugins ]; then
    echo "Creating symbolic link to plugins directory..."
    ln -s /workspace/plugins /opt/netbox/netbox/plugins
fi

# 2. Wait for dependent services (Postgres, Redis) to be healthy
until pg_isready -h "$DB_HOST" -p "$DB_PORT"; do
  echo "Waiting for Postgres..."
  sleep 1
done

# 3. Run migrations to ensure the database schema is up to date
echo "Running database migrations..."
/opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py migrate --no-input

# 4. Collect static files
echo "Collecting static assets..."
/opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py collectstatic --no-input

# 5. Create superuser if not exists
/opt/netbox/venv/bin/python3 << END
import os
from django.contrib.auth import get_user_model

User = get_user_model()
username = os.environ.get("SUPERUSER_NAME", "admin")
email = os.environ.get("SUPERUSER_EMAIL", "admin@example.com")
password = os.environ.get("SUPERUSER_PASSWORD", "admin")

if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username=username, email=email, password=password)

END

# 6. Start the NetBox service
echo "Starting NetBox development server..."
exec "$@"
