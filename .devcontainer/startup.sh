#! /bin/sh

echo "Running startup script..."

# Create symbolic link from our plugins source to the netbox plugins directory. This allows us to develop plugins 
# in the workspace and have them available in NetBox without needing to rebuild the container.
echo "Creating symbolic link to plugins directory..."
ln -s /workspace/plugins /opt/netbox/netbox/plugins

# Create symbolic link for the NetBox configuration file
echo "Creating symbolic link to configuration file..."
mv /opt/netbox/netbox/netbox/configuration.py configuration.py.bak
ln -s /workspace/configuration.py /opt/netbox/netbox/netbox/configuration.py

# Run migrations to ensure the database schema is up to date
echo "Running database migrations..."
/opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py migrate --no-input

echo "Done!"