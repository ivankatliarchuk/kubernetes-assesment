variable region {
  description = "Region where to deploy infrastructure"
}

variable prefix {}

variable project {
  description = "the project to deploy to, if not set the default provider project is used"
}

# cluster settings
variable cluster_name {
  description = "Name of AWS Cluster"
}

variable admin_whitelist {
  type = "list"
}

# ------------------------------------------------------------
# REQUIRED PARAMETERS
# VPC configuration
# ------------------------------------------------------------

variable vpc_cidr_block {
  description = "CIDR Block for VPC"
}

variable cidr_subnets_private {
  description = "CIDR Blocks for private subnets in Availability Zones"
  type        = "list"
}

variable cidr_subnets_public {
  description = "CIDR Blocks for public subnets in Availability Zones"
  type        = "list"
}

variable private_ssh_path {}
variable inventory_path {}

variable ssh_user {
  description = "The name of the default ssh user"
}

# ------------------------------------------------------------
# REQUIRED PARAMETERS
# ELB configuration
# ------------------------------------------------------------

variable elb_api_port {
  description = "Port for AWS ELB"
}

variable k8s_secure_api_port {
  description = "Secure Port of K8S API Server"
}

# ------------------------------------------------------------
# REQUIRED PARAMETERS
# Bastion configuration
# ------------------------------------------------------------

# variable bastion_type {
#   description = "EC2 Instance Size of Bastion Host"
# }

# ------------------------------------------------------------
# REQUIRED PARAMETERS
# Cluster configuration
# ------------------------------------------------------------

# variable master_type {
#   description = "The machine type to create for controll plane"
# }

# variable master_num {}

# variable master_type {
#   description = "The machine type to create for controll plane"
# }

# variable etcd_num {}

# variable etcd_type {
#   description = "The machine type to create for controll plane"
# }

# variable worker_num {}

# variable worker_type {
#   description = "The machine type to create for controll plane"
# }

variable instances {
  type        = "map"
  description = "Cluster instance types in single container"
}

variable ubuntu_account_number {
  default = "099720109477"
}

variable coreos_account_number {
  default = "595879546273"
}
