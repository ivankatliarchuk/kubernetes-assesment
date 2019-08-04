provider aws {
  region  = "${var.region}"
  version = "2.22.0"

  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
}

terraform {
  backend "s3" {}
}

provider template {
  version = "2.1"
}

provider tls {
  version = "2.0.1"
}

provider local {
  version = "1.3"
}

provider null {
  version = "2.1"
}
