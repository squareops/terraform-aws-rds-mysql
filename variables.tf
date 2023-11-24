variable "name" {
  description = "The name of the RDS instance"
  default     = ""
  type        = string
}

variable "allocated_storage" {
  description = "The storage capacity for the database"
  default     = 20
  type        = number
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks that are allowed to access the database"
  default     = []
  type        = list(any)
}

variable "allowed_security_groups" {
  description = "A list of Security Group IDs to allow access to the database"
  default     = []
  type        = list(any)
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately or during the next maintenance window"
  default     = false
  type        = bool
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for"
  type        = number
  default     = 5
}

variable "backup_window" {
  description = "The time window during which database backups are performed"
  default     = "03:00-06:00"
  type        = string
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain CloudWatch logs for the database instance"
  type        = number
  default     = 7
}

variable "create_random_password" {
  description = "Whether to create a random password for the primary database cluster"
  type        = bool
  default     = false
}

variable "create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Whether accidental deletion protection is enabled"
  default     = true
  type        = bool
}

variable "db_name" {
  description = "The name for an automatically created database on cluster creation"
  default     = ""
  type        = string
}

variable "enable_slow_query_log" {
  description = "Whether to enable slow query logs in CloudWatch"
  default     = true
  type        = bool
}

variable "enable_general_log" {
  description = "Whether to enable general logs in CloudWatch"
  default     = true
  type        = bool
}

variable "engine" {
  description = "The name of the database engine to be used for this DB cluster"
  default     = "mysql"
  type        = string
}

variable "engine_version" {
  description = "The database engine version. Updating this argument results in an outage."
  default     = ""
  type        = string
}

variable "environment" {
  description = "Select enviroment type: dev, demo, prod"
  default     = "demo"
  type        = string
}

variable "family" {
  description = "Version of the MySQL DB family being created"
  default     = ""
  type        = string
}

variable "final_snapshot_identifier_prefix" {
  description = "The prefix name for the final snapshot on cluster destroy"
  type        = string
  default     = "final"
}

variable "kms_key_arn" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified, the default KMS key created in your account will be used"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "The instance type for the database"
  default     = ""
  type        = string
}

variable "major_engine_version" {
  description = "The major version of the database engine. Updating this argument results in an outage."
  default     = ""
  type        = string
}

variable "master_username" {
  description = "The username for the RDS primary cluster"
  default     = ""
  type        = string
}

variable "maintenance_window" {
  description = "The maintenance window for performing database maintenance"
  default     = "Mon:00:00-Mon:03:00"
  type        = string
}

variable "multi_az" {
  description = "Enables multi-AZ for disaster recovery"
  default     = false
  type        = bool
}

variable "rds_instance_name" {
  description = "The name of the RDS instance"
  default     = ""
  type        = string
}

variable "port" {
  description = "The port for the database"
  type        = number
  default     = 3306
}

variable "publicly_accessible" {
  description = "Specifies whether the database is publicly accessible over the internet"
  default     = false
  type        = bool
}

variable "random_password_length" {
  description = "The length of the randomly generated password. (default: 10)"
  type        = number
  default     = 16
}

variable "replicate_source_db" {
  description = "Specifies the identifier of another Amazon RDS Database to replicate as the source database"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true, no DBSnapshot is created. If false, a DB snapshot is created using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "snapshot_identifier" {
  description = "Specifies whether to create this database from a snapshot. Use the snapshot ID found in the RDS console, e.g., rds:production-2015-06-26-06-05."
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Specifies whether database encryption is enabled"
  default     = true
  type        = bool
}

variable "subnet_ids" {
  description = "A list of subnet IDs used by the database subnet group created"
  default     = []
  type        = list(any)
}

variable "vpc_id" {
  description = "The ID of the VPC where the RDS cluster should be deployed"
  default     = ""
  type        = string
}

variable "enable_storage_autoscaling" {
  description = "Whether enable storage autoscaling or not"
  default     = false
  type        = bool
}

variable "max_allocated_storage" {
  description = "The Maximum storage capacity for the database value after autoscaling"
  default     = null
  type        = number
}

variable "storage_type" {
  description = "The storage type for the database storage like gp2,gp3,io1"
  default     = "gp2"
  type        = string
}

variable "replica_enable" {
  description = "Whether enable replica DB"
  default     = false
  type        = bool
}

variable "replica_count" {
  description = "The number of replica instance"
  default     = 1
  type        = number
}

variable "manage_master_user_password" {
  description = "Whether to manage master user password through service linked secret manager"
  default     = false
  type        = bool
}

variable "disk_free_storage_space" {
  type        = string
  default     = "10000000000" // 10 GB
  description = "Alarm threshold for the 'lowFreeStorageSpace' alarm"
}

variable "cloudwatch_metric_alarms_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable CloudWatch metrics alarms"
  default     = false
}

variable "alarm_cpu_threshold_percent" {
  type        = number
  default     = 75
  description = "CPU threshold alarm level"
}

variable "alarm_actions" {
  type        = list(string)
  description = "Alarm action list"
  default     = []
}

variable "ok_actions" {
  type        = list(string)
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN)"
  default     = []
}

variable "slack_notification_enabled" {
  type        = bool
  description = "Whether to enable/disable slack notification."
  default     = false
}

variable "slack_webhook_url" {
  description = "The Slack Webhook URL where notifications will be sent."
  default     = ""
  type        = string
}

variable "slack_channel" {
  description = "The Slack channel where notifications will be posted."
  default     = ""
  type        = string
}

variable "slack_username" {
  description = "The username to use when sending notifications to Slack."
  default     = ""
  type        = string
}

variable "cw_sns_topic_arn" {
  description = "The username to use when sending notifications to Slack."
  default     = ""
  type        = string
}

variable "custom_user_password" {
  description = "Custom password for the RDS master user"
  default     = ""
  type        = string
}
