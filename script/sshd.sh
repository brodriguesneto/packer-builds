#!/bin/bash -eux

# SSH config
echo "-------> Configuring SSHD"
echo "" >> /etc/ssh/sshd_config
echo "# DNS" >> /etc/ssh/sshd_config
echo "UseDNS no" >> /etc/ssh/sshd_config
sed -i "s/GSSAPIAuthentication yes/GSSAPIAuthentication no/" /etc/ssh/sshd_config
