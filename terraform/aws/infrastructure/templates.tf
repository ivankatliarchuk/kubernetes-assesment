data template_file ssh_config {
  template = "${file("${path.module}/templates/ssh-config.conf")}"

  vars {
    bastion_ip       = "${aws_instance.bastion.public_ip}"
    master_ips       = "${join(" ", local.master_ips)}"
    etcd_ips         = "${join(" ", local.etcd_ips)}"
    worker_ips       = "${join(" ", local.worker_ips)}"
    user             = "${var.ssh_user}"
    private_key_path = "${var.private_ssh_path}"
  }
}

#  bastion init
data template_file bastion_cloud_init {
  template = "${file("${path.module}/templates/bastion-cloud-init.yaml")}"
}

data template_cloudinit_config bastion_cloud_init {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.bastion_cloud_init.rendered}"
  }
}

#
data template_file cloud_init {
  template = "${file("${path.module}/templates/cloud-init.yaml")}"

  vars {
    user = "${var.ssh_user}"
  }
}

data template_cloudinit_config cloud_init {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.cloud_init.rendered}"
  }
}

# TEMP: here
resource local_file ssh_config {
  sensitive_content = "${data.template_file.ssh_config.rendered}"
  filename          = "${var.inventory_path}/ssh-config.conf"
}

data template_file inventory {
  template = "${file("${path.module}/templates/hosts.ini")}"

  vars {
    address_bastion           = "${format("bastion-0 ansible_host=%s ansible_user=%s", local.bastion_address, var.ssh_user)}"
    connection_strings_master = "${join("\n",formatlist("%s ansible_ssh_host=%s ip=%s",local.master_names, local.master_ips, local.master_ips))}"
    connection_strings_node   = "${join("\n",formatlist("%s ansible_ssh_host=%s ip=%s",local.worker_names, local.worker_ips, local.worker_ips))}"
    connection_strings_etcd   = "${join("\n",formatlist("%s ansible_ssh_host=%s ip=%s etcd_member_name=%s",local.etcd_names, local.etcd_ips, local.etcd_ips, local.etcd_members))}"
    list_bastion              = "bastion-0"
    list_master               = "${join("\n",local.master_names)}"
    list_node                 = "${join("\n",local.worker_names)}"
    list_etcd                 = "${join("\n",local.etcd_names)}"
    elb_api_fqdn              = "${module.elb.elb_api_fqdn}"
    ssh_user                  = "${var.ssh_user}"
  }
}

resource local_file hosts {
  sensitive_content = "${data.template_file.inventory.rendered}"
  filename          = "${var.inventory_path}/hosts.ini"
}

data template_file resources {
  template = "${file("${path.module}/templates/resources")}"

  vars {
    elb_api_fqdn = "${module.elb.elb_api_fqdn}"
  }
}

resource local_file resources {
  sensitive_content = "${data.template_file.resources.rendered}"
  filename          = "${var.inventory_path}/resources"
}
