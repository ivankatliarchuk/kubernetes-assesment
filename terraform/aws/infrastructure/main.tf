module vpc {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v1.67.0"

  name                    = "${local.cluster_name}"
  cidr                    = "${var.vpc_cidr_block}"
  azs                     = "${local.azs}"
  public_subnets          = "${var.cidr_subnets_public}"
  private_subnets         = "${var.cidr_subnets_private}"
  enable_nat_gateway      = true
  single_nat_gateway      = false
  one_nat_gateway_per_az  = true
  enable_dns_hostnames    = false
  enable_dns_support      = true
  map_public_ip_on_launch = false

  tags = "${merge(local.tags, map("kubernetes.io/cluster/${local.cluster_name}", "member"))}"

  igw_tags = "${map(
    "Name", "kubernetes-${local.cluster_name}-internetgw"
  )}"
}

# elb
module elb {
  source = "../../modules/aws/elb"

  cluster_name        = "${local.cluster_name}"
  vpc_id              = "${module.vpc.vpc_id}"
  avail_zones         = "${local.azs}"
  public_subnets      = "${module.vpc.public_subnets}"
  elb_api_port        = "${var.elb_api_port}"
  k8s_secure_api_port = "${var.k8s_secure_api_port}"
  tags                = "${local.tags}"
}

resource aws_elb_attachment masters {
  count    = "${var.master_num}"
  elb      = "${module.elb.elb_api_id}"
  instance = "${element(module.master.ids, count.index)}"
}

module iam {
  source = "../../modules/aws/iam"

  prefix = "${var.prefix}-${local.cluster_name}"
}

module master {
  source = "../../modules/aws/compute"

  number         = "${var.master_num}"
  instance_type  = "${var.master_type}"
  cluster_name   = "${local.cluster_name}"
  role           = "master"
  ami            = "${data.aws_ami.ubuntu.id}"
  zones          = "${local.azs}"
  key_name       = "${aws_key_pair.key.key_name}"
  user_data      = "${base64encode(local.cloud_init)}"
  security_group = "${aws_security_group.kubernetes.id}"
  subnets        = "${module.vpc.private_subnets}"
  iam_profile    = "${module.iam.master_profile}"

  tags = "${merge(local.tags, map(
      "Role", "master",
      "SshUser", "${var.ssh_user}",
      "node-role.kubernetes.io/master", "1"
    ))}"
}

module worker {
  source = "../../modules/aws/compute"

  number         = "${var.worker_num}"
  instance_type  = "${var.worker_type}"
  cluster_name   = "${local.cluster_name}"
  role           = "worker"
  ami            = "${data.aws_ami.ubuntu.id}"
  zones          = "${local.azs}"
  key_name       = "${aws_key_pair.key.key_name}"
  user_data      = "${base64encode(local.cloud_init)}"
  security_group = "${aws_security_group.kubernetes.id}"
  subnets        = "${module.vpc.private_subnets}"
  iam_profile    = "${module.iam.worker_profile}"

  tags = "${merge(local.tags, map(
      "Role", "worker",
      "SshUser", "${var.ssh_user}",
      "node-role.kubernetes.io/worker", "1",
      "beta.kubernetes.io/os", "linux",
    ))}"
}

module etcd {
  source = "../../modules/aws/compute"

  number         = "${var.etcd_num}"
  instance_type  = "${var.etcd_type}"
  cluster_name   = "${local.cluster_name}"
  role           = "etcd"
  ami            = "${data.aws_ami.ubuntu.id}"
  zones          = "${local.azs}"
  key_name       = "${aws_key_pair.key.key_name}"
  user_data      = "${base64encode(local.cloud_init)}"
  security_group = "${aws_security_group.kubernetes.id}"
  subnets        = "${module.vpc.private_subnets}"
  iam_profile    = ""

  tags = "${merge(local.tags, map(
      "Role", "etcd",
      "SshUser", "${var.ssh_user}",
      "node-role.kubernetes.io/etcd", "1",
      "beta.kubernetes.io/os", "linux",
    ))}"
}

resource aws_instance bastion {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.bastion_type}"
  associate_public_ip_address = true
  availability_zone           = "${element(local.azs,0)}"
  subnet_id                   = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  key_name                    = "${aws_key_pair.key.key_name}"
  user_data_base64            = "${base64encode(local.bastion_cloud_init)}"

  tags = "${merge(local.tags, map(
      "Name", "kubernetes-${local.cluster_name}-bastion",
      "Role", "bastion-${local.cluster_name}",
      "SshUser", "${var.ssh_user}"
    ))}"
}

