#!/bin/bash

set -euo pipefail

: $KUBECONFIG
: $VAGRANT_PRIVATE_NETWORK


DOCKERREGISTRYPORT=8080
echo "CICD \"${VAGRANT_PRIVATE_NETWORK}:$DOCKERREGISTRYPORT/\""
echo "or \"localhost:${DOCKERREGISTRYPORT}\" if not running in VM"
kubectl -n cicd --address 0.0.0.0 port-forward svc/jenkins $DOCKERREGISTRYPORT:5000 &
DOCKERREGISTRY_PROCESS=$!

echo "sudo docker login ${VAGRANT_PRIVATE_NETWORK}:$DOCKERREGISTRYPORT"
echo -e "\npress ctrl-c to stop\n"

wait $DOCKERREGISTRY_PROCESS
