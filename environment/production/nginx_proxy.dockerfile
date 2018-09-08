FROM nginx:1.15
COPY ./environment/production/nginx_proxy.conf /etc/nginx/nginx.conf
