Services allow our pods to move around, get deleted, and replicate, all without having to manually keep track of their IP addresses in the cluster. This is accomplished by creating one gateway to distribute packets evenly across all pods. In this lesson, we will see the differences between a NodePort service and a ClusterIP service and see how the iptables rules take effect when traffic is coming in.

YAML for the nginx NodePort service:

apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  type: NodePort
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
    nodePort: 30080
  selector:
    app: nginx

Get the services YAML output for all the services in your cluster:

kubectl get services -o yaml

Try and ping the clusterIP service IP address:

ping x.x.x.x

View the list of services in your cluster:

kubectl get services

View the list of endpoints in your cluster that get created with a service:

kubectl get endpoints

Look at the iptables rules for your services:

sudo iptables-save | grep KUBE | grep nginx

