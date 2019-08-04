#!/bin/bash

set -euo pipefail

: $AWS_STATE_BUCKET
: $PROJECT_ID
: $KUBECONFIG
: $REGION

PROJECT=terraform/gcp/dev

COMMAND=${1:-plan}

MODULE="${PWD}/terraform/cluster/provision"

# initialize helm
helm init --client-only
helm repo update
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.2.2/charts/

export TF_VAR_project=${PROJECT_ID}
export TF_VAR_region=${REGION}
export TF_VAR_bucket=${AWS_STATE_BUCKET}
export TF_VAR_kub_config="${KUBECONFIG}"

STATE="clusterprovision.tfstate"
MODULE="${PWD}/terraform/cluster-provision"

on_exit() {
  set +e
  rm terraform/cluster-provision/backend.tf
  rm terraform/cluster-provision/${REGION}.standard-storage.yaml
  rm terraform/cluster-provision/${REGION}.*
  echo "list installed applications"
  helm ls --tiller-namespace helm
}
trap on_exit EXIT

# copy backend
cp terraform/commons/aws.backend.tf terraform/cluster-provision/backend.tf
# terraform kubernetes not yet support storages
cp terraform/commons/aws.standard-storage.yaml terraform/cluster-provision/${REGION}.standard-storage.yaml
# replace REGION
sed -i -e "s/aws_region/${REGION}/g" terraform/cluster-provision/${REGION}.standard-storage.yaml
kubectl apply -f terraform/cluster-provision/${REGION}.standard-storage.yaml

terraform init \
-backend-config="bucket=${AWS_STATE_BUCKET}" \
-backend-config="key=${STATE}" \
-backend-config="encrypt=true" \
-backend-config="region=${REGION}" \
-backend=true -get=true -force-copy \
-reconfigure \
-reconfigure $MODULE

terraform ${COMMAND} -auto-approve  \
-refresh=true \
-var-file="${PWD}/inventory/cluster-provision.tfvars" \
-var-file="${PWD}/inventory/aws-infrastructure.tfvars" \
$MODULE


# helm install --namespace default stable/nginx --tiller-namespace tiller-system

# helm ls --all metrics-server --tiller-namespace tiller-system
# helm del --purge metrics-server --tiller-namespace tiller-system
# helm search -l
# helm del --purge kubernetes-dashboard --tiller-namespace helm