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

# When running the pip install command to install the plugin, the following warning is displayed:
#   DEPRECATION: Legacy editable install of my_plugin==0.1 from file:///opt/netbox/netbox/plugins/my_plugin (setup.py develop) is deprecated. 
#   pip 25.3 will enforce this behaviour change. A possible replacement is to add a pyproject.toml or enable --use-pep517, and use setuptools >= 64. 
#   If the resulting installation is not behaving as expected, try using --config-settings editable_mode=compat. Please consult the setuptools 
#   documentation for more information. Discussion can be found at https://github.com/pypa/pip/issues/11457⁠
#
#   FIXME: Fix the above deprecation warning when installing the plugin
#
install_plugins() {
    # TODO: change this so that they are loaded dynamically form an environment variable - perhaps comma-separated
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