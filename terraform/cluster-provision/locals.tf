locals {
  repository = {
    stable     = "${data.helm_repository.stable.metadata.0.name}"
    incubator  = "${data.helm_repository.incubator.metadata.0.name}"
    "istio.io" = "${data.helm_repository.istio.metadata.0.name}"
  }
}
