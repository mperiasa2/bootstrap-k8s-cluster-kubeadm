#!/bin/bash

#------------------------------------------------------------------------------#
# This script is to setup Kubernetes cluster. It is intended to be executed on 
# worker node. It uses kubeadm tool for cluster deployment.
#
# Compatible OS: Ubuntu 18.04 LTS
#------------------------------------------------------------------------------#

echo "--- Kubernetes Setup: worker ---"

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
echo "Completed."
