variable nodes {
  description = "number of nodes to connect"
}

variable ssh_user {
  description = "User that is used to connect to nodes"
}

variable hosts {
  description = "ips to connect"
  type        = "list"
}

variable inventory_template {
  description = "trigger on inventory template change"
}

variable constant {
  description = "used to manually trigger validation"
}

variable connection_type {
  description = "The connection type that should be used"
  default     = "ssh"
}

variable connection_timeout {
  description = "The timeout to wait for the connection to become available."
  default     = "10m"
}

variable private_key {
  description = "The contents of an SSH key to use for the connection."
}

variable bastion_address {
  description = "Setting this enables the bastion Host connection. This host will be connected to first, and then the host connection will be made from there"
}

variable bastion_port {
  description = "The port to use connect to the bastion host. Defaults to the value of the port field."
  default     = "22"
}
