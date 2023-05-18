output "db_instance_endpoint" {
  description = "The endpoint for connecting to the database instance"
  value       = module.db.db_instance_endpoint
}

output "db_instance_name" {
  description = "The name of the database instance"
  value       = module.db.db_instance_name
}

output "db_instance_username" {
  description = "The master username for accessing the database instance"
  value       = nonsensitive(module.db.db_instance_username)
}

output "db_instance_password" {
  description = "The password for accessing the database instance (note: Terraform doesn't track changes to this password)"
  value       = nonsensitive(module.db.db_instance_password)
}

output "rds_dedicated_security_group" {
  description = "The security group ID associated with the RDS cluster"
  value       = module.security_group_rds.security_group_id
}

output "db_parameter_group_id" {
  description = "The ID of the database parameter group"
  value       = module.db.db_parameter_group_id
}

output "db_subnet_group_id" {
  description = "The ID of the database subnet group"
  value       = module.db.db_subnet_group_id
}

output "db_secret_arn" {
  description = "The ARN (Amazon Resource Name) of the secret storing database credentials"
  value       = resource.aws_secretsmanager_secret.secret_master_db
}
