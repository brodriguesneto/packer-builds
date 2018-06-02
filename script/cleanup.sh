#!/bin/bash -eux

# Cleaning up

# Removing leftover leases
echo "-------> Cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Clean up APT
echo "-------> Cleaning up"
dpkg --list | awk '{ print $2 }' | grep 'linux-image-4.*-generic' | grep -v $(uname -r) | xargs apt-get -y purge
dpkg --list | awk '{ print $2 }' | grep -- '-dev$' | xargs apt-get -y purge
dpkg --list | awk '{ print $2 }' | grep -- '-doc$' | xargs apt-get -y purge
apt-get -y purge ppp pppconfig pppoeconf
apt-get -y autoremove --purge
apt-get -y autoclean
apt-get -y clean
find /var/lib/apt -type f | xargs rm -f
find /var/cache -type f -exec rm -rf {} \;
rm -rf /tmp/*
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/${SSH_USER}/.bash_history
find /var/log -type f | while read f; do echo -ne '' > $f; done;
>/var/log/lastlog
>/var/log/wtmp
>/var/log/btmp

# SSH keys
echo "-------> Delete old ssh host keys"
rm -v /etc/ssh/ssh_host_*

# Zero out the free space to save space in the final image:
if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
  # zeroing swap disk
  set +e
  swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
  case "$?" in
    2|0)
      ;;
    *)
      exit 1 ;;
  esac
  set -e
  if [ "x${swapuuid}" != "x" ]; then
    swappart=$(readlink -f /dev/disk/by-uuid/$swapuuid)
    /sbin/swapoff "${swappart}"
    dd if=/dev/zero of="${swappart}" bs=1M || echo "dd exit code $? is suppressed"
    /sbin/mkswap -U "${swapuuid}" "${swappart}"
  fi

  # zeroing disk/partitions
  for i in $(mount |grep "^/dev" |awk '{print $3}' |sort)
   do
     dd if=/dev/zero of=$i/EMPTY bs=1M || echo "dd exit code $? is suppressed"
     rm -f $i/EMPTY
  done

  # write down to disk with sure!
  sync
  sync
  sync
fi
