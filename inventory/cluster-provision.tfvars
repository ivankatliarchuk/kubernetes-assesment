apps = {
  jenkins = {
    "name"             = "jenkins"
    "version"          = "1.5.0"
    "chart"            = "stable/jenkins"
    "force_update"     = "true"
    "wait"             = "false"
    "recreate_pods"    = "true"
    "deploy"           = 1
    "val.replicaCount" = 2
  }

  k8s_dashboard = {
    "name"                          = "kubernetes-dashboard"
    "version"                       = "1.8.0"
    "chart"                         = "stable/kubernetes-dashboard"
    "force_update"                  = "true"
    "wait"                          = "false"
    "recreate_pods"                 = "true"
    "deploy"                        = 1
    "val.replicaCount"              = 2
    "val.resources.requests.cpu"    = "30m"
    "val.resources.requests.memory" = "60Mi"
    "val.resources.limits.cpu"      = "100m"
    "val.resources.limits.memory"   = "100Mi"
  }

  anchore = {
    "name"             = "acnhore"
    "version"          = "1.2.0"
    "chart"            = "stable/anchore-engine"
    "force_update"     = "true"
    "wait"             = "false"
    "recreate_pods"    = "true"
    "deploy"           = 1
    "val.replicaCount" = 1
  }

  istio-init = {
    "name"             = "istio-init"
    "version"          = "1.2.2"
    "chart"            = "istio.io/istio-init"
    "force_update"     = "true"
    "wait"             = "true"
    "recreate_pods"    = "true"
    "deploy"           = 1
    "val.replicaCount" = 1
  }

  istio = {
    "name"             = "istio"
    "version"          = "1.2.2"
    "chart"            = "istio.io/istio"
    "force_update"     = "true"
    "wait"             = "false"
    "recreate_pods"    = "true"
    "deploy"           = 1
    "val.replicaCount" = 1
  }

  docker-registry = {
    "name"             = "docker-registry"
    "version"          = "1.2.2"
    "chart"            = "stable/docker-registry"
    "force_update"     = "true"
    "wait"             = "false"
    "recreate_pods"    = "true"
    "deploy"           = 1
    "val.replicaCount" = 1
  }
}
