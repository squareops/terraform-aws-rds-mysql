<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.43.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds-mysql"></a> [rds-mysql](#module\_rds-mysql) | git@github.com:sq-ia/terraform-aws-rds-mysql.git | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds-mysql_db_instance_name"></a> [rds-mysql\_db\_instance\_name](#output\_rds-mysql\_db\_instance\_name) | The database name |
| <a name="output_rds-mysql_db_parameter_group_id"></a> [rds-mysql\_db\_parameter\_group\_id](#output\_rds-mysql\_db\_parameter\_group\_id) | The db parameter group id |
| <a name="output_rds-mysql_db_secret_arn"></a> [rds-mysql\_db\_secret\_arn](#output\_rds-mysql\_db\_secret\_arn) | ARN of the secret |
| <a name="output_rds-mysql_db_subnet_group_id"></a> [rds-mysql\_db\_subnet\_group\_id](#output\_rds-mysql\_db\_subnet\_group\_id) | The db subnet group name |
| <a name="output_rds-mysql_dedicated_security_group"></a> [rds-mysql\_dedicated\_security\_group](#output\_rds-mysql\_dedicated\_security\_group) | The security group ID of the cluster |
| <a name="output_rds-mysql_instance_endpoint"></a> [rds-mysql\_instance\_endpoint](#output\_rds-mysql\_instance\_endpoint) | The connection endpoint rds-mysql |
| <a name="output_rds-mysql_instance_password"></a> [rds-mysql\_instance\_password](#output\_rds-mysql\_instance\_password) | The database password (this password may be old, because Terraform doesn't track it after initial creation) rds-mysql |
| <a name="output_rds-mysql_instance_username"></a> [rds-mysql\_instance\_username](#output\_rds-mysql\_instance\_username) | The master username for the database rds-mysql |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
