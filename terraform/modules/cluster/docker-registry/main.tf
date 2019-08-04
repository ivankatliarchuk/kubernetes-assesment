resource helm_release registry {
  count         = "${local.registry["deploy"]}"
  namespace     = "${local.namespace}"
  repository    = "${var.repository["stable"]}"
  name          = "${local.registry["name"]}"
  version       = "${local.registry["version"]}"
  chart         = "${local.registry["chart"]}"
  force_update  = "${local.registry["force_update"]}"
  wait          = "${local.registry["wait"]}"
  recreate_pods = "${local.registry["recreate_pods"]}"

  values = [<<EOF
replicaCount: "${local.registry["val.replicaCount"]}"
persistence:
  enabled: false
  size: 3Gi
EOF
  ]

  set_string {
    name  = "labels.kubernetes\\.io/name"
    value = "${local.registry["name"]}"
  }

  set_string {
    name  = "service.labels.kubernetes\\.io/name"
    value = "${local.registry["name"]}"
  }

  set_string {
    name  = "labels.kubernetes\\.io/cluster-service"
    value = "true"
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
      description = "docker-registry"
    }
  }
}
