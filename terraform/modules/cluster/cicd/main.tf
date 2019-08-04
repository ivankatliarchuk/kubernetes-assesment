resource helm_release jenkins {
  count         = "${local.jenkins["deploy"]}"
  namespace     = "${local.namespace}"
  repository    = "${var.repository["stable"]}"
  name          = "${local.jenkins["name"]}"
  version       = "${local.jenkins["version"]}"
  chart         = "${local.jenkins["chart"]}"
  force_update  = "${local.jenkins["force_update"]}"
  wait          = "${local.jenkins["wait"]}"
  recreate_pods = "${local.jenkins["recreate_pods"]}"

  values = [<<EOF
backup:
  enabled: true
  componentName: "jenkinsbackup"
  destination: "s3://${var.bucket}/jenkinsbackup"
  schedule: "0 2 * * *"
  env:
  - name: "AWS_REGION"
    value: "${var.region}"
EOF
  ]

  set_string {
    name  = "labels.kubernetes\\.io/name"
    value = "${local.jenkins["name"]}"
  }

  set_string {
    name  = "service.labels.kubernetes\\.io/name"
    value = "${local.jenkins["name"]}"
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
      description = "continuous-integration-and-delivery"
    }
  }
}
