variable repository {
  type = "map"
}

variable apps {
  type = "map"
}

variable namespace {}

locals {
  namespace = "${var.namespace}"
  registry  = "${var.apps["docker-registry"]}"
}
