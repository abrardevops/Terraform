#!/bin/bash -x
sudo su -
mkfs -t ext4 /dev/xvda
mount /dev/xvdg /
echo /dev/xvda  / ext4 defaults,nofail 0 2 >> /etc/fstab
###########
mkfs.xfs /dev/xvdf
mount /dev/xvdf /data
echo /dev/xvdf  /data xfs defaults,nofail 0 2 >> /etc/fstab
yum install nginx -y 
systemctl start nginx 
systemctl enable nginx
