#!/usr/bin/env bash

# update package
sudo yum -y update

# install git
sudo yum install git -y

#insall docker 
sudo yum install docker -y
sudo systemctl start docker

# Install Packer
wget https://releases.hashicorp.com/packer/1.7.4/packer_1.7.4_linux_amd64.zip
unzip packer_1.7.4_linux_amd64.zip
sudo mv packer /usr/local/bin/
rm packer_1.7.4_linux_amd64.zip

git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar
