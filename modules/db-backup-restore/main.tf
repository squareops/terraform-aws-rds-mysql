resource "kubernetes_namespace" "mysqldb" {
  count = var.create_namespace ? 1 : 0
  metadata {
    annotations = {}
    name        = var.namespace
  }
}

resource "helm_release" "mysqldb_backup" {
  count      = var.mysqldb_backup_enabled ? 1 : 0
  depends_on = [kubernetes_namespace.mysqldb]
  name       = "mysqldb-backup"
  chart      = "${path.module}/../../modules/db-backup-restore/backup"
  timeout    = 600
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/../../helm/values/backup/values.yaml", {
      bucket_uri                 = var.mysqldb_backup_config.bucket_uri,
      mysql_database_name        = var.bucket_provider_type == "s3" ? var.mysqldb_backup_config.mysql_database_name : "",
      db_endpoint                = var.bucket_provider_type == "s3" ? var.mysqldb_backup_config.db_endpoint : "",
      db_password                = var.bucket_provider_type == "s3" ? var.mysqldb_backup_config.db_password : "",
      db_username                = var.bucket_provider_type == "s3" ? var.mysqldb_backup_config.db_username : "",
      s3_bucket_region           = var.bucket_provider_type == "s3" ? var.mysqldb_backup_config.s3_bucket_region : "",
      cron_for_full_backup       = var.mysqldb_backup_config.cron_for_full_backup,
      custom_user_username       = "admin",
      bucket_provider_type       = var.bucket_provider_type,
      azure_storage_account_name = var.bucket_provider_type == "azure" ? var.azure_storage_account_name : ""
      azure_storage_account_key  = var.bucket_provider_type == "azure" ? var.azure_storage_account_key : ""
      azure_container_name       = var.bucket_provider_type == "azure" ? var.azure_container_name : ""
      annotations                = var.bucket_provider_type == "s3" ? "eks.amazonaws.com/role-arn: ${aws_iam_role.mysql_backup_role[count.index].arn}" : "iam.gke.io/gcp-service-account: ${var.service_account_backup}"
    })
  ]
}


## DB dump restore
resource "helm_release" "mysqldb_restore" {
  count      = var.mysqldb_restore_enabled ? 1 : 0
  depends_on = [kubernetes_namespace.mysqldb]
  name       = "mysqldb-restore"
  chart      = "${path.module}/../../modules/db-backup-restore/restore"
  timeout    = 600
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/../../helm/values/restore/values.yaml", {
      bucket_uri                 = var.mysqldb_restore_config.bucket_uri,
      file_name                  = var.mysqldb_restore_config.file_name,
      s3_bucket_region           = var.bucket_provider_type == "s3" ? var.mysqldb_restore_config.s3_bucket_region : "",
      db_endpoint                = var.bucket_provider_type == "s3" ? var.mysqldb_restore_config.db_endpoint : "",
      db_password                = var.bucket_provider_type == "s3" ? var.mysqldb_restore_config.db_password : "",
      db_username                = var.bucket_provider_type == "s3" ? var.mysqldb_restore_config.db_username : "",
      custom_user_username       = "admin",
      bucket_provider_type       = var.bucket_provider_type,
      azure_storage_account_name = var.bucket_provider_type == "azure" ? var.azure_storage_account_name : ""
      azure_storage_account_key  = var.bucket_provider_type == "azure" ? var.azure_storage_account_key : ""
      azure_container_name       = var.bucket_provider_type == "azure" ? var.azure_container_name : ""
      annotations                = var.bucket_provider_type == "s3" ? "eks.amazonaws.com/role-arn: ${aws_iam_role.mysql_restore_role[count.index].arn}" : "iam.gke.io/gcp-service-account: ${var.service_account_restore}"
    })
  ]
}




