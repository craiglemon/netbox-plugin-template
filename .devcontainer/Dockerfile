FROM netboxcommunity/netbox:latest

COPY ../netbox/dev-entrypoint.sh /usr/local/bin/dev-entrypoint.sh

RUN apt-get update && \
    apt-get install postgresql-client python3-venv -y && \
    chmod +x /usr/local/bin/dev-entrypoint.sh && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m venv /opt/netbox/venv

# Entrypoint to our wrapper
ENTRYPOINT [ "/usr/local/bin/dev-entrypoint.sh" ]

# Set the default command to run the NetBox development server
#   These parameters are passed into the dev-entrypoint.sh script as command args
CMD [ "/opt/netbox/venv/bin/python3", "/opt/netbox/netbox/manage.py", "runserver", "0.0.0.0:8080" ]

WORKDIR /workspace