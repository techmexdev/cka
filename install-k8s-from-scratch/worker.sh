#!/bin/bash
master-id=$1

# Join master's cluster
kubeadm join $master-id

# Verify node joined cluster
kubectl get node
