# Tiller setup

Install tiller on kubernetes the right way using infrasturcture-as-code.

Manual deleteion of tiller
```
kubectl delete deployment tiller-deploy --namespace kube-system
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| namespace | ------------------------------------------------------------REQUIRED PARAMETERSThese variables are expected to be passed in by the operator------------------------------------------------------------ | string | n/a | yes |
| tiller\_image |  | string | `"gcr.io/kubernetes-helm/tiller:v2.14.2"` | no |
| tiller\_max\_history |  | string | `"50"` | no |
| tiller\_replicas |  | string | `"1"` | no |
| tiller\_service\_type | Type of Tiller's Kubernetes service object. | string | `"ClusterIP"` | no |
| tiller\_version |  | string | `"v2.14.2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->