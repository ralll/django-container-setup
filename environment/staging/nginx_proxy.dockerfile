FROM nginx:1.15
COPY ./environment/staging/nginx_proxy.conf /etc/nginx/nginx.conf
