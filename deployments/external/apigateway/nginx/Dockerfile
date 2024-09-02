FROM nginx:1.25.5-alpine

# Copy in the phantom token module
COPY resources/alpine.ngx_curity_http_phantom_token_module_1.25.5.so /usr/lib/nginx/modules/ngx_curity_http_phantom_token_module.so

# Copy in the OAuth proxy module
COPY resources/ngx_http_oauth_proxy_module.so /usr/lib/nginx/modules
