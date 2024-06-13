FROM kong/kong:latest-ubuntu

USER root
RUN apt-get update
RUN apt-get install -y git unzip

# Install the phantom token plugin from luarocks
RUN git config --global url."https://".insteadOf git:// && \
    git config --global advice.detachedHead false && \
    luarocks install kong-phantom-token 2.0.0

# Copy in the OAuth proxy plugin files
COPY resources/plugin/handler.lua \
     resources/plugin/logic.lua \
     resources/plugin/schema.lua \
     /usr/local/share/lua/5.1/kong/plugins/oauth-proxy/

USER kong
