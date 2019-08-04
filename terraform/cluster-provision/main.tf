module tiller {
  source    = "../modules/cluster/tiller"
  namespace = "helm"
}

module cicd {
  source     = "../modules/cluster/cicd"
  namespace  = "cicd"
  apps       = "${var.apps}"
  repository = "${local.repository}"
  bucket     = "${var.bucket}"
  region     = "${var.region}"
}

module apps_monitoring {
  source     = "../modules/cluster/monitoring"
  repository = "${local.repository}"
  namespace  = "monitoring"
  apps       = "${var.apps}"
}

module vulnerability_scanning {
  source     = "../modules/cluster/scanners"
  repository = "${local.repository}"
  namespace  = "scanners"
  project    = "${var.project}"
  prefix     = "${var.prefix}"
  apps       = "${var.apps}"
}
