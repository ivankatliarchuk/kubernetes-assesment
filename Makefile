.EXPORT_ALL_VARIABLES:

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

devsetup: ## DEV machine setup
	@vagrant plugin install vagrant-cachier
	@vagrant plugin install vagrant-hostmanager
	@vagrant plugin install vagrant-address

ssh-tunnel: ## create ssh tunnel
	@bin/sshtunnel.sh

list-gce: ## list GCE resoruces
	@gcloud compute instances list

infra-create-gce: ## Task '2.1' > Setup GCE infrastructure for K8s cluster
	@bin/terraform-infra.sh apply

infra-create-aws: ## Task '2.1' > Setup AWS infrastructure for K8s cluster
	@bin/terraform-infra.aws.sh apply

ssh-test: ## Test ssh connection
	@bin/cluster-connect.sh

aws: ## Task '2.1' > Setup AWS infrastructure for K8s cluster
	@bin/terraform-infra.aws.sh apply

aws-cluster: ## Task '2.1' > Setup cluster on aws
	@bin/cluster-deploy.aws.sh update

cluster-gce: ## Task '2.2' Provision kubernetes cluster for GCE with 'kubespray'
	@bin/cluster-deploy-cfg.sh gce

cluster-provision: ## Task '3.1' Provision Jenkins on kubernetes
	@bin/terraform-k8s.provision.sh apply

cluster-dashboard: ## Task
	@bin/show-dashboard.sh

infra-teardown-gce: ## Task '13' > Tear down cluster with GCE infrastructure
	@bin/terraform-infra.sh destroy

ssh-jump: ## Jump to any instance in network
	@ssh-add -D ./data/cust_id_rsa
	@bin/ssh-jump.sh

up: ## Create local development Vagrant box
	@vagrant up

stop: ## Stoplocal development Vagrant box
	@vagrant halt

destroy: ## Destroy local development Vagrant box
	@vagrant destroy --force

hooks:
	@pre-commit install
	@pre-commit gc
	@pre-commit autoupdate

validate: ## Validate pre commit
	@pre-commit run --all-files