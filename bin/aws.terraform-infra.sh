#!/bin/bash

set -euo pipefail

: $AWS_STATE_BUCKET
: $PROJECT_ID
: $AWS_ACCESS_KEY_ID
: $AWS_SECRET_ACCESS_KEY

COMMAND=${1:-plan}

# TODO:create bucket manually
STATE="infrastructure.tfstate"
MODULE="${PWD}/terraform/aws/infrastructure"
TF_VARS="inventory/aws-infrastructure.tfvars"

export TF_VAR_project=${PROJECT_ID}
export TF_VAR_private_ssh_path="${PWD}/inventory/cust_id_rsa"
export TF_VAR_inventory_path="${PWD}/inventory"

terraform init \
-backend-config="bucket=${AWS_STATE_BUCKET}" \
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
