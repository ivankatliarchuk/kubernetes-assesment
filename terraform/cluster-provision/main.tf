module tiller {
  source    = "../modules/cluster/tiller"
  namespace = "helm"
}

module cicd {
  source     = "../modules/cluster/cicd"
  namespace  = "cicd"
  apps       = "${var.apps}"
  repository = "${local.repository}"
}
