#!/bin/bash -eux

# Install tooling
echo "-------> Install tooling"
apt-get update
apt-get -y  install ssh curl aptitude vim htop net-tools gnupg software-properties-common