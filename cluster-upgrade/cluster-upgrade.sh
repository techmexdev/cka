#!/bin/bash

kubectl version --short
kubectl describe nodes
kubectl get po -l ... -o yaml -n kube-system
