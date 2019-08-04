# firewalls

# networking
resource aws_security_group kubernetes {
  name   = "kubernetes-${local.cluster_name}-securitygroup"
  vpc_id = "${module.vpc.vpc_id}"

  tags = "${merge(local.tags, map(
      "Name", "kubernetes-${local.cluster_name}-securitygroup"
    ))}"
}

resource aws_security_group_rule allow_all_ingress {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kubernetes.id}"
}

resource aws_security_group_rule allow_all_egress {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kubernetes.id}"
}

resource aws_security_group_rule allow_ssh_connections {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["${var.vpc_cidr_block}"]
  security_group_id = "${aws_security_group.kubernetes.id}"
}

# bastion
resource aws_security_group bastion {
  name   = "kubernetes-${local.cluster_name}-bastion"
  vpc_id = "${module.vpc.vpc_id}"

  tags = "${merge(local.tags, map(
      "Name", "kubernetes-${local.cluster_name}-bastion"
    ))}"
}

resource aws_security_group_rule allow_ssh_admin_connection_bastion {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["${var.admin_whitelist}"]
  security_group_id = "${aws_security_group.bastion.id}"
}

resource aws_security_group_rule allow_egress_bastion {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["${var.vpc_cidr_block}"]
  security_group_id = "${aws_security_group.bastion.id}"
}
