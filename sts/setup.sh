#!/bin/sh

apt install nfs-kernel-server --fix-missing
systemctl enable nfs-server
systemctl start nfs-server


mkdir -p /srv/nfs/kubedata
mkdir /srv/nfs/kubedata/{pv0,pv1,pv2,pv3,pv4}
chmod -R 777 /srv/nfs
echo "/srv/nfs/kubedata    *(rw,sync,no_subtree_check,insecure)" >> /etc/exports

exportfs -rav
exportfs -v
showmount -e


##  to check server ip:       ip addr show dev ens3
## to confirm
## run this on k8s compute node 
## mount -t nfs 172.17.0.19:/srv/nfs/kubedata /mnt
