FROM ubuntu:latest

# update system
RUN apt-get update

# Install dependencies
RUN apt-get install -y sudo curl rsyslog openjdk-8-jdk

# disable sudo password requirement
RUN sed -e 's/^%sudo	.*/%sudo	ALL=NOPASSWD:ALL/g' -i /etc/sudoers
