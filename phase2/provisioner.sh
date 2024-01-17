#!/usr/bin/env bash

# update package
sudo yum -y update

# install git
sudo yum install git -y

# Install Java 17
sudo yum install -y openjdk-17-jdk

git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar
