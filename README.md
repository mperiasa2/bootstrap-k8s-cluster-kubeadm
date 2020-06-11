A Kubernetes cluster can be bootstraped in many different ways. Bootstrapping using __kubeadm__ tool is quite easy when compared to other methods. However, one needs to follow a good amount of steps across clusters when it is done manually.


# Bootstrap Kubernetes Cluster (kubeadm)

## Objective
This repository holds the automated scripts for master and worker nodes to setup the cluster in no time. The scripts are developed for Ubuntu and can work well on _Ubuntu 18.04 Bionic Beaver_.

## Prerequisite
The master and worker nodes should be having Ubuntu (18.04 LTS is recommended) installed.

## Optional
It is nice to have a meaningful unique hostnames to each node. For example, hostname 'master' for master node and hostname 'node01' for worker node and so on.

## Procedure
1. Execute deployment script in master node as shown below.\
__master>__ ```bash deploy-k8s-master.sh```
2. Once successful check the cluster status by running:\
__master>__ ```kubectl get nodes```
3. Execute deployment script in worker node as shown below:\
__worker>__ ```bash deploy-k8s-worker.sh```
4. Now worker needs to be joined in the cluster. Run the below command in master node which will print to command to join.\
__master>__ ```kubeadm token create --print-join-command```
This would print kubeadm join command something like, \
```sudo kubeadm join ...``` Copy and execute the same in worker node(s).

That's all. If you run ```kubectl get nodes``` in master, you will see worker has joined the cluster.
