module "local_details" {
  count  = var.whitelist_local_ip ? 1 : 0
  source = "../helpers/get_local_details"
}

data "aws_subnets" "control_plane_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    "Name" : "*${var.control_plane_subnet_type}*"
  }
}

locals {
  public_access_cidrs = var.whitelist_local_ip ? concat(["${module.local_details[0].public_ip}/32"], var.whitelist_public_cidrs) : var.whitelist_public_cidrs
}

module "eks" {
  source                               = "../eks"
  cluster_name                         = var.deployment_name
  cluster_role                         = module.iam_roles.cluster_role_arn
  control_plane_subnets                = data.aws_subnets.control_plane_subnets.ids
  enable_iam_roles_for_service_account = true
  public_access_cidrs                  = local.public_access_cidrs
  enable_public_access                 = true
  log_group_retention_period           = 7
}