variable namespace {}

variable repository {
  type = "map"
}

variable apps {
  type = "map"
}

locals {
  namespace  = "${var.namespace}"
  istio_init = "${var.apps["istio-init"]}"
}
