FROM nginx:1.15
COPY ./environment/staging/nginx_static.conf /etc/nginx/nginx.conf
COPY ./static/ /usr/share/nginx/html/
