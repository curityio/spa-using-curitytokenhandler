FROM kong:latest

# Copy in the OAuth proxy plugin files
COPY resources/plugin/handler.lua \
     resources/plugin/logic.lua \
     resources/plugin/schema.lua \
     /usr/local/share/lua/5.1/kong/plugins/oauth-proxy/
