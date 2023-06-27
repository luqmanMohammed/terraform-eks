variable "deployment_name" {
  type = string
}

variable "control_plane_subnet_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "whitelist_local_ip" {
  type    = bool
  default = true
}

variable "node_groups" {
  type = list(object({
    name                   = string
    instance_type          = string
    disk_size              = number
    max_instance_count     = number
    min_instance_count     = number
    desired_instance_count = number
  }))
}

variable "node_group_subnet_type" {
  type = string
}

variable "whitelist_public_cidrs" {
  type    = list(string)
  default = []
}

variable "service_role_definitions" {
  type = map(object({
    service_account_names = set(string)
    policy_arns           = set(string)
  }))
}