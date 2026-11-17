FROM nginx:alpine

LABEL org.opencontainers.image.title="workstation-practice-web" \
      org.opencontainers.image.description="Custom NGINX server for workstation practice"

ENV APP_ENV=production

COPY app/ /usr/share/nginx/html/

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:80/ || exit 1

EXPOSE 80
