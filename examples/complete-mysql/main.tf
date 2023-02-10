locals {
  mysql_instance_class = "db.t3.medium"
  mysql_engine_version = "8.0.23"
  region               = "us-east-2"
  environment          = "production"
  name                 = "skaf"

}

module "rds-mysql" {
  source            = "../../"
  environment       = local.environment
  rds_instance_name = local.name
  allowed_cidr_blocks     = []
  allowed_security_groups = ["sg-08ef8bdc01fd9e479"]
  engine                  = "mysql"
  engine_version          = local.mysql_engine_version
  instance_class          = local.mysql_instance_class
  allocated_storage       = 20
  storage_encrypted       = true
  kms_key_arn             = "arn:aws:kms:us-east-2:222222222222:key/kms_key_arn"
  publicly_accessible     = false
  master_username         = "admin"
  db_name                 = "proddb"
  port                    = 3306
  multi_az                = false
  vpc_id                  = "vpc-xyz5ed733e273skaf"
  subnet_ids              = ["subnet-xyz546125e075skaf","subnet-xyz8f0564e655skaf"]
  apply_immediately       = true
  random_password_length  = 20
  skip_final_snapshot              = true 
  final_snapshot_identifier_prefix = "prod-snapshot"
  snapshot_identifier              = null
  maintenance_window               = "Mon:00:00-Mon:03:00"
  backup_window                    = "03:00-06:00"
  backup_retention_period          = 7
  family               = "mysql8.0"
  major_engine_version = "8.0"
  deletion_protection  = true
}
