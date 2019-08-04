resource helm_release anchore {
  count         = "${local.anchore["deploy"]}"
  namespace     = "${local.namespace}"
  repository    = "${var.repository["stable"]}"
  name          = "${local.anchore["name"]}"
  version       = "${local.anchore["version"]}"
  chart         = "${local.anchore["chart"]}"
  force_update  = "${local.anchore["force_update"]}"
  wait          = "${local.anchore["wait"]}"
  recreate_pods = "${local.anchore["recreate_pods"]}"

  values = [<<EOF
postgresql:
  persistence:
    size: 1Gi
    volumeName: ${var.prefix}-anchore-postgress
EOF
  ]

  set_string {
    name  = "labels.kubernetes\\.io/name"
    value = "${local.anchore["name"]}"
  }

  set_string {
    name  = "service.labels.kubernetes\\.io/name"
    value = "${local.anchore["name"]}"
  }

  set_string {
    name  = "labels.kubernetes\\.io/cluster-service"
    value = "false"
  }

  depends_on = [
    "kubernetes_namespace.this",
  ]
}

resource kubernetes_namespace this {
  metadata {
    name = "${var.namespace}"

    labels {
      name        = "${var.namespace}"
      description = "security-vulnerability-scanners"
    }
  }
}
