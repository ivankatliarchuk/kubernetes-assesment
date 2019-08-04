#!/bin/bash

set -euo pipefail

: $PROJECT_ID

current=$(pwd)
eval "$(ssh-agent)"
JOB_NAME=${1}
if [[ "$OSTYPE" == "darwin"* ]]; then
  # ssh-add -D
  ssh-add -K ${current}/inventory/cust_id_rsa
else
  # ssh-add -D
  ssh-add ${current}/inventory/cust_id_rsa
fi

kubespray_version=${kubespray_versionx:-v2.10.4}

git submodule update --init

run_version="temp-$$"
echo "Run Version: $run_version"

on_exit() {
  popd
  echo "on_exit: ${run_version} version"
}
trap on_exit EXIT

on_success() {
  echo -e "Success for Version: $run_version. \n Copying kube config file into 'data' folder..."
  echo "Setting up your KUBECONFIG"
  echo "export KUBECONFIG=$(pwd)/data/admin.conf"
  cp inventory/${run_version}/artifacts/admin.conf ${current}/inventory/admin.conf
}

{
  pushd kubespray
  # cleanup previous
  rm -rf inventory/temp-*
  # copy
  cp -rfp inventory/sample inventory/${run_version}
  cp ${current}/inventory/ssh-config.conf ~/.ssh/config

  cp ${current}/inventory/hosts.ini inventory/${run_version}/hosts.ini
  cp ${current}/inventory/ssh-config.conf ./ssh-config.custom.conf
  cp ${current}/templates/kubespray/ansible.cfg ./ansible.cfg

  cp ${current}/templates/kubespray/aws/all.yml inventory/${run_version}/group_vars/all/all.yml
  cp ${current}/templates/kubespray/aws/addons.yml inventory/${run_version}/group_vars/k8s-cluster/addons.yml
  cp ${current}/templates/kubespray/aws/k8s-cluster.yml inventory/${run_version}/group_vars/k8s-cluster/k8s-cluster.yml

  command="-f 20 -b --become-user=root -e cloud_provider=aws -e bootstrap_os=ubuntu -e ansible_python_interpreter=/usr/bin/python3 -e bootstrap_os=ubuntu -e ansible_python_interpreter=/usr/bin/python3 -e download_run_once=True -e kubeconfig_localhost=True -e kubectl_localhost=false"

  if [[ "$JOB_NAME" = "reset" ]]; then
    echo "reset cluster"
    ansible-playbook -i inventory/${run_version}/hosts.ini reset.yml \
    -f 20 -b --become-user=root
  elif [[ "$JOB_NAME" = "provision" ]]; then
    echo "provision cluster"
    ansible-playbook -i inventory/${run_version}/hosts.ini cluster.yml $command
  elif [[ "$JOB_NAME" = "update" ]]; then
    echo "update cluster"
    ansible-playbook -i inventory/${run_version}/hosts.ini upgrade-cluster.yml $command
    on_success
  else # PR job
    echo "job not specified. exiting"
  fi
}


