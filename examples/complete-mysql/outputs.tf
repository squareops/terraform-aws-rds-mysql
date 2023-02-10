output "rds-mysql_instance_endpoint" {
  description = "The connection endpoint rds-mysql"
  value       = module.rds-mysql.db_instance_endpoint
}

output "rds-mysql_instance_username" {
  description = "The master username for the database rds-mysql"
  value       = module.rds-mysql.db_instance_username
}

output "rds-mysql_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation) rds-mysql"
  value       = module.rds-mysql.db_instance_password
}

output "rds-mysql_db_instance_name" {
  description = "The database name"
  value       = module.rds-mysql.db_instance_name
}

output "rds-mysql_dedicated_security_group" {
  description = "The security group ID of the cluster"
  value       = module.rds-mysql.rds_dedicated_security_group
}

output "rds-mysql_db_parameter_group_id" {
  description = "The db parameter group id"
  value       = module.rds-mysql.db_parameter_group_id
}

output "rds-mysql_db_subnet_group_id" {
  description = "The db subnet group name"
  value       = module.rds-mysql.db_subnet_group_id
}

output "rds-mysql_db_secret_arn" {
  description = "ARN of the secret"
  value       = module.rds-mysql.db_secret_arn
}
