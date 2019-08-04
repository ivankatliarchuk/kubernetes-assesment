output elb_api_id {
  value = "${aws_elb.elb_api.id}"
}

output elb_api_fqdn {
  value = "${aws_elb.elb_api.dns_name}"
}
