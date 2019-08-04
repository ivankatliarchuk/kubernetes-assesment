#!/bin/bash

set -euo pipefail

: $TF_STATE_BUCKET
: $PROJECT_ID

PROJECT=terraform/gcp/dev

COMMAND=${1:-plan}

# TODO:create bucket manually

STATE_BUCKET="aws-k8s-states"
STATE="infrastructure.tfstate"
MODULE="${PWD}/terraform/aws/infrastructure"
TF_VARS="inventory/aws-infrastructure.tfvars"

export TF_VAR_project=${PROJECT_ID}
export TF_VAR_private_ssh_path="${PWD}/inventory/cust_id_rsa"
export TF_VAR_inventory_path="${PWD}/inventory"

terraform init \
-backend-config="bucket=${STATE_BUCKET}" \
-backend-config="key=${STATE}" \
-backend-config="encrypt=true" \
-backend-config="region=us-west-2" \
-backend=true -get=true -force-copy \
-reconfigure \
-reconfigure $MODULE

terraform ${COMMAND} -auto-approve \
-refresh=true \
-var-file="${PWD}/${TF_VARS}" \
$MODULE


chmod 400 ${TF_VAR_private_ssh_path}
if [[ "$OSTYPE" == "darwin"* ]]; then
  ssh-add -D
  ssh-add -K ${TF_VAR_private_ssh_path}
else
  ssh-add -D
  ssh-add ${TF_VAR_private_ssh_path}
fi


# ansible_ssh_common_args="-o PubkeyAuthentication=no -o ControlMaster=auto -o ControlPersist=30m"%
# gcloud beta compute disks delete gce-test-disk --region europe-west2
# gcloud beta compute disks create \
#  gce-test-disk \
#  --region europe-west2 \
#  --replica-zones europe-west2-b,europe-west2-c