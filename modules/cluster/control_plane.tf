module "eks" {
  source                               = "../eks"
  cluster_name                         = var.cluster_name
  control_plane_subnets                = local.control_plane_subnet_ids
  control_plane_security_groups        = var.control_plane_security_groups
  logging_config                       = var.logging_config
  log_group_retention_period           = var.log_group_retention_period
  enable_iam_roles_for_service_account = var.enable_serviceroles
  encryption_kms_key_arn               = local.create_kms_key ? aws_kms_alias.secret_encryption_key_alias[0].arn : var.secret_encryption_kms_key_arn
  cluster_role                         = module.iam_roles.cluster_role_arn
  kubernetes_version                   = var.kubernetes_version
  enable_public_access                 = length(local.whitelist_public_cidrs) > 0
  public_access_cidrs                  = local.whitelist_public_cidrs
}