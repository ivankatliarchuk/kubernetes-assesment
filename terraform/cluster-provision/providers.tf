provider kubernetes {
  version          = "1.8.1"
  load_config_file = true
  config_path      = "${var.kub_config}"
}

provider helm {
  version         = "0.10.1"
  install_tiller  = false
  namespace       = "${module.tiller.namespace}"
  service_account = "tiller"

  kubernetes {
    config_path = "${var.kub_config}"
  }
}
