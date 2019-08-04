variable ami {}
variable instance_type {}
variable security_group {}
variable cluster_name {}
variable role {}

variable associate_pulic_ip {
  default = false
}

variable zones {
  type = "list"
}

variable number {
  default = 0
}

variable subnets {
  type = "list"
}

variable iam_profile {}
variable key_name {}
variable user_data {}

variable tags {
  type    = "map"
  default = {}
}
