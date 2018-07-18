#!/bin/bash

########################
# Jenkins & Java
########################
echo "Installing Jenkins and Java"
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update > /dev/null 2>&1
sudo apt-get -y install default-jdk jenkins > /dev/null 2>&1
sudo cp /mnt/host_machine/JenkinsConfig/config.xml /var/lib/jenkins/
sudo mkdir -p /var/lib/jenkins/users/admin
sudo cp /mnt/host_machine/JenkinsConfig/users/admin/config.xml /var/lib/jenkins/users/admin/
sudo chown -R jenkins:jenkins /var/lib/jenkins/users/

########################
# Node & npm
########################
echo "Installing Node & npm"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get -y install nodejs
sudo apt-get -y install npm

########################
# Docker
########################
echo "Installing Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce
sudo systemctl enable docker
sudo usermod -aG docker ${USER}
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

########################
# nginx
########################
echo "Installing nginx"
sudo apt-get -y install nginx > /dev/null 2>&1
sudo service nginx start

########################
# Configuring nginx
########################
echo "Configuring nginx"
cd /etc/nginx/sites-available
sudo rm default ../sites-enabled/default
sudo cp /mnt/host_machine/VirtualHost/jenkins /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
sudo service nginx restart
sudo service jenkins restart

########################
# Adding title to MOTD
########################
sudo apt-get install update-motd
sudo cat $VAGRANT_HOST_DIR/motd.sh > /etc/update-motd.d/01-header
sudo chmod 755 /etc/update-motd.d/01-header
sudo /usr/sbin/update-motd

echo "Success"


