resource kubernetes_storage_class local_storage {
  metadata {
    name = "local-storage"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type = "pd-standard"
  }
}
