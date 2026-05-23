# Dockerfile - Kong Gateway API Proxy

FROM kong:3.8

# Metadata
ARG BUILD_DATE
ARG VCS_REF
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.revision=$VCS_REF
LABEL org.opencontainers.image.title="Kong Gateway API Proxy"

# Variáveis de ambiente padrão
ENV KONG_DATABASE=off \
    KONG_PROXY_LISTEN="0.0.0.0:8000" \
    KONG_ADMIN_LISTEN="0.0.0.0:8001" \
    KONG_LOG_LEVEL="info"

# Copiar configuração do Kongs
RUN mkdir -p /etc/kong/config

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8001/status || exit 1

# Expor portas
EXPOSE 8000 8443 8001 8444

# Comando padrão
CMD ["kong", "start"]
