output ids {
  value = "${aws_instance.this.*.id}"
}

output ips {
  value = "${aws_instance.this.*.private_ip}"
}

output private_dns {
  value = "${aws_instance.this.*.private_dns}"
}

output members {
  value = "${aws_instance.this.*.tags.Member}"
}
