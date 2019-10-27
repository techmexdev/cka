#!/bin/bash
set -xe

# Find what node pod is running on
kubectl get po -o wide -l app=nginx 

node_name=""
# Log in to node
ssh node $node_name

# View virtual network interfaces
ifconfig

# Find the nginx container's id
docker ps

container_id=""

# Find the process ID for the container
docker inspect --format '{{ .State.Pid }}' $container_id

# Use nsenter to run a command in the process's network namespace
# Find network interface eth0 is mapped to
container_pid=""
nsenter -t $container_pid -n ip addr

# Find network interface eth0 is mapped to
ifconfig

