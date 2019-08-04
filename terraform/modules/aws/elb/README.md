

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| avail\_zones | Availability Zones Used | list | n/a | yes |
| cluster\_name | Name of Cluster | string | n/a | yes |
| elb\_api\_port | Port for AWS ELB | string | n/a | yes |
| k8s\_secure\_api\_port | Secure Port of K8S API Server | string | n/a | yes |
| public\_subnets | IDs of Public Subnets | list | n/a | yes |
| tags | Tags for all resources | map | n/a | yes |
| vpc\_id | AWS VPC ID | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb\_api\_fqdn |  |
| elb\_api\_id |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->