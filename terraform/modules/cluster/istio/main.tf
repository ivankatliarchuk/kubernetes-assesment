resource kubernetes_namespace this {
  metadata {
    name = "${var.namespace}"

    labels {
      name        = "${var.namespace}"
      description = "service-mesh"
    }
  }
}

resource random_string kiali_password {
  length  = 16
  special = false
}

resource kubernetes_secret kiali {
  metadata {
    name      = "kiali"
    namespace = "${var.namespace}"

    labels {
      name = "kiali"
    }
  }

  data = {
    username   = "${var.kiali_username}"
    passphrase = "${random_string.kiali_password.result}"
  }

  type = "Opaque"
}
