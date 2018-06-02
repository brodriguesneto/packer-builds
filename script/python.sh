#!/bin/bash -eux

# Make python3 as default
echo "-------> Make Python 3 as default"
update-alternatives --install /usr/bin/python python /usr/bin/python3 1
