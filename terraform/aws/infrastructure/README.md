# Base Infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_whitelist |  | list | n/a | yes |
| cidr\_subnets\_private | CIDR Blocks for private subnets in Availability Zones | list | n/a | yes |
| cidr\_subnets\_public | CIDR Blocks for public subnets in Availability Zones | list | n/a | yes |
| cluster\_name | Name of AWS Cluster | string | n/a | yes |
| coreos\_account\_number |  | string | `"595879546273"` | no |
| elb\_api\_port | Port for AWS ELB | string | n/a | yes |
| instances | Cluster instance types in single container | map | n/a | yes |
| inventory\_path |  | string | n/a | yes |
| k8s\_secure\_api\_port | Secure Port of K8S API Server | string | n/a | yes |
| prefix |  | string | n/a | yes |
| private\_ssh\_path |  | string | n/a | yes |
| project | the project to deploy to, if not set the default provider project is used | string | n/a | yes |
| region | Region where to deploy infrastructure | string | n/a | yes |
| ssh\_user | The name of the default ssh user | string | n/a | yes |
| ubuntu\_account\_number |  | string | `"099720109477"` | no |
| vpc\_cidr\_block | CIDR Block for VPC | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_external\_ip |  |
| commands |  |
| etcd\_private\_ips |  |
| master\_private\_ips |  |
| private\_ssh\_key |  |
| private\_ssh\_path |  |
| private\_subnets |  |
| public\_ssh\_key |  |
| public\_subnets | ------------------------------------------------------------VPC Information------------------------------------------------------------ |
| supported\_zones |  |
| ubuntu\_version |  |
| worker\_private\_ips |  |
| zones |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->