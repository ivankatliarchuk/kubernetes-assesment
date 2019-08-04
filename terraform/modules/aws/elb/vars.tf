variable cluster_name {
  description = "Name of Cluster"
}

variable vpc_id {
  description = "AWS VPC ID"
}

variable elb_api_port {
  description = "Port for AWS ELB"
}

variable k8s_secure_api_port {
  description = "Secure Port of K8S API Server"
}

variable avail_zones {
  description = "Availability Zones Used"
  type        = "list"
}

variable public_subnets {
  description = "IDs of Public Subnets"
  type        = "list"
}

variable tags {
  description = "Tags for all resources"
  type        = "map"
}
