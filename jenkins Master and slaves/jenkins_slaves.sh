#!/bin/bash
sudo useradd -m slave -p $(echo "test123" | openssl passwd -1 -stdin)
sudo sed -i '110a\slave ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
sudo sed -i '61s/#//; 63s/^/#/' /etc/ssh/sshd_config
sudo systemctl reload sshd

sudo sed -i '10d' /home/slave/.bash_profile
sudo sed -i '8 aJAVA_HOME=/usr/lib/jvm/jre-11-openjdk-11.0.18.0.10-1.amzn2.0.1.x86_64\n\nM2_HOME=/opt/maven/maven39\n\nPATH=$HOME/.local/bin:$HOME/bin:$JAVA_HOME:$M2_HOME/bin:$PATH' /home/slave/.bash_profile