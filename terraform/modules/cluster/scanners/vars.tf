variable prefix {}
variable project {}

variable repository {
  type = "map"
}

variable apps {
  type = "map"
}

variable namespace {}

locals {
  namespace = "${var.namespace}"
  anchore   = "${var.apps["anchore"]}"
}
