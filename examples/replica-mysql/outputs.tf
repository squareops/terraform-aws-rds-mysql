output "rds-mysql_instance_endpoint" {
  description = "The endpoint for connecting to the database instance"
  value       = module.rds-mysql.db_instance_endpoint
}

output "rds-mysql_replica_instance_endpoint" {
  description = "The endpoint for connecting to the database instance"
  value       = module.rds-mysql.replica_db_instance_endpoint
}

output "rds-mysql_instance_username" {
  description = "The master username for accessing the database instance"
  value       = module.rds-mysql.db_instance_username
}

output "rds-mysql_replica_instance_id" {
  description = "The master username for accessing the database instance"
  value       = module.rds-mysql.replica_db_instance_address
}

output "rds-mysql_instance_password" {
  description = "The password for accessing the database instance (note: Terraform doesn't track changes to this password)"
  value       = module.rds-mysql.db_instance_password
}

output "rds-mysql_db_instance_name" {
  description = "The name of the database instance"
  value       = module.rds-mysql.db_instance_name
}

output "rds-mysql_replica_db_instance_name" {
  description = "The name of the database instance"
  value       = module.rds-mysql.replica_db_instance_name
}

output "rds-mysql_dedicated_security_group" {
  description = "The security group ID associated with the RDS cluster"
  value       = module.rds-mysql.rds_dedicated_security_group
}

output "rds-mysql_db_parameter_group_id" {
  description = "The ID of the database parameter group"
  value       = module.rds-mysql.db_parameter_group_id
}

output "rds-mysql_db_subnet_group_id" {
  description = "The ID of the database subnet group"
  value       = module.rds-mysql.db_subnet_group_id
}

output "rds-mysql_db_secret_arn" {
  description = "The ARN (Amazon Resource Name) of the secret storing database credentials"
  value       = module.rds-mysql.master_credential_secret_arn
}
