#!/bin/bash
sudo yum update -y
sudo -i
useradd -m -d /home/ansadmin -c "Docker user " ansadmin
echo "test123" | passwd --stdin ansadmin
sed -i '110a\ansadmin ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
su - ansadmin
sudo yum install docker -y 
sudo service docker start
sudo usermod -aG docker ansadmin
sudo sed -i '61s/#//; 63s/^/#/' /etc/ssh/sshd_config
sudo systemctl reload sshd
sudo mkdir /opt/docker
sudo chown -R ansadmin: /opt/docker