FROM netboxcommunity/netbox:latest

COPY ../netbox/dev-entrypoint.sh /usr/local/bin/dev-entrypoint.sh

RUN apt-get update && \
    apt-get install postgresql-client -y && \
    chmod +x /usr/local/bin/dev-entrypoint.sh && \
    rm -rf /var/lib/apt/lists/*

# Entrypoint to our wrapper
ENTRYPOINT [ "/usr/local/bin/dev-entrypoint.sh" ]

# Set the default command to run the NetBox development server
#   These parameters are passed into the dev-entrypoint.sh script as command args
CMD [ "/opt/netbox/venv/bin/python3", "/opt/netbox/netbox/manage.py", "runserver", "0.0.0.0:8080" ]

WORKDIR /workspace