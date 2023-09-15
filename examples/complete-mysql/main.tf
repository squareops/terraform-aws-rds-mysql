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
  vpc_cidr                   = "10.10.0.0/16"
  enable_storage_autoscaling = true
  current_identity           = data.aws_caller_identity.current.arn

}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "kms" {
  source = "terraform-aws-modules/kms/aws"

  deletion_window_in_days = 7
  description             = "Complete key example showing various configurations available"
  enable_key_rotation     = false
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"
  multi_region            = false

  # Policy
  enable_default_policy = true
  key_owners            = [local.current_identity]
  key_administrators    = [local.current_identity]
  key_users             = [local.current_identity]
  key_service_users     = [local.current_identity]
  key_statements = [
    {
      sid = "Allow use of the key"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = ["*"]

      principals = [
        {
          type = "Service"
          identifiers = [
            "monitoring.rds.amazonaws.com",
            "rds.amazonaws.com",
          ]
        }
      ]
    },
    {
      sid       = "Enable IAM User Permissions"
      actions   = ["kms:*"]
      resources = ["*"]

      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
            data.aws_caller_identity.current.arn,
          ]
        }
      ]
    }
  ]

  # Aliases
  aliases = ["${local.name}"]

  tags = local.additional_tags
}

module "vpc" {
  source                  = "squareops/vpc/aws"
  name                    = local.name
  vpc_cidr                = local.vpc_cidr
  environment             = local.environment
  availability_zones      = ["us-east-2a", "us-east-2b"]
  public_subnet_enabled   = true
  auto_assign_public_ip   = true
  intra_subnet_enabled    = false
  private_subnet_enabled  = true
  one_nat_gateway_per_az  = false
  database_subnet_enabled = true
}



module "rds-mysql" {
  source                           = "squareops/rds-mysql/aws"
  name                             = local.name
  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.database_subnets
  family                           = local.family
  max_allocated_storage            = 120
  db_name                          = "testdb"
  storage_type                     = "gp3"
  multi_az                         = false
  environment                      = local.environment
  kms_key_arn                      = module.kms.key_arn
  engine_version                   = local.mysql_engine_version
  instance_class                   = local.mysql_instance_class
  master_username                  = "admin"
  allocated_storage                = 20
  rds_instance_name                = local.name
  major_engine_version             = local.major_engine_version
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
