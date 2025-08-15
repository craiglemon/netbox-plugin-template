FROM netboxcommunity/netbox:latest

# Copy in the dev entrypoint and configuration.py
COPY ./dev-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
COPY ./configuration.py /opt/netbox/netbox/netbox/

RUN chmod +x /usr/local/bin/dev-entrypoint.sh

# Reset entrypoint to our wrapper
ENTRYPOINT [ "/usr/local/bin/dev-entrypoint.sh" ]

# Leave CMD to the docker-compose/devcontainer.json
CMD [ "/opt/netbox/venv/bin/python3", "netbox/manage.py", "runserver", "0.0.0.0:8000" ]

WORKDIR /workspace