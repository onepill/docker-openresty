docker-openresty
============

A OpenRest version of https://github.com/KyleAMathews/docker-nginx/

A high-performance OpenResty base image for Docker to serve static websites. It will serve anything in the `/var/www` directory.

To build a Docker image for your site, you'll need to create a `Dockerfile`. For example, if your site is in a directory called `src/`, you could create this `Dockerfile`:

    FROM onepill/docker-openresty
    COPY src/ /var/www

There is a difference between docker-openresty and docker-nginx, docker-openresty don't need CMD 'nginx' and the end of Dockerfile, since the parent Docker image openresty/openresty:alpine will have the ENTRYPOINT set, and it works just fine.

Then build and run it:

    $ docker build -t mysite .
    ...
    Successfully built 5ae2fb5cf4f8
    $ docker run -p 8080:80 -d mysite
    da809981545f
    $ curl localhost:8080
    ...

Docker Hub
----------
The trusted build information can be found on the Docker Hub at https://hub.docker.com/r/onepill/docker-openresty/

SSL
---

To use SSL, put your certs in `/usr/local/openresty/nginx/conf/ssl` and enable the `default-ssl` site:

    ADD server.crt /usr/local/openresty/nginx/conf/ssl/
    ADD server.key /usr/local/openresty/nginx/conf/ssl/
    RUN ln -s /usr/local/openresty/nginx/conf/sites-available/default-ssl /usr/local/openresty/nginx/conf/sites-enabled/default-ssl

When you run it, you'll want to make port 443 available, e.g.:

    $ docker run -p 80:80 -p 443:443 -d mysite


nginx.conf
---------

The nginx.conf and mime.types are pulled with slight modifications from
the h5bp Nginx HTTP server boilerplate configs project at
https://github.com/h5bp/server-configs-nginx

Customized configs
------------------

To modify the NGINX config, you would just create a custom Dockerfile like the following
where you copy in your modified config files.

```dockerfile
# Guide here:
# https://github.com/onepill/docker-openresty

# Build docker file
# docker build -t CONTAINERNAME .

# Build from this repo's image
FROM onepill/docker-openresty

# Example if you wanna swap the default server file.
COPY path/to/your/default /usr/local/openresty/nginx/conf/sites-enabled/default

# Add src.
COPY src/ /var/www

```
