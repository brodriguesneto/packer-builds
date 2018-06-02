#!/bin/bash -eux

# SSH config
echo "-------> Configuring rc.local"
cat > /etc/rc.local <<EOF
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Avoid Duplicate SSH Host Keys
# Please execute "rm -v /etc/ssh/ssh_host_*" when cloning/creating templates
test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure -f noninteractive openssh-server

exit 0
EOF

chmod +x /etc/rc.local
