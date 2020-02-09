#!/bin/bash
VM_NAME="${1:-xenial-lite}"
multipass launch -n ${VM_NAME} -c 2 -m 1G --cloud-init $HOME/workspace/localvm-scripts/xenial-lite.yaml xenial
