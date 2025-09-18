FROM bitnami/etcd:3.5.14

USER root

ENV ETCD_ROOT_USER="root" \
    ETCD_ROOT_PASSWORD="L0caladm;;;" \
    ETCD_LOG_LEVEL="info" \
    ETCD_MAX_SNAPSHOTS="5" \
    ETCD_MAX_WALS="5" \
    ALLOW_NONE_AUTHENTICATION="no"

# Copy script khởi tạo user + bật auth
COPY init-etcd.sh /docker-entrypoint-init.sh

RUN chmod +x /docker-entrypoint-init.sh

EXPOSE 2379 2380

ENTRYPOINT ["/docker-entrypoint-init.sh"]

