#!/bin/bash

set -euo pipefail

: $KUBECONFIG
: $VAGRANT_PRIVATE_NETWORK


user=$(kubectl get secret -n cicd jenkins -o jsonpath="{.data.jenkins-admin-user}" | base64 --decode)
pwd=$(kubectl get secret -n cicd jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode;)
echo -e "\nGet Get Jenkins User: ${user}"
echo -e "\nGet Get Jenkins Password: ${pwd}"
echo -e "\n"

CICD_PORT=8080
echo "CICD \"http://${VAGRANT_PRIVATE_NETWORK}:$CICD_PORT/\""
echo "or \"https://localhost:${CICD_PORT}\" if not running in VM"
kubectl -n cicd --address 0.0.0.0 port-forward svc/jenkins $CICD_PORT:8080 &
CICD_PROCESS=$!

echo -e "\npress ctrl-c to stop\n"

wait $CICD_PROCESS
