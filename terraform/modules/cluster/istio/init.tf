resource helm_release istio_init {
  count         = "${local.istio_init["deploy"]}"
  namespace     = "${local.namespace}"
  repository    = "${var.repository["istio.io"]}"
  name          = "${local.istio_init["name"]}"
  version       = "${local.istio_init["version"]}"
  chart         = "${local.istio_init["chart"]}"
  force_update  = "${local.istio_init["force_update"]}"
  wait          = "${local.istio_init["wait"]}"
  recreate_pods = "${local.istio_init["recreate_pods"]}"

  depends_on = [
    "kubernetes_namespace.this",
    "kubernetes_secret.kiali",
  ]
}
