#!/usr/bin/env bash

# Prevent double-sourcing
if [ -n "${__COMMON_SH_INCLUDED__:-}" ]; then
  return
fi

__COMMON_SH_INCLUDED__=1

link_config_file() {    
    echo "🔗 Creating symbolic link to configuration.py..."

    # /opt/netbox/netbox/netbox/configuration.py is not delivered with the netbox REPO
    #   Add a symbolic link to our configuration.py file in /workspace/netbox
    cfg_file_path="/opt/netbox/netbox/netbox/configuration.py"

    if [ ! -e "$cfg_file_path" ]; then
        ln -s /workspace/netbox/configuration.py $cfg_file_path
    fi  
}

wait_for_startup() {
    echo "🗄️ Waiting for database and redis containers to startup..."
    while ! nc -z "$DB_HOST" 5432; do sleep 1; done
    while ! nc -z "$REDIS_HOST" 6379; do sleep 1; done
}

install_plugins() {
    echo "⬇️ Installing named plugins..."
    pip install -e /opt/netbox/netbox/plugins/my_plugin
}

apply_updates() {

    if ! python3 /opt/netbox/netbox/manage.py migrate --check > /dev/null 2>&1; then

        echo "⚙️ Applying database migrations"
        python3 /opt/netbox/netbox/manage.py migrate --no-input
        
        echo "⚙️ Running trace_paths"
        python3 /opt/netbox/netbox/manage.py trace_paths --no-input

        echo "⚙️ Removing stale content types"
        python3 /opt/netbox/netbox/manage.py remove_stale_contenttypes --no-input

        echo "⚙️ Removing expired user sessions"
        python3 /opt/netbox/netbox/manage.py clearsessions

        echo "⚙️ Building search index (lazy)"
        python3 /opt/netbox/netbox/manage.py reindex --lazy

        echo "⚙️ Collecting static data"
        python3 /opt/netbox/netbox/manage.py collectstatic --no-input
    fi
}

create_superuser() {
    
    echo "💡 Creating Superuser Username: ${SUPERUSER_NAME}, E-Mail: ${SUPERUSER_EMAIL}"

    python3  /opt/netbox/netbox/manage.py shell --interface python <<END
from users.models import Token, User
if not User.objects.filter(username='${SUPERUSER_NAME}'):
    u = User.objects.create_superuser('${SUPERUSER_NAME}', '${SUPERUSER_EMAIL}', '${SUPERUSER_PASSWORD}')
    Token.objects.create(user=u, key='${SUPERUSER_API_TOKEN}')
END

}