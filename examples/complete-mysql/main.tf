locals {
  name                    = "skaf"
  region                  = "us-east-1"
  family                  = "mysql8.0"
  vpc_id                  = "vpc-069a1a2f3a7"
  subnet_ids              = ["subnet-0bb2803128ab", "subnet-0b543628666a"]
  environment             = "prod"
  kms_key_arn             = "arn:aws:kms:us-east-1:2222222222:key/bcfdc1c5-241e-b467d90"
  mysql_instance_class    = "db.t3.medium"
  mysql_engine_version    = "8.0.32"
  major_engine_version    = "8.0"
  allowed_security_groups = ["sg-0e8dab08e40"]
}

module "rds-mysql" {
  source                           = "git@github.com:sq-ia/terraform-aws-rds-mysql.git"
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
  deletion_protection              = true
  final_snapshot_identifier_prefix = "prod-snapshot"
}
