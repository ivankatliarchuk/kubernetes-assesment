.EXPORT_ALL_VARIABLES:

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

ssh-tunnel:
	@bin/sshtunnel.sh

ssh-test:
	@bin/cluster-connect.sh

aws: ## -\/--\/- AWS setup -\/--\/-
	@echo ""
aws-infrastructure-create: ## Task '2.1' > Setup AWS infrastructure for K8s cluster
	@bin/aws.terraform-infra.sh apply

aws-cluster: ## Task '2.2' > provision cluster on AWS
	@bin/aws.cluster-deploy.sh provision

aws-cluster-provision: ## Task 3.1, 4.2,5.1,6.1,8.1,10.1,11: Provision cluster resources
	@bin/aws.cluster.provision.sh apply

aws-destroy: ## Task '13' > reset current cluster and destroy infrastructure
	# @bin/aws.cluster-deploy.sh reset
	@bin/aws.terraform-infra.sh destroy

gce: ## -\/--\/- GCE expertimental setup -\/--\/-
	@echo

gce-cluster:
	@bin/cluster-deploy-cfg.sh gce

list-gce: ## list GCE resoruces
	@gcloud compute instances list

infra-create-gce: ## Task '2.1' > Setup GCE infrastructure for K8s cluster
	@bin/terraform-infra.sh apply

infra-teardown-gce: ## Task '13' > Tear down cluster with GCE infrastructure
	@bin/terraform-infra.sh destroy

dashboards: ## -\/--\/- Kubernetes proxies and Dashboards -\/--\/-
	@echo

dashboard-show: ## Task '10' > Show dashboard with Access Token
	@bin/show.dashboard.sh

cicd-show: ## Task '3' > Show CI/CD dashboard
	@bin/show.ci.sh

istio-show: ## Task '8' > Show CI/CD dashboard
	@bin/show.istio.sh

ssh-jump: ## Jump to any instance in network
	@ssh-add -D ./data/cust_id_rsa
	@bin/ssh-jump.sh

dashboards: ## -\/--\/- Devevelopment Workspace hooks -\/--\/-
	@echo

devsetup: ## DEV machine setup
	@vagrant plugin install vagrant-cachier
	@vagrant plugin install vagrant-hostmanager
	@vagrant plugin install vagrant-address

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