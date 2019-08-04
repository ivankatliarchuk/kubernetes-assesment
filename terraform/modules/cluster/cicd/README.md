# CI&CD module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apps | Multiple applications to deploy | map | n/a | yes |
| bucket | Bucket where to store backups | string | n/a | yes |
| namespace | Namespace to where deploy CI/CD | string | n/a | yes |
| region | Region where backup is stored | string | n/a | yes |
| repository | Collection of Helm repositories | map | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->