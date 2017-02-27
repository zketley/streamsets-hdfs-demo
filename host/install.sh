#!/bin/bash -e

[[ $(whoami) == "root" ]] || ( echo Must be run as root && exit 1 )
USERNAME=$1
[[ -z $USERNAME ]] && USERNAME=ubuntu # Default to the ubuntu user

# Install docker and docker-compose
curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"
apt update -y
apt install -y docker-engine docker-compose

# Add user to docker group
usermod -aG docker $USERNAME
