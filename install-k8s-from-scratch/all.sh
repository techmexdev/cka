!#/bin/bash
set -o xtrace
set -e

# Get docker gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs)\
        stable"

# Get K8s gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add k8s repository
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Update packages
sudo apt-get update

# Install docker, kubelet, kubeadm, kubectl
sudo apt-get install -y kubelet kubeadm kubectl docker-ce=5:18.09.9~3-0~ubuntu-bionic
sudo apt-get install 

# Use systemd as docker cgroup driver
sudo bash -c "cat > /etc/docker/daemon.json" <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
sudo systemctl daemon-reload
sudo systemctl restart docker

# Add ip tables rule to sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf

# Enable iptables
sudo sysctl -p

