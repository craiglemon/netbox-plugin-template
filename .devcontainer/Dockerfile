FROM netboxcommunity/netbox:latest

COPY ../.devcontainer/startup.sh /usr/local/bin/startup.sh

RUN apt-get update && \
    apt-get install postgresql-client python3-venv -y && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m venv /opt/netbox/venv && \
    chmod +x /usr/local/bin/startup.sh

# Entrypoint to our wrapper
#   startup.sh is a static file that is copied into the container, which in turn sets +x on /workspace/netbox/dev-entrypoint.sh before
#   executing it. This allows us to run the dev-entrypoint.sh script with the correct permissions and without needing to modify the 
#   Dockerfile and base image when making changes to dev-entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/startup.sh" ]

# Set the default command to run the NetBox development server
#   These parameters are eventually passed into dev-entrypoint.sh script as command args
CMD [ "/opt/netbox/venv/bin/python3", "/opt/netbox/netbox/manage.py", "runserver", "0.0.0.0:8080" ]

WORKDIR /workspace