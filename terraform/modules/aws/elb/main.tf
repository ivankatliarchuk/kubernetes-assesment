resource aws_security_group elb {
  name   = "kubernetes-${var.cluster_name}-securitygroup-elb"
  vpc_id = "${var.vpc_id}"

  tags = "${merge(var.tags, map(
      "Name", "kubernetes-${var.cluster_name}-securitygroup-elb"
    ))}"
}

resource aws_security_group_rule allow_api_access {
  type              = "ingress"
  from_port         = "${var.elb_api_port}"
  to_port           = "${var.k8s_secure_api_port}"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource aws_security_group_rule allow_api_egress {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

# Create a new AWS ELB for K8S API
resource aws_elb elb_api {
  name            = "kubernetes-elb-${var.cluster_name}"
  subnets         = ["${var.public_subnets}"]
  security_groups = ["${aws_security_group.elb.id}"]

  listener {
    instance_port     = "${var.k8s_secure_api_port}"
    instance_protocol = "tcp"
    lb_port           = "${var.elb_api_port}"
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:${var.k8s_secure_api_port}"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = "${merge(var.tags, map(
    "Name", "kubernetes-${var.cluster_name}-elb-api",
    "kubernetes.io/role/elb", "true"
  ))}"
}
