#!/bin/bash
sed -i 's/^PasswordAuth.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#Permit.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd
#echo "Raghu@1708" | passwd --stdin root [for centos]
echo "root:Raghu@1708"|chpasswd
echo "raghu  ALL=(ALL)  NOPASSWD:ALL" >> /etc/sudoers
