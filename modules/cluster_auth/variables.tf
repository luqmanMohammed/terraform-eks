variable "auth_config_map_roles" {
  type = list(object({
    groups   = set(list)
    rolearn  = string
    username = optional(string, "{{SessionName}}")
  }))
}

variable "auth_config_map_users" {
  type = list(object({
    groups   = set(list)
    rolearn  = string
    username = optional(string, "{{SessionName}}")
  }))
}

variable "cluster_name" {
  type = string
}