

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami |  | string | n/a | yes |
| associate\_pulic\_ip |  | string | `"false"` | no |
| cluster\_name |  | string | n/a | yes |
| iam\_profile |  | string | n/a | yes |
| instance\_type |  | string | n/a | yes |
| key\_name |  | string | n/a | yes |
| number |  | string | `"0"` | no |
| role |  | string | n/a | yes |
| security\_group |  | string | n/a | yes |
| subnets |  | list | n/a | yes |
| tags |  | map | `{}` | no |
| user\_data |  | string | n/a | yes |
| zones |  | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ids |  |
| ips |  |
| members |  |
| private\_dns |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->