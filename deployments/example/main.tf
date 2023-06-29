provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

module "cluster" {
  source                              = "../../modules/cluster"
  cluster_name                        = var.cluster_name
  node_group_subnet_name_selectors    = ["*private*"]
  control_plane_subnet_name_selectors = ["*private*"]
  enable_secret_encryption            = true
  whitelist_caller_public_ip          = true
  enable_serviceroles                 = true
  log_group_retention_period          = 7
  vpc_id                              = var.vpc_id
  node_groups = [
    {
      name                   = "t2-medium-group"
      disk_size              = 20
      desired_instance_count = 2
      max_instance_count     = 3
      min_instance_count     = 0
      instance_type          = "t2.medium"
    },
    {
      name                   = "t2-medium-spot-group"
      disk_size              = 20
      desired_instance_count = 2
      max_instance_count     = 3
      min_instance_count     = 0
      instance_type          = "t2.medium"
      capacity_type          = "SPOT"
    },
  ]

}