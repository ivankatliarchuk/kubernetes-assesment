#!/bin/bash

set -euo pipefail

: $PROJECT_ID

current=$(pwd)
eval "$(ssh-agent)"

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
  # tree inventory/${run_version}
  popd
  echo "on_exit: ${run_version} version"
}
trap on_exit EXIT

{
  pushd kubespray
  # cleanup previous
  rm -rf inventory/temp-*
  # copy
  cp -rfp inventory/sample inventory/${run_version}
  cp ${current}/inventory/ssh-config.conf ~/.ssh/config

  cp ${current}/inventory/hosts.ini inventory/${run_version}/hosts.ini
  cp ${current}/inventory/ssh-config.conf ./ssh-config.custom.conf
  cp ${current}/inventory/ansible.cfg ./ansible.cfg

  cp ${current}/templates/kubespray/aws/all.yml inventory/${run_version}/group_vars/all/all.yml
  cp ${current}/templates/kubespray/aws/addons.yml inventory/${run_version}/group_vars/k8s-cluster/addons.yml
  cp ${current}/templates/kubespray/aws/k8s-cluster.yml inventory/${run_version}/group_vars/k8s-cluster/k8s-cluster.yml

  # ansible-playbook -i inventory/${run_version}/hosts.ini reset.yml \
  # -f 20 -b --become-user=root

  ansible-playbook -i inventory/${run_version}/hosts.ini cluster.yml \
  -f 20 -b --become-user=root -e cloud_provider=aws  \
  -e bootstrap_os=ubuntu -e ansible_python_interpreter=/usr/bin/python3

  # ansible-playbook -i inventory/${run_version}/hosts.ini upgrade-cluster.yml \
  #   -f 20 -b --become-user=root -e cloud_provider=aws \
  #   -e bootstrap_os=ubuntu -e ansible_python_interpreter=/usr/bin/python3

  echo -e "Success for Version: $run_version. \n Copying kube config file into 'data' folder..."
  echo "Setting up your KUBECONFIG"
  echo "export KUBECONFIG=$(pwd)/data/admin.conf"
  cp inventory/${run_version}/artifacts/admin.conf ${current}/inventory/admin.conf
}


