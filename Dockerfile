FROM bitnami/etcd:3.5.14
ENV ALLOW_NONE_AUTHENTICATION="no" \
    ETCD_LOG_LEVEL="info" \
    ETCD_MAX_SNAPSHOTS="5" \
    ETCD_MAX_WALS="5" \
    ETCD_USER="root" \
    ETCD_PASSWORD="L0caladm;;;"
EXPOSE 2379 2380
USER root
RUN install_packages curl ca-certificates && update-ca-certificates
USER 1001
HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -fsS http://127.0.0.1:2379/health | grep -q '"health":"true"' || exit 1
