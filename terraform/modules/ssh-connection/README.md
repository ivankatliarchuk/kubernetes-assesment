# Validate SSH connection

The purpose of this module is to block terraform from existing
if connection to node via bastion cannot be esatablished

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_address | Setting this enables the bastion Host connection. This host will be connected to first, and then the host connection will be made from there | string | n/a | yes |
| bastion\_port | The port to use connect to the bastion host. Defaults to the value of the port field. | string | `"22"` | no |
| connection\_timeout | The timeout to wait for the connection to become available. | string | `"10m"` | no |
| connection\_type | The connection type that should be used | string | `"ssh"` | no |
| constant | used to manually trigger validation | string | n/a | yes |
| hosts | ips to connect | list | n/a | yes |
| inventory\_template | trigger on inventory template change | string | n/a | yes |
| nodes | number of nodes to connect | string | n/a | yes |
| private\_key | The contents of an SSH key to use for the connection. | string | n/a | yes |
| ssh\_user | User that is used to connect to nodes | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->