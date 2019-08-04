variable namespace {}

variable repository {
  type = "map"
}

variable apps {
  type = "map"
}

variable kiali_username {
  default     = "admin"
  description = "kiali username"
}

locals {
  namespace  = "${var.namespace}"
  istio_init = "${var.apps["istio-init"]}"
  istio      = "${var.apps["istio"]}"
}
