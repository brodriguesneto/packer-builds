#!/bin/bash -eux

# Upgrade and reboot
echo "-------> Upgrade and reboot"
apt-get update
apt-get -y  upgrade
reboot