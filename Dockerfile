FROM openresty/openresty:alpine
MAINTAINER Siyuan Zhang "onepill@gmail.com"

RUN rm /usr/local/openresty/nginx/conf/nginx.conf /usr/local/openresty/nginx/conf/mime.types
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY basic.conf /usr/local/openresty/nginx/conf/basic.conf
COPY mime.types /usr/local/openresty/nginx/conf/mime.types
RUN mkdir /usr/local/openresty/nginx/conf/ssl
RUN mkdir /usr/local/openresty/nginx/conf/site-enabled
RUN mkdir /usr/local/openresty/nginx/conf/site-available
COPY default /usr/local/openresty/nginx/conf/sites-enabled/default
COPY default-ssl /usr/local/openresty/nginx/conf/etc/sites-available/default-ssl
COPY directive-only /usr/local/openresty/nginx/conf/directive-only
COPY location /usr/local/openresty/nginx/conf/location

# expose both the HTTP (80) and HTTPS (443) ports
EXPOSE 80 443

ENTRYPOINT ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
