
FROM openresty/openresty:1.25.3.2-jammy

# Copy the OAuth proxy plugin files
COPY resources/openresty/plugin/ \
resources/common-lua-nginx/*.lua \
/tmp/oauth-proxy/

RUN cd /tmp/oauth-proxy && luarocks make oauth-proxy-*.rockspec \
&& cd / && rm -r /tmp/oauth-proxy 

# Also copy the CORS module for testing
COPY resources/openresty/testing/api-gateway/cors.lua \
openresty/cors-*.rockspec \
/tmp/cors/

RUN cd /tmp/cors && luarocks make cors-*.rockspec \
&& cd / && rm -r /tmp/cors
