output namespace {
  value = "${lookup(kubernetes_namespace.this.metadata[0], "name")}"
}
