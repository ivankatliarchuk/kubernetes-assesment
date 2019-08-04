locals {
  cluster_name = "${var.cluster_name}"

  ssh_pub_key_without_new_line = "${replace(module.ssh_key.public, "\n", "")}"
  ssh_key                      = "${local.ssh_pub_key_without_new_line} ${var.ssh_user}"
  bastion_cloud_init           = "${data.template_cloudinit_config.bastion_cloud_init.rendered}"
  cloud_init                   = "${data.template_cloudinit_config.cloud_init.rendered}"
  bastion_address              = "${aws_instance.bastion.public_ip}"
  master_ips                   = "${module.master.ips}"
  master_names                 = "${module.master.private_dns}"
  worker_ips                   = "${module.worker.ips}"
  worker_names                 = "${module.worker.private_dns}"
  etcd_ips                     = "${module.etcd.ips}"
  etcd_names                   = "${module.etcd.private_dns}"
  etcd_members                 = "${module.etcd.members}"
  azs                          = "${slice(data.aws_availability_zones.azs.names,0,3)}"

  tags = {
    Project                                       = "${var.project}"
    Cluster                                       = "${local.cluster_name}"
    "kubernetes.io/cluster/${local.cluster_name}" = "member"
    "kubernetes.io/region"                        = "${var.region}"
    "failure-domain.beta.kubernetes.io/region"    = "${var.region}"
  }
}
