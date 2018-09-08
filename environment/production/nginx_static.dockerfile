FROM nginx:1.15
COPY ./environment/production/nginx_static.conf /etc/nginx/nginx.conf
COPY ./static/ /usr/share/nginx/html/
