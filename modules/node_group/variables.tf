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
    capacity_type              = optional(string, "ON_DEMAND")
    disk_size                  = optional(number, 30)
    instance_types             = optional(list(string), ["t2.medium"])
    os                         = optional(string, "amazon-linux-2")
    max_unavailable_percentage = optional(number, 50)
  }))
}

variable "cluster_name" {
  type = string
}
