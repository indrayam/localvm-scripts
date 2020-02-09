#!/bin/bash
VM_NAME="${1:-xenial}"
multipass launch -n ${VM_NAME} -c 2 -m 1G --cloud-init $HOME/workspace/localvm-scripts/xenial.yaml xenial
