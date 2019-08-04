#!/bin/bash

set -euo pipefail

: $KUBECONFIG
: $VAGRANT_PRIVATE_NETWORK

echo -e "\nGet DEFAULT View Only token for Kubernetes Dashboard: \n"
kubectl -n monitoring describe secret $(kubectl -n monitoring get secret | awk '/^kubernetes-dashboard-token-/{print $1}') | awk '$1=="token:" {print $2}'
echo -e "\n"

# echo -e "\nGet Custom VIEW ONLY CUSTOM token for Kubernetes Dashboard: \n"
# kubectl -n monitoring describe secret $(kubectl -n monitoring get secret | awk '/^dashboard-view-only-token-/{print $1}') | awk '$1=="token:" {print $2}'
# echo -e "\n"

KUBEDASHBOARD_PORT=8443
echo "Kubernetes dashboard >> \"https://${VAGRANT_PRIVATE_NETWORK}:$KUBEDASHBOARD_PORT\" or \"https://localhost:8443\" if runnin not in VM "
kubectl -n monitoring --address 0.0.0.0 port-forward svc/kubernetes-dashboard $KUBEDASHBOARD_PORT:443 &
KUBEDASHBOARD_PROCESS=$!

echo -e "\npress ctrl-c to stop\n"

wait $KUBEDASHBOARD_PROCESS
