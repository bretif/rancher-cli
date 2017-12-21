FROM alpine:latest

LABEL maintainer="bretuf@phosphore.eu"

# Define rancher version
ENV RANCHER_CLI_VERSION=v0.6.5
ENV RANCHER_COMPOSE_VERSION=v0.12.5

# Install dependencies and rancher
RUN apk --update add tar docker && \
    apk add --quiet --no-cache ca-certificates && \
    apk add --quiet --no-cache --virtual build-dependencies curl && \
    curl -sSL "https://github.com/rancher/cli/releases/download/${RANCHER_CLI_VERSION}/rancher-linux-amd64-${RANCHER_CLI_VERSION}.tar.gz" | tar -xz -C /usr/local/bin/ --strip-components=2 && \
    curl -sSL "https://github.com/rancher/rancher-compose/releases/download/${RANCHER_COMPOSE_VERSION}/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz" | tar -xz -C /usr/local/bin/ --strip-components=2 && \
    chmod +x /usr/local/bin/rancher* && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

# Set working directory 
WORKDIR /workspace
# Executing defaults
CMD ["/bin/sh"]
