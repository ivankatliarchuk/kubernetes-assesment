output master_profile {
  value = "${aws_iam_instance_profile.master.name}"
}

output worker_profile {
  value = "${aws_iam_instance_profile.worker.name}"
}
