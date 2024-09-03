FROM nginx:1.25.5-alpine

# TODO: Get from the GitHub after the release of phantom token 1.6.0
#RUN curl -s -L 'https://github.com/curityio/nginx_phantom_token_module/releases/download/1.6.0/alpine.ngx_curity_http_phantom_token_module_1.25.5.so' > /usr/lib/nginx/modules/ngx_curity_http_phantom_token_module.so
COPY resources/alpine.ngx_curity_http_phantom_token_module_1.25.5.so /usr/lib/nginx/modules/ngx_curity_http_phantom_token_module.so
COPY resources/nginx-1.25.5/alpine/ngx_http_oauth_proxy_module.so /usr/lib/nginx/modules
