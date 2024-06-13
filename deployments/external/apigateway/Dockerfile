FROM kong/kong:latest-ubuntu

# Copy in the OAuth proxy plugin files
COPY resources/kong/plugin/handler.lua \
     resources/kong/plugin/logic.lua \
     resources/kong/plugin/schema.lua \
     /usr/local/share/lua/5.1/kong/plugins/oauth-proxy/
