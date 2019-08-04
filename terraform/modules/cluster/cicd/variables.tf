variable namespace {
  description = "Namespace to where deploy CI/CD"
}

variable apps {
  type        = "map"
  description = "Multiple applications to deploy"
}

variable repository {
  type        = "map"
  description = "Collection of Helm repositories"
}

variable bucket {
  description = "Bucket where to store backups"
}

variable region {
  description = "Region where backup is stored"
}

locals {
  namespace = "${var.namespace}"
  jenkins   = "${var.apps["jenkins"]}"
}
