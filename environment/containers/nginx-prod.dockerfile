FROM nginx:1.17-alpine
COPY ./environment/containers/nginx-prod.conf /etc/nginx/nginx.conf
COPY ./static /static
COPY ./letsencrypt /etc/letsencrypt
