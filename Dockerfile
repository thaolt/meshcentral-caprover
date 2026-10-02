FROM node:22.23.3-alpine3.24

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund

COPY . .
RUN chmod +x start.sh

# MeshCentral hard-codes its state dirs relative to the module location
# (parent of node_modules = /app). Redirect them into the mounted volume.
RUN ln -s /meshcenter/meshcentral-data /app/meshcentral-data && \
    ln -s /meshcenter/meshcentral-files /app/meshcentral-files && \
    ln -s /meshcenter/meshcentral-backups /app/meshcentral-backups && \
    ln -s /meshcenter/meshcentral-recordings /app/meshcentral-recordings

EXPOSE 443

VOLUME ["/meshcenter"]

ENTRYPOINT ["./start.sh"]
