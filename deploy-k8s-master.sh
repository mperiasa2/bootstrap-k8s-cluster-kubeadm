#!/bin/bash

#------------------------------------------------------------------------------#
# This script is to setup Kubernetes cluster. It is intended to be executed on 
# master node. It uses kubeadm tool for cluster deployment and Calico CNI plugin
# and also uses CIDR 192.168.0.0/16 for pod networking.
#
# Compatible OS: Ubuntu 18.04 LTS
#------------------------------------------------------------------------------#

echo "--- Kubernetes Setup: master ---"

#update packages
echo "Updating packages"
sudo apt-get update && sudo apt-get upgrade -y
echo

sleep 1

echo "Installing Docker"
sudo apt-get install docker.io -y
sudo systemctl enable docker
echo

sleep 1

#disable swap
echo "Disabling swap permanently"
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
echo

sleep 1

echo "Installing Kubenetes"
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

sudo apt-get update
#sudo apt-get install kubeadm=1.18.1-00 kubelet=1.18.1-00 kubectl=1.18.1-00 -y
sudo apt-get install kubeadm kubelet kubectl -y
sudo apt-mark hold kubeadm kubelet kubectl
echo

sleep 3

echo "Initializing and configuring cluster"
version=`kubeadm version -o short | cut -d "v" -f2`

sudo kubeadm init --kubernetes-version ${version} --pod-network-cidr 192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo

sleep 1

echo "Applying Calico CNI plugin"
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
echo
echo "Completed."
