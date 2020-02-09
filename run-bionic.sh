#!/bin/bash
VM_NAME="${1:-bionic}"
multipass launch -n ${VM_NAME} -c 2 -m 2G --cloud-init $HOME/workspace/localvm-scripts/bionic.yaml bionic
