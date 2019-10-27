#!/bin/sh

# Install etcd
etcd_version="v3.3.12"
wget "https://github.com/etcd-io/etcd/releases/download/$etcd_version/etcd-$etcd_version-linux-amd64.tar.gz"
tar xvf etcd-$etcd_version-linux-amd64.tar.gz
sudo mv etcd-$etcd_version/etcd* /usr/local/bin

# Set etcd api version
export ETCDCTL_API=3 
# Take snapshot of etcd 
sudo etcdctl snapshot save etcd-snapshot.db \
        --cacert /etc/kubernetes/pki/etcd/server.crt \
        --cert /etc/kubernetes/pki/etcd/ca.crt \
        --key /etc/kubernetes/pki/etcd/ca.key

# Verify snapshot
etcdctl --write-out table snapshot status snapshot.db

# Zip etcd certs
sudo tar -zcvf etcd.tar.gz /etc/kubernetes/pki/etcd

echo "Please keep the backup and certs somewhere safe"
