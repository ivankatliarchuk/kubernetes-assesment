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
	@bin/aws.terraform-infra.sh apply

aws-cluster: ## Task '2.2' > provision cluster on AWS
	@bin/aws.cluster-deploy.sh provision

aws-cluster-provision: ## Task 3.1, 4.2,5.1,6.1,8.1,10.1,11: Provision cluster resources
	@bin/aws.cluster.provision.sh apply

aws-destroy: ## Task '13' > reset current cluster and destroy infrastructure
	@bin/aws.cluster-deploy.sh provision
	@bin/aws.erraform-infra.sh destroy

gce-cluster:
	@bin/cluster-deploy-cfg.sh gce

dashboard-show: ## Task '10' > Show dashboard with Access Token
	@bin/show.dashboard.sh

cicd-show: ## Task '3' > Show CI/CD dashboard
	@bin/show.ci.sh

istio-show: ## Task '8' > Show CI/CD dashboard
	@bin/show.istio.sh

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