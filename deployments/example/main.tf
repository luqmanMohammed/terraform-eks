provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "deployment_name" {
  type = string
}

module "deployment" {
  source = "../../modules/deployment"

  deployment_name = var.deployment_name

  vpc_id                    = var.vpc_id
  control_plane_subnet_type = "private"
  node_group_subnet_type    = "private"
  node_groups = [{
    name                   = "t2-medium-group"
    instance_type          = "t2.medium"
    disk_size              = 30
    desired_instance_count = 2
    max_instance_count     = 3
    min_instance_count     = 1
  }]

  service_role_definitions = {
    "${var.deployment_name}-argo-cd-service-role" : {
      service_account_names = [
        "argocd:argocd"
      ]
      policy_arns = [
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
        "arn:aws:iam::aws:policy/ReadOnlyAccess"
      ]
    }
  }
}