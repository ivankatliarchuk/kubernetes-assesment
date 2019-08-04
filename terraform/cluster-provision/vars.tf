variable region {
  description = "Cluser region, required for some apps"
}

variable prefix {}
variable project {}

variable apps {
  type        = "map"
  description = "Multiple Applications to deploy with HELM"
}

variable kub_config {
  description = "Kube config path"
}

variable tiller_image {
  default     = "gcr.io/kubernetes-helm/tiller:v2.14.2"
  description = "Tiller image for custom installation"
}
