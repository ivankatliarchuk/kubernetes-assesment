variable namespace {}

variable repository {
  type = "map"
}

variable apps {
  type = "map"
}

resource kubernetes_namespace this {
  metadata {
    name = "${var.namespace}"

    labels {
      name        = "${var.namespace}"
      description = "monitoring-alerting"
    }
  }
}
