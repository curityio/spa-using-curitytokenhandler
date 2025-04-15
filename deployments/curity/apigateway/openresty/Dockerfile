
FROM openresty/openresty:1.27.1.2-noble

#
# Install luarocks, and set git options if required
#
RUN apt-get update && apt-get install git -y
RUN git config --global url."https://".insteadOf git:// && \
    git config --global advice.detachedHead false

#
# Install an example CORS plugin 
#
COPY resources/examples/* /tmp/cors/
RUN cd /tmp/cors && luarocks make cors-*.rockspec \
     && cd / && rm -r /tmp/cors

#
# Install the OAuth Proxy plugin and its dependencies
#
COPY resources/plugin/* /tmp/oauth-proxy/
RUN cd /tmp/oauth-proxy && luarocks make oauth-proxy-*.rockspec \
    && cd / && rm -r /tmp/oauth-proxy 

#
# Install the Phantom Token plugin and its dependencies
#
RUN luarocks install lua-resty-phantom-token 2.0.1
