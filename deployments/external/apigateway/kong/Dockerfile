FROM kong/kong:3.7-ubuntu

USER root
RUN apt-get update
RUN apt-get install -y git unzip

#
# Install luarocks, and set git options if required
#
RUN git config --global url."https://".insteadOf git:// && \
    git config --global advice.detachedHead false
    
#
# Install the OAuth Proxy plugin and its dependencies
#
COPY resources/plugin/*.lua \
    resources/plugin/oauth-proxy-*.rockspec \
    /tmp/oauth-proxy/
RUN cd /tmp/oauth-proxy && luarocks make oauth-proxy-*.rockspec \
    && cd / && rm -r /tmp/oauth-proxy 
