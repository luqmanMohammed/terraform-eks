locals {
  node_groups = [
    for ng_ in var.node_groups : {
      name           = "${var.deployment_name}-${ng_.name}"
      instance_types = [ng_.instance_type]
      role_arn       = module.iam_roles.node_group_role_arn
      capacity_type  = "ON_DEMAND"
      subnet_ids     = data.aws_subnets.node_group_subnets.ids
      disk_size      = ng_.disk_size
      scaling_config = {
        desired_size = ng_.desired_instance_count
        min_size     = ng_.min_instance_count
        max_size     = ng_.max_instance_count
      }
    }
  ]
}

data "aws_subnets" "node_group_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    "Name" : "*${var.node_group_subnet_type}*"
  }
}

module "node_group" {
  depends_on   = [module.eks, module.iam_roles]
  source       = "../node_group"
  cluster_name = var.deployment_name
  node_groups  = local.node_groups
}
