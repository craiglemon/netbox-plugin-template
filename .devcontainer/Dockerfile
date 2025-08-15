FROM netboxcommunity/netbox:latest

# Copy in the dev entrypoint and configuration.py
COPY ./dev-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
COPY ./configuration.py /opt/netbox/netbox/netbox/

RUN apt-get update && \
    apt-get install postgresql-client -y && \
    chmod +x /usr/local/bin/dev-entrypoint.sh && \
    rm -rf /var/lib/apt/lists/*

# Reset entrypoint to our wrapper
ENTRYPOINT [ "/usr/local/bin/dev-entrypoint.sh" ]

# Leave CMD to the docker-compose/devcontainer.json
CMD [ "/opt/netbox/venv/bin/python3", "/opt/netbox/netbox/manage.py", "runserver", "0.0.0.0:8080" ]

WORKDIR /workspace