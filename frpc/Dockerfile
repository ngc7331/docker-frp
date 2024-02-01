FROM --platform=${TARGETPLATFORM} ghcr.io/linuxserver/baseimage-ubuntu:jammy
ARG TARGETPLATFORM

ENV CONFIG_PATH=/config

ARG FRP_VERSION=0.54.0
ENV FRP_CONFIG_PATH=${CONFIG_PATH}/frpc
RUN curl -Ljo frp.tar.gz "https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${TARGETPLATFORM#linux/}.tar.gz" && \
    tar -xzvf frp.tar.gz --directory /usr/bin/ "frp_${FRP_VERSION}_linux_${TARGETPLATFORM#linux/}/frpc" --strip-components 1 && \
    rm frp.tar.gz && \
    frpc --version

ENV SERVER_ADDR=0.0.0.0
ENV SERVER_PORT=7000

ENV AUTH_METHOD=token
ENV AUTH_TOKEN=changeme
ENV AUTH_OIDC_ID=
ENV AUTH_OIDC_SECRET=
ENV AUTH_OIDC_AUDIENCE=
ENV AUTH_OIDC_ENDPOINT=

ENV WEBUI_USER=admin
ENV WEBUI_PASS=changeme

ENV PROXY_USER=user

ENV TZ="Asia/Shanghai"
ENV PUID=1000
ENV PGID=1000
ENV UMASK=002
COPY root/ /

EXPOSE 7400/tcp

VOLUME [ "/config" ]
