
locals {
  public_access_cidrs       = var.enable_public_access ? var.public_access_cidrs : []
  enabled_cluster_log_types = [for k, v in tomap(var.enable_logging) : k if v]
}

resource "aws_eks_cluster" "this" {
  depends_on = [aws_cloudwatch_log_group.cluster_log_group]
  name       = var.cluster_name
  version    = var.kubernetes_version
  role_arn   = var.cluster_role
  vpc_config {
    subnet_ids              = var.control_plane_subnets
    security_group_ids      = var.control_plane_security_groups
    endpoint_private_access = true
    endpoint_public_access  = var.enable_public_access
    public_access_cidrs     = local.public_access_cidrs
  }
  enabled_cluster_log_types = local.enabled_cluster_log_types
}
