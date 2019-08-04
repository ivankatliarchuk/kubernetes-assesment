resource null_resource ready {
  count = "${length(var.nodes)}"

  # A mapping of values which should trigger a rerun of this set of provisioners
  triggers = {
    instances_names   = "${element(var.hosts, count.index)}"
    inventory_changes = "${sha1(var.inventory_template)}"
    changes           = "${sha1(var.constant)}"
  }

  connection {
    host        = "${element(var.hosts, count.index)}"
    type        = "${var.connection_type}"
    user        = "${var.ssh_user}"
    private_key = "${var.private_key}"
    agent       = false
    timeout     = "${var.connection_timeout}"

    bastion_host        = "${var.bastion_address}"
    bastion_private_key = "${var.private_key}"
    bastion_user        = "${var.ssh_user}"
    bastion_port        = "${var.bastion_port}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'CONNECTED to ${element(var.hosts, count.index)}'",
    ]
  }
}
