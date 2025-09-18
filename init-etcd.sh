#!/bin/bash
set -e

# đợi etcd lên
sleep 5

# tạo user root nếu chưa có
etcdctl --endpoints=http://127.0.0.1:2379 \
  user add ${ETCD_ROOT_USER}:${ETCD_ROOT_PASSWORD} || true

# gán root role
etcdctl --endpoints=http://127.0.0.1:2379 \
  user grant-role ${ETCD_ROOT_USER} root || true

# bật authentication
etcdctl --endpoints=http://127.0.0.1:2379 \
  auth enable || true

