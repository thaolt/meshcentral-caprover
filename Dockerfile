FROM node:24-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund

COPY . .
RUN chmod +x start.sh

EXPOSE 443

ENTRYPOINT ["./start.sh"]
