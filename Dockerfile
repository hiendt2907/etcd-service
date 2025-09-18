FROM bitnami/etcd:3.5.14

# ===================== ENV =====================
ENV ETCD_ROOT_PASSWORD="L0caladm;;;" \
    ETCD_ROOT_USER="root" \
    ALLOW_NONE_AUTHENTICATION="no" \
    ETCD_LOG_LEVEL="info" \
    ETCD_MAX_SNAPSHOTS="5" \
    ETCD_MAX_WALS="5"

# ===================== EXPOSE =====================
EXPOSE 2379 2380

# ===================== TOOLs =====================
USER root
RUN install_packages curl ca-certificates && update-ca-certificates

# ===================== SCRIPT =====================
COPY init-etcd.sh /docker-entrypoint-init.d/init-etcd.sh
RUN chmod +x /docker-entrypoint-init.d/init-etcd.sh

USER 1001

# ===================== HEALTHCHECK =====================
HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -fsS http://127.0.0.1:2379/health | grep -q '"health":"true"' || exit 1

