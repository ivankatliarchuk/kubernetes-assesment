terraform {
  backend "gcs" {}
}

data google_compute_zones available {
  region = "${var.region}"
}
