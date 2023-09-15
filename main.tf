locals {
  tags = {
    Environment = var.environment
  }
}

module "db" {
  source                           = "terraform-aws-modules/rds/aws"
  version                          = "6.1.0"
  identifier                       = format("%s-%s", var.environment, var.rds_instance_name)
  db_name                          = var.db_name
  password                         = var.manage_master_user_password ? null : random_password.master[0].result
  username                         = var.master_username
  port                             = var.port
  engine                           = var.engine
  multi_az                         = var.multi_az
  subnet_ids                       = var.subnet_ids
  kms_key_id                       = var.kms_key_arn
  storage_type                     = var.storage_type
  engine_version                   = var.engine_version
  instance_class                   = var.instance_class
  allocated_storage                = var.allocated_storage
  max_allocated_storage            = var.enable_storage_autoscaling && var.max_allocated_storage != "" ? var.max_allocated_storage : null
  storage_encrypted                = var.storage_encrypted
  publicly_accessible              = var.publicly_accessible
  create_db_subnet_group           = var.create_db_subnet_group
  vpc_security_group_ids           = split(",", module.security_group_rds.security_group_id)
  skip_final_snapshot              = var.skip_final_snapshot
  final_snapshot_identifier_prefix = var.final_snapshot_identifier_prefix
  snapshot_identifier              = var.snapshot_identifier
  maintenance_window               = var.maintenance_window
  backup_window                    = var.backup_window
  backup_retention_period          = var.backup_retention_period
  apply_immediately                = var.apply_immediately
  # random_password_length                 = var.random_password_length
  # create_random_password                 = var.create_random_password
  manage_master_user_password            = var.manage_master_user_password ? true : false
  monitoring_interval                    = "30"
  monitoring_role_name                   = format("%s-%s-RDSMySQL", var.rds_instance_name, var.environment)
  create_monitoring_role                 = true
  create_cloudwatch_log_group            = true
  enabled_cloudwatch_logs_exports        = var.engine == "mysql" ? ["audit", "error", "general", "slowquery"] : ["postgresql"]
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags = merge(
    { "Name" = format("%s-%s", var.environment, var.rds_instance_name) },
    local.tags,
  )
  family               = var.family
  major_engine_version = var.major_engine_version
  deletion_protection  = var.deletion_protection

  parameters = [
    {
      name  = "general_log"
      value = (var.enable_general_log ? 1 : 0)
    },
    {
      name  = "slow_query_log"
      value = (var.enable_slow_query_log ? 1 : 0)
    },
    {
      name  = "log_output"
      value = "FILE"
    }
  ]
}

module "db_replica" {
  source                                 = "terraform-aws-modules/rds/aws"
  count                                  = var.replica_enable ? var.replica_count : 0
  version                                = "6.1.0"
  identifier                             = format("%s-%s-replica-%d", var.environment, var.rds_instance_name, count.index)
  port                                   = var.port
  engine                                 = var.engine
  multi_az                               = var.multi_az
  kms_key_id                             = var.kms_key_arn
  storage_type                           = var.storage_type
  engine_version                         = var.engine_version
  instance_class                         = var.instance_class
  storage_encrypted                      = var.storage_encrypted
  publicly_accessible                    = var.publicly_accessible
  replicate_source_db                    = module.db.db_instance_identifier
  vpc_security_group_ids                 = split(",", module.security_group_rds.security_group_id)
  skip_final_snapshot                    = var.skip_final_snapshot
  final_snapshot_identifier_prefix       = var.final_snapshot_identifier_prefix
  snapshot_identifier                    = var.snapshot_identifier
  maintenance_window                     = var.maintenance_window
  backup_window                          = var.backup_window
  backup_retention_period                = var.backup_retention_period
  apply_immediately                      = var.apply_immediately
  monitoring_interval                    = "30"
  monitoring_role_arn                    = module.db.enhanced_monitoring_iam_role_arn
  create_monitoring_role                 = false
  create_cloudwatch_log_group            = true
  enabled_cloudwatch_logs_exports        = var.engine == "mysql" ? ["audit", "error", "general", "slowquery"] : ["postgresql"]
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags = merge(
    { "Name" = format("%s-%s-%s", var.environment, var.rds_instance_name, "replica") },
    local.tags,
  )
  family               = var.family
  major_engine_version = var.major_engine_version
  deletion_protection  = var.deletion_protection
  depends_on           = [module.db]
}

resource "aws_security_group_rule" "default_ingress" {
  count                    = length(var.allowed_security_groups) > 0 ? length(var.allowed_security_groups) : 0
  description              = "From allowed SGs"
  type                     = "ingress"
  to_port                  = var.port
  from_port                = var.port
  protocol                 = "tcp"
  source_security_group_id = element(var.allowed_security_groups, count.index)
  security_group_id        = module.security_group_rds.security_group_id
}

resource "aws_security_group_rule" "cidr_ingress" {
  count             = length(var.allowed_cidr_blocks) > 0 ? length(var.allowed_cidr_blocks) : 0
  description       = "From allowed CIDRs"
  type              = "ingress"
  to_port           = var.port
  from_port         = var.port
  protocol          = "tcp"
  cidr_blocks       = element(var.allowed_cidr_blocks, count.index)
  security_group_id = module.security_group_rds.security_group_id
}

module "security_group_rds" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.13.0"
  name        = format("%s-%s-%s", var.environment, var.rds_instance_name, "rds-sg")
  create      = true
  vpc_id      = var.vpc_id
  description = "Complete MySQL example security group"
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = merge(
    { "Name" = format("%s-%s-%s", var.environment, var.rds_instance_name, "rds-sg") },
    local.tags,
  )
}

resource "aws_secretsmanager_secret" "secret_master_db" {
  name = format("%s/%s/%s", var.environment, var.rds_instance_name, "rds-mysql-pass-update-new")
  tags = merge(
    { "Name" = format("%s/%s/%s", var.environment, var.rds_instance_name, "rds-mysql-pass-update-new") },
    local.tags,
  )
}

resource "random_password" "master" {
  count   = var.manage_master_user_password ? 0 : 1
  length  = var.random_password_length
  special = false
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  count         = var.manage_master_user_password ? 0 : 1
  secret_id     = aws_secretsmanager_secret.secret_master_db.id
  secret_string = <<EOF
{
  "username": "${module.db.db_instance_username}",
  "password": "${random_password.master[0].result}",
  "engine": "${var.engine}",
  "host": "${module.db.db_instance_endpoint}"
}
EOF
}
