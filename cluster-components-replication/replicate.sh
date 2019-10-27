#!/bin/bash

# Create load balancer for kube-apiserver


# Create stacked etcd topology
kubeadm init --config kubeadm-config.yaml

# Watch k8s component pods being created
kubectl get po -n kube-system -w
