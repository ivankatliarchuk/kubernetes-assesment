# SSH KEYS
module ssh_key {
  source           = "../../modules/ssh-key"
  private_ssh_path = "${var.private_ssh_path}"
}

resource aws_key_pair key {
  key_name   = "${var.prefix}-key"
  public_key = "${local.ssh_key}"
}

module master_ready {
  source = "../../modules/ssh-connection"

  nodes              = "${local.master["nodes"]}"
  hosts              = "${local.master_ips}"
  inventory_template = "${data.template_file.inventory.rendered}"
  constant           = "3"
  private_key        = "${module.ssh_key.private}"
  bastion_address    = "${local.bastion_address}"
  ssh_user           = "${var.ssh_user}"
}

module etcd_ready {
  source = "../../modules/ssh-connection"

  nodes              = "${local.etcd["nodes"]}"
  hosts              = "${local.etcd_ips}"
  inventory_template = "${data.template_file.inventory.rendered}"
  constant           = "3"
  private_key        = "${module.ssh_key.private}"
  bastion_address    = "${local.bastion_address}"
  ssh_user           = "${var.ssh_user}"
}

module worker_ready {
  source = "../../modules/ssh-connection"

  nodes              = "${local.worker["nodes"]}"
  hosts              = "${local.worker_ips}"
  inventory_template = "${data.template_file.inventory.rendered}"
  constant           = "3"
  private_key        = "${module.ssh_key.private}"
  bastion_address    = "${local.bastion_address}"
  ssh_user           = "${var.ssh_user}"
}
