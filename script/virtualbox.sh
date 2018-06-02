#!/bin/bash -eux

# VirtualBox provisioning
if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
  echo "-------> Installing VirtualBox guest utils"
  apt-get -y install dkms build-essential linux-headers-generic virtualbox-guest-dkms virtualbox-guest-utils
  rm -f /root/VBoxGuestAdditions.iso
  rm -f /root/.vbox_version
fi
