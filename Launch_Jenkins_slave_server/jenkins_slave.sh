#!/bin/bash
sudo yum update -y
useradd -m -d /home/slave -c "jenkins slave user " slave
echo "test123" | passwd --stdin slave
sed -i '110a\slave ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
su - slave
sudo sed -i '61s/#//; 63s/^/#/' /etc/ssh/sshd_config
sudo systemctl reload sshd

sudo amazon-linux-extras install -y java-openjdk11
sudo yum install -y git
sudo mkdir /opt/maven
cd /opt/maven
sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz
sudo tar -xvzf /opt/maven/apache-maven-3.9.1-bin.tar.gz
sudo mv apache-maven-3.9.1 maven39
sudo rm -rf apache-maven-3.9.1-bin.tar.gz
sed -i '10d' /home/slave/.bash_profile
sed -i '8 aJAVA_HOME=/usr/lib/jvm/jre-11-openjdk-11.0.18.0.10-1.amzn2.0.1.x86_64\n\nM2_HOME=/opt/maven/maven39\n\nPATH=$HOME/.local/bin:$HOME/bin:$JAVA_HOME:$M2_HOME/bin:$PATH' /home/slave/.bash_profile
