resource aws_instance this {
  count                       = "${var.number}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.associate_pulic_ip}"
  availability_zone           = "${element(var.zones, count.index)}"
  subnet_id                   = "${element(var.subnets,count.index)}"
  vpc_security_group_ids      = ["${var.security_group}"]
  iam_instance_profile        = "${var.iam_profile}"
  key_name                    = "${var.key_name}"
  user_data_base64            = "${base64encode(var.user_data)}"

  tags = "${merge(var.tags, map(
      "Name", "${format("kubernets-%s-%s-%d", var.cluster_name, var.role, count.index)}",
      "failure-domain.beta.kubernetes.io/zone", "${element(var.zones,count.index)}",
      "Member", "${var.role}-${count.index}",
    ))}"
}
