set -e
set -o xtrace
# Initialize cluster
netCidr="10.244.0.0/16"
sudo kubeadm init --pod-network-cidr=$netCidr

# Set up kubeconfig
mkdir -p $HOME/.kube
default_kubeconfig_file="/etc/kubernetes/admin.conf"
sudo cp -i $default_kubeconfig_file $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Apply fannel CNI network overlay
kubectl apply --debug -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Show initializer string
kubeadm init --pod-network-cidr 10.244.0.0/16

