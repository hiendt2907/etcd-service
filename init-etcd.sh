#!/bin/bash
set -e

# Start etcd in background
etcd --data-dir=/bitnami/etcd/data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379 &

ETCD_PID=$!

# Đợi etcd sẵn sàng
sleep 5

# Tạo root user nếu chưa có
etcdctl user add ${ETCD_ROOT_USER}:${ETCD_ROOT_PASSWORD} || true

# Gán quyền root role
etcdctl user grant-role ${ETCD_ROOT_USER} root || true

# Bật authentication
etcdctl auth enable || true

# Dừng etcd background
kill $ETCD_PID
wait $ETCD_PID || true

# Khởi etcd chính (foreground) với auth
etcd --data-dir=/bitnami/etcd/data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379

