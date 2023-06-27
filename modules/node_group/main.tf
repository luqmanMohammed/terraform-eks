locals {
  node_groups_map = { for ng in var.node_groups : ng.name => ng }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${data.aws_eks_cluster.cluster.version}/${var.os}/recommended/release_version"
}

resource "aws_eks_node_group" "this" {
  for_each        = local.node_groups_map
  cluster_name    = var.cluster_name
  version         = data.aws_eks_cluster.cluster.version
  node_group_name = each.key
  subnet_ids      = each.value.subnet_ids
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    min_size     = each.value.scaling_config.min_size
    max_size     = each.value.scaling_config.max_size
  }
  disk_size     = each.value.disk_size
  capacity_type = each.value.capacity_type
  node_role_arn = each.value.role_arn
  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

}
