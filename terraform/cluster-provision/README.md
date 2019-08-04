# Provision cluster with multiple apps

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apps | Multiple Applications to deploy with HELM | map | n/a | yes |
| bucket |  | string | `"Bucket where states stored"` | no |
| kub\_config | Kube config path | string | n/a | yes |
| prefix |  | string | n/a | yes |
| project |  | string | n/a | yes |
| region | Cluser region, required for some apps | string | n/a | yes |
| tiller\_image | Tiller image for custom installation | string | `"gcr.io/kubernetes-helm/tiller:v2.14.2"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->