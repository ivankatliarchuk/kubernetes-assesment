# ------------------------------------------------------------
# General Infor
# ------------------------------------------------------------

output zones {
  value = "${data.aws_availability_zones.azs.names}"
}

output supported_zones {
  value = "${local.azs}"
}

# ------------------------------------------------------------
# ACCESS keys
# ------------------------------------------------------------

output private_ssh_key {
  value     = "${module.ssh_key.private}"
  sensitive = true
}

output public_ssh_key {
  value     = "${module.ssh_key.public}"
  sensitive = true
}

output private_ssh_path {
  value = "${var.private_ssh_path}"
}

# ------------------------------------------------------------
# Instances Information
# ------------------------------------------------------------

output bastion_external_ip {
  value = "${local.bastion_address}"
}

output master_private_ips {
  value = "${local.master_ips}"
}

output worker_private_ips {
  value = "${local.worker_ips}"
}

output etcd_private_ips {
  value = "${local.etcd_ips}"
}

# ------------------------------------------------------------
# VPC Information
# ------------------------------------------------------------
output public_subnets {
  value = "${module.vpc.public_subnets}"
}

output private_subnets {
  value = "${module.vpc.private_subnets}"
}

# ------------------------------------------------------------
# Available commands
# ------------------------------------------------------------

output commands {
  value = {
    "ssh-bastion" = "'ssh -F ${local_file.ssh_config.filename} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ssh_user}@bastion'"
  }
}

output ubuntu_version {
  value = "${data.aws_ami.ubuntu.id}"
}
