apps = {
  k8s_dashboard = {
    "name"                          = "kubernetes-dashboard"
    "version"                       = "1.8.0"
    "chart"                         = "stable/kubernetes-dashboard"
    "force_update"                  = "true"
    "wait"                          = "true"
    "recreate_pods"                 = "true"
    "deploy"                        = 1
    "val.replicaCount"              = 1
    "val.resources.requests.cpu"    = "30m"
    "val.resources.requests.memory" = "60Mi"
    "val.resources.limits.cpu"      = "100m"
    "val.resources.limits.memory"   = "100Mi"
  }

  heapster = {
    "name"                          = "heapster"
    "version"                       = "0.3.2"
    "chart"                         = "stable/heapster"
    "force_update"                  = "true"
    "wait"                          = "true"
    "recreate_pods"                 = "true"
    "deploy"                        = 1
    "val.replicaCount"              = 1
    "val.resources.requests.cpu"    = "210m"
    "val.resources.requests.memory" = "236Mi"
    "val.resources.limits.cpu"      = "210m"
    "val.resources.limits.memory"   = "236Mi"
  }

  metrics_server = {
    "name"                          = "metrics-server"
    "version"                       = "2.8.2"
    "chart"                         = "stable/metrics-server"
    "force_update"                  = "true"
    "wait"                          = "false"
    "recreate_pods"                 = "true"
    "deploy"                        = 0
    "val.replicaCount"              = 1
    "val.resources.requests.cpu"    = "10m"
    "val.resources.requests.memory" = "30Mi"
    "val.resources.limits.cpu"      = "25m"
    "val.resources.limits.memory"   = "60Mi"
  }

  kube_hunter = {
    "name"                          = "kube-hunter"
    "version"                       = "1.0.2"
    "chart"                         = "stable/kube-hunter"
    "force_update"                  = "true"
    "wait"                          = "true"
    "recreate_pods"                 = "true"
    "deploy"                        = 1
    "val.replicaCount"              = 1
    "val.resources.requests.cpu"    = "100m"
    "val.resources.requests.memory" = "128Mi"
    "val.resources.limits.cpu"      = "100m"
    "val.resources.limits.memory"   = "128Mi"
  }

  kube_ops_view = {
    "name"                          = "kube-ops-view"
    "version"                       = "0.7.0"
    "chart"                         = "stable/kube-ops-view"
    "force_update"                  = "true"
    "wait"                          = "true"
    "recreate_pods"                 = "true"
    "deploy"                        = 1
    "val.replicaCount"              = 1
    "val.resources.requests.cpu"    = "20m"
    "val.resources.requests.memory" = "70Mi"
    "val.resources.limits.cpu"      = "60m"
    "val.resources.limits.memory"   = "150Mi"
  }

  istio = {
    "name"          = "kube-ops-view"
    "version"       = "0.7.0"
    "chart"         = "stable/kube-ops-view"
    "force_update"  = "true"
    "wait"          = "true"
    "recreate_pods" = "true"
    "deploy"        = 1
  }
}
