resource helm_release kubernetes_dashboard {
  count         = "${local.k8s_dashboard["deploy"]}"
  namespace     = "${local.namespace}"
  repository    = "${var.repository["stable"]}"
  name          = "${local.k8s_dashboard["name"]}"
  version       = "${local.k8s_dashboard["version"]}"
  chart         = "${local.k8s_dashboard["chart"]}"
  force_update  = "${local.k8s_dashboard["force_update"]}"
  wait          = "${local.k8s_dashboard["wait"]}"
  recreate_pods = "${local.k8s_dashboard["recreate_pods"]}"

  values = [<<EOF
replicaCount: ${local.k8s_dashboard["val.replicaCount"]}
enableSkipLogin: false
enableInsecureLogin: false
tolerations: []
affinity: {}
extraArgs:
  - --authentication-mode=token
rbac:
  create: true
serviceAccount:
  create: true
livenessProbe:
  initialDelaySeconds: 30
  timeoutSeconds: 30
resources:
  limits:
    cpu: ${local.k8s_dashboard["val.resources.limits.cpu"]}
    memory: ${local.k8s_dashboard["val.resources.limits.memory"]}
  requests:
    cpu: ${local.k8s_dashboard["val.resources.requests.cpu"]}
    memory: ${local.k8s_dashboard["val.resources.requests.memory"]}
EOF
  ]

  set_string {
    name  = "labels.kubernetes\\.io/name"
    value = "${local.k8s_dashboard["name"]}"
  }

  set_string {
    name  = "service.labels.kubernetes\\.io/name"
    value = "${local.k8s_dashboard["name"]}"
  }

  set_string {
    name  = "labels.kubernetes\\.io/cluster-service"
    value = "true"
  }
}

resource kubernetes_cluster_role_binding kubernetes_dashboard {
  metadata {
    name = "kubernetes-dashboard"

    labels {
      k8s-app = "kubernetes-dashboard"
    }
  }

  subject {
    kind      = "ServiceAccount"
    name      = "kubernetes-dashboard"
    namespace = "${local.namespace}"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource kubernetes_cluster_role view_only {
  metadata {
    name = "dashboard-viewonly"
  }

  rule {
    api_groups = [""]

    resources = [
      "configmaps",
      "persistentvolumeclaims",
      "pods",
      "replicationcontrollers",
      "replicationcontrollers/scale",
      "serviceaccounts",
      "services",
      "nodes",
      "persistentvolumeclaims",
      "persistentvolumes",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]

    resources = [
      "bindings",
      "events",
      "limitranges",
      "namespaces/status",
      "pods/log",
      "pods/status",
      "replicationcontrollers/status",
      "resourcequotas",
      "resourcequotas/status",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]

    resources = [
      "namespaces",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps"]

    resources = [
      "daemonsets",
      "deployments",
      "deployments/scale",
      "replicasets",
      "replicasets/scale",
      "statefulsets",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps"]

    resources = [
      "daemonsets",
      "deployments",
      "deployments/scale",
      "replicasets",
      "replicasets/scale",
      "statefulsets",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch"]

    resources = [
      "cronjobs",
      "jobs",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions"]

    resources = [
      "daemonsets",
      "deployments",
      "deployments/scale",
      "ingresses",
      "networkpolicies",
      "replicasets",
      "replicasets/scale",
      "eplicationcontrollers/scale",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["storage.k8s.io"]

    resources = [
      "storageclasses",
      "volumeattachments",
      "deployments/scale",
    ]

    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]

    resources = [
      "clusterrolebindings",
      "clusterroles",
      "roles",
      "rolebindings",
    ]

    verbs = ["get", "list", "watch"]
  }
}

# TODO: create token out of it
resource kubernetes_cluster_role_binding view_only {
  metadata {
    name = "kubernetes-dashboard-view-only"

    labels {
      k8s-app = "kubernetes-dashboard"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "dashboard-viewonly"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "kubernetes-dashboard"
    namespace = "${local.namespace}"
  }

  depends_on = [
    "kubernetes_namespace.this",
    "kubernetes_cluster_role_binding.kubernetes_dashboard",
  ]
}

resource kubernetes_service_account view_only {
  metadata {
    name      = "dashboard-view-only"
    namespace = "monitoring"
  }

  # secret {
  #   name = "${kubernetes_secret.view_only.metadata.0.name}"
  # }

  automount_service_account_token = true
}

resource kubernetes_secret view_only {
  metadata {
    name      = "dashboard-view-only"
    namespace = "monitoring"

    annotations = {
      "kubernetes.io/service-account.name" = "dashboard-view-only"
    }
  }

  type = "kubernetes.io/service-account-token"
}
