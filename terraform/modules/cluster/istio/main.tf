resource kubernetes_namespace this {
  metadata {
    name = "${var.namespace}"

    labels {
      name        = "${var.namespace}"
      description = "service-mesh"
    }
  }
}

resource kubernetes_secret kiali {
  metadata {
    name      = "kiali"
    namespace = "${var.namespace}"

    labels {
      name = "kiali"
    }
  }

  type = "Opaque"
}
