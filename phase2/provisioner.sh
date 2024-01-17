#!/usr/bin/env bash

# update package
sudo yum -y update

# install git
sudo yum install git -y

# Install Java 17
sudo yum install -y curl
curl -O https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz
sudo tar -xzvf openjdk-17_linux-x64_bin.tar.gz -C /opt

echo 'export JAVA_HOME=/opt/jdk-17' | sudo tee -a /etc/profile.d/java.sh
echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile.d/java.sh
sudo chmod +x /etc/profile.d/java.sh
source /etc/profile.d/java.sh

git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar
