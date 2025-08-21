FROM python:slim

# System dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential git libmariadb-dev-compat libmariadb-dev \
      libxml2-dev libxslt1-dev libpq-dev netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Ensure future RUN steps use the venv’s python & pip
ENV PATH="/opt/netbox/venv/bin:${PATH}"
WORKDIR /opt

# Clone NetBox core, install dependencies and requirements
RUN git clone --depth 1 https://github.com/netbox-community/netbox.git netbox && \
  cd netbox && \
  python3 -m venv /opt/netbox/venv && \
  pip install --upgrade pip setuptools wheel && \
  pip install -r requirements.txt && \
  pip install debugpy

# Copy entrypoint to inject debugpy
COPY devcontainer-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/devcontainer-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/devcontainer-entrypoint.sh"]
