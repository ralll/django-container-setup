FROM nginx:1.17-alpine
COPY ./environment/containers/nginx-stag.conf /etc/nginx/nginx.conf
COPY ./stag-static /static
