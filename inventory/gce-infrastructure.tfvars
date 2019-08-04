environment = "dev"

ssh_user = "k8s"

prefix = "k8s"

master_size = 1

worker_size = 1

etcd_size = 0

jumpbox_create = true

jumpbox_type = "g1-small"

master_type = "n1-standard-2"

worker_type = "n1-standard-2"

etcd_type = "g1-small"

admin_whitelist = ["86.1.27.129"]

master_service_port = 6443

etcd_service_port = 2379

# https://www.site24x7.com/tools/ipv4-subnetcalculator.html
cidr_block = "10.240.0.0/16"

public_cidr_block = "10.240.0.0/20"

private_cidr_block = "10.240.16.0/20"
