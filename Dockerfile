FROM node:22.23.3-alpine3.24

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund

COPY . .
RUN chmod +x start.sh

EXPOSE 443

ENTRYPOINT ["./start.sh"]
