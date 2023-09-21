output "db_instance_endpoint" {
  description = "The endpoint for connecting to the database instance"
  value       = module.db.db_instance_endpoint
}

output "replica_db_instance_endpoint" {
  description = "The replica db endpoint for connecting to the database instance"
  value       = module.db_replica[*].db_instance_endpoint
}

output "db_instance_name" {
  description = "The name of the database instance"
  value       = module.db.db_instance_identifier
}

output "replica_db_instance_name" {
  description = "The name of the replica database instance"
  value       = module.db_replica[*].db_instance_identifier
}

output "replica_db_instance_address" {
  description = "The ID of the replica database instance"
  value       = module.db_replica[*].db_instance_address
}

output "db_instance_username" {
  description = "The master username for accessing the database instance"
  value       = nonsensitive(module.db.db_instance_username)
}

output "db_instance_password" {
  description = "The password for accessing the database instance (note: Terraform doesn't track changes to this password)"
  value       = nonsensitive(random_password.master[0].result)
}

output "master_credential_secret_arn" {
  description = "The ARN of the master user secret (Only available when manage_master_user_password is set to true)"
  value       = aws_secretsmanager_secret.secret_master_db.arn
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


output "enhanced_monitoring_iam_role_arn" {
  description = "The ARN of the monitoring role"
  value       = module.db.enhanced_monitoring_iam_role_arn
}
