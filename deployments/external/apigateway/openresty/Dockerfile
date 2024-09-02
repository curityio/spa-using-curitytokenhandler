
FROM openresty/openresty:1.25.3.2-jammy

#
# Install luarocks, and set git options if required
#
RUN apt-get update && apt-get install git -y
RUN git config --global url."https://".insteadOf git:// && \
    git config --global advice.detachedHead false

#
# Install an example CORS plugin 
#
COPY openresty/cors/* /tmp/cors/
RUN cd /tmp/cors && luarocks make cors-*.rockspec \
     && cd / && rm -r /tmp/cors

#
# Install the OAuth Proxy plugin and its dependencies
#
COPY resources/plugin/* /tmp/oauth-proxy/
RUN cd /tmp/oauth-proxy && luarocks make oauth-proxy-*.rockspec \
    && cd / && rm -r /tmp/oauth-proxy 
