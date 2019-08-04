ssh_user = "k8s"

prefix = "k8s"

region = "us-west-2"

cluster_name = "test"

# TODO: externalize, make it mandatory env variable
admin_whitelist = ["86.1.27.129/32"]

# https://www.site24x7.com/tools/ipv4-subnetcalculator.html
vpc_cidr_block = "10.250.192.0/18"

cidr_subnets_private = ["10.250.192.0/21", "10.250.200.0/21", "10.250.216.0/21"]

cidr_subnets_public = ["10.250.224.0/21", "10.250.232.0/21", "10.250.248.0/21"]

elb_api_port = 6443

k8s_secure_api_port = 6443

ssh_user = "ubuntu"

# TODO: this is just to save costs
instances = {
  bastion = {
    type  = "t2.small"
    nodes = 1
  }

  master = {
    type  = "t2.medium"
    nodes = 1
  }

  worker = {
    type  = "t2.medium"
    nodes = 3
  }

  etcd = {
    type  = "t2.small"
    nodes = 3
  }
}
