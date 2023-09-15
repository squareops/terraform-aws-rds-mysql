## MySQL Example
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>

This example will be very useful for users who are new to a module and want to quickly learn how to use it. By reviewing the examples, users can gain a better understanding of how the module works, what features it supports, and how to customize it to their specific needs.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.43.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-aws-modules/kms/aws | n/a |
| <a name="module_rds-mysql"></a> [rds-mysql](#module\_rds-mysql) | squareops/rds-mysql/aws | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | squareops/vpc/aws | n/a |
| <a name="module_rds-mysql"></a> [rds-mysql](#module\_rds-mysql) | squareops/rds-mysql/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds-mysql_db_instance_name"></a> [rds-mysql\_db\_instance\_name](#output\_rds-mysql\_db\_instance\_name) | The name of the database instance |
| <a name="output_rds-mysql_db_parameter_group_id"></a> [rds-mysql\_db\_parameter\_group\_id](#output\_rds-mysql\_db\_parameter\_group\_id) | The ID of the database parameter group |
| <a name="output_rds-mysql_db_secret_arn"></a> [rds-mysql\_db\_secret\_arn](#output\_rds-mysql\_db\_secret\_arn) | The ARN (Amazon Resource Name) of the secret storing database credentials |
| <a name="output_rds-mysql_db_subnet_group_id"></a> [rds-mysql\_db\_subnet\_group\_id](#output\_rds-mysql\_db\_subnet\_group\_id) | The ID of the database subnet group |
| <a name="output_rds-mysql_dedicated_security_group"></a> [rds-mysql\_dedicated\_security\_group](#output\_rds-mysql\_dedicated\_security\_group) | The security group ID associated with the RDS cluster |
| <a name="output_rds-mysql_instance_endpoint"></a> [rds-mysql\_instance\_endpoint](#output\_rds-mysql\_instance\_endpoint) | The endpoint for connecting to the database instance |
| <a name="output_rds-mysql_instance_password"></a> [rds-mysql\_instance\_password](#output\_rds-mysql\_instance\_password) | The password for accessing the database instance (note: Terraform doesn't track changes to this password) |
| <a name="output_rds-mysql_instance_username"></a> [rds-mysql\_instance\_username](#output\_rds-mysql\_instance\_username) | The master username for accessing the database instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
