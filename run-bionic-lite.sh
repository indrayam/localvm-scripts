#!/bin/bash
VM_NAME="${1:-bionic-lite}"
multipass launch -n ${VM_NAME} -c 2 -m 1G --cloud-init $HOME/workspace/localvm-scripts/bionic-lite.yaml bionic
