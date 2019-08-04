#!/bin/bash

set -euo pipefail

: $KUBECONFIG
: $VAGRANT_PRIVATE_NETWORK

namespace=istio-system

user=$(kubectl get secret -n $namespace kiali -o jsonpath="{.data.username}" | base64 --decode)
pwd=$(kubectl get secret -n $namespace kiali -o jsonpath="{.data.passphrase}" | base64 --decode)
echo -e "\nKiali Username: ${user}"
echo -e "\nKiali Password: ${pwd}"
echo -e "\n"

KIALIPORT=9091
echo "Kiali \"http://${VAGRANT_PRIVATE_NETWORK}:$KIALIPORT\""
echo "or \"https://localhost:${KIALIPORT}\" if not running in VM"
kubectl -n $namespace --address 0.0.0.0 port-forward svc/kiali $KIALIPORT:20001 &
KIALI_PROCESS=$!

ZIPKINPORT=9090
echo "Zipkin \"http://${VAGRANT_PRIVATE_NETWORK}:$ZIPKINPORT\""
echo "or \"https://localhost:${ZIPKINPORT}\" if not running in VM"
kubectl -n $namespace --address 0.0.0.0 port-forward svc/zipkin $ZIPKINPORT:9411 &
ZIPKIN_PROCESS=$!


TRACING_PORT=8080
echo "Tracing \"http://${VAGRANT_PRIVATE_NETWORK}:$TRACING_PORT\""
echo "or \"https://localhost:${TRACING_PORT}\" if not running in VM"
kubectl -n $namespace --address 0.0.0.0 port-forward svc/tracing $TRACING_PORT:80 &
TRACING_PROCESS=$!

echo -e "\npress ctrl-c to stop\n"


wait $KIALI_PROCESS $ZIPKIN_PROCESS $TRACING_PROCESS

