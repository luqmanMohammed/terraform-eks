variable "node_groups" {
  type = list(object({
    name       = string
    role_arn   = string
    subnet_ids = list(string)
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
    capacity_type  = string
    disk_size      = number
    instance_types = list(string)
  }))
}

variable "cluster_name" {
  type = string
}

variable "os" {
  type    = string
  default = "amazon-linux-2"
}