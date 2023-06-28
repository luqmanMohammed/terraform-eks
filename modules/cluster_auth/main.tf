data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "kubernetes_config_map" "aws_auth_cm" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}

locals {
  base_map_roles = yamldecode(try(data.kubernetes_config_map.aws_auth_cm.data["mapRoles"], "---"))
  base_map_users = yamldecode(try(data.kubernetes_config_map.aws_auth_cm.data["mapUsers"], "---"))

  combined_map_roles = concat(local.base_map_roles, var.auth_config_map_roles)
  combined_map_users = concat(local.base_map_users, var.auth_config_map_users)
}

import {
  to = kubernetes_config_map.aws_auth_cm
  id = "kube-system/aws-auth"
}


resource "kubernetes_config_map" "aws_auth_cm" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles  = yamlencode(local.combined_mapRoles)
    mapUseres = yamlencode(local.mapUsers)
  }
}