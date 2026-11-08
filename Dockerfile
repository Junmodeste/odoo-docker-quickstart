# Optional image: the official odoo:<version> image plus the Python packages of requirements.txt.
# Enabled by docker-compose.build.yml (see README); the default stack uses odoo:<version> as is.
ARG ODOO_VERSION=19
FROM odoo:${ODOO_VERSION}

USER root
COPY requirements.txt /tmp/requirements.txt
# Odoo 18/19 images (Ubuntu 24.04) mark the system Python as externally managed (PEP 668):
# PIP_BREAK_SYSTEM_PACKAGES allows the install there and is ignored by the older pip of odoo:17.
RUN PIP_BREAK_SYSTEM_PACKAGES=1 pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt
USER odoo
