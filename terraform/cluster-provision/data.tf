# ==== #
# HELM #
# ==== #

data helm_repository stable {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

data helm_repository incubator {
  name = "incubator"
  url  = "https://kubernetes-charts-incubator.storage.googleapis.com/"
}

data helm_repository istio {
  name = "istio.io"
  url  = "https://storage.googleapis.com/istio-release/releases/1.2.2/charts/"
}
