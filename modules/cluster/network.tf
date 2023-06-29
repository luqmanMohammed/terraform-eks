data "aws_subnets" "control_plane_subnets" {
  for_each = var.control_plane_subnet_name_selectors
  filter {
    name = "vpc-id"
    values = [
      var.vpc_id
    ]
  }
  tags = {
    "Name" = each.value
  }
}

data "aws_subnets" "node_group_subnets" {
  for_each = var.node_group_subnet_name_selectors
  filter {
    name = "vpc-id"
    values = [
      var.vpc_id
    ]
  }

  tags = {
    "Name" = each.value
  }
}

locals {
  control_plane_selected_subnets = flatten([
    for ss in data.aws_subnets.control_plane_subnets : ss.ids
  ])
  control_plane_subnet_ids = distinct(concat(tolist(var.control_plane_subnet_ids), local.control_plane_selected_subnets))

  node_group_selected_subnets = flatten([
    for ss in data.aws_subnets.node_group_subnets : ss.ids
  ])
  node_group_subnet_ids = distinct(concat(tolist(var.node_group_subnet_ids), local.node_group_selected_subnets))
}

module "caller_details" {
  count  = var.whitelist_caller_public_ip ? 1 : 0
  source = "../helpers/get_local_details"
}

locals {
  whitelist_public_cidrs = distinct(concat(
    tolist(var.whitelist_public_cidrs),
    var.whitelist_caller_public_ip ? ["${module.caller_details[0].public_ip}/32"] : []
  ))
}