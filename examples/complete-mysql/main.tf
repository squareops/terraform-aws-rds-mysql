locals {
  name                    = "mysql"
  region                  = "us-east-2"
  family                  = "mysql8.0"
  vpc_id                  = "vpc-06861ba817a8cda10"
  subnet_ids              = ["subnet-09e8f6ea27b7e36d0", "subnet-0b070110454617a90"]
  environment             = "prod"
  kms_key_arn             = ""
  mysql_instance_class    = "db.t3.medium"
  mysql_engine_version    = "8.0.32"
  major_engine_version    = "8.0"
  allowed_security_groups = ["sg-0ef14212995d67a2d"]
  additional_tags = {
    Owner      = "Organization_Name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "rds-mysql" {
  source                           = "squareops/rds-mysql/aws"
  name                             = local.name
  vpc_id                           = local.vpc_id
  subnet_ids                       = local.subnet_ids
  family                           = local.family
  db_name                          = "proddb"
  multi_az                         = false
  environment                      = local.environment
  kms_key_arn                      = local.kms_key_arn
  engine_version                   = local.mysql_engine_version
  instance_class                   = local.mysql_instance_class
  master_username                  = "admin"
  allocated_storage                = 20
  rds_instance_name                = local.name
  major_engine_version             = local.major_engine_version
  allowed_security_groups          = local.allowed_security_groups
  publicly_accessible              = false
  skip_final_snapshot              = true
  backup_window                    = "03:00-06:00"
  snapshot_identifier              = null
  maintenance_window               = "Mon:00:00-Mon:03:00"
  deletion_protection              = false
  final_snapshot_identifier_prefix = "prod-snapshot"
  cloudwatch_metric_alarms_enabled = true
  alarm_cpu_threshold_percent      = 70
  disk_free_storage_space          = "10000000" # in bytes
  slack_username                   = ""
  slack_channel                    = ""
  slack_webhook_url                = ""
}
