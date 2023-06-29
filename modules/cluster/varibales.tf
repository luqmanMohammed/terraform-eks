variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "control_plane_subnet_ids" {
  type    = set(string)
  default = []
}

variable "control_plane_subnet_name_selectors" {
  type    = set(string)
  default = []
}

variable "node_group_subnet_ids" {
  type    = set(string)
  default = []
}

variable "node_group_subnet_name_selectors" {
  type    = set(string)
  default = []
}

variable "whitelist_public_cidrs" {
  type    = set(string)
  default = []
}

variable "whitelist_caller_public_ip" {
  type    = bool
  default = true
}

variable "enable_serviceroles" {
  type    = bool
  default = true
}

variable "logging_config" {
  type = object({
    api               = bool
    audit             = bool
    authenticator     = bool
    controllerManager = bool
    scheduler         = bool
  })

  default = {
    api               = true
    audit             = true
    authenticator     = true
    controllerManager = false
    scheduler         = false
  }
}

variable "log_group_retention_period" {
  type    = number
  default = 7
}

variable "enable_secret_encryption" {
  type    = bool
  default = true
}

variable "secret_encryption_kms_key_arn" {
  type    = string
  default = ""
}

variable "control_plane_security_groups" {
  type    = list(string)
  default = []
}

variable "kubernetes_version" {
  type    = string
  default = "1.27"
}

variable "node_groups" {
  type = list(object({
    name                       = string
    desired_instance_count     = number
    max_instance_count         = number
    min_instance_count         = number
    capacity_type              = optional(string, "ON_DEMAND")
    disk_size                  = optional(number, 30)
    instance_type              = optional(string, "t2.medium")
    os                         = optional(string, "amazon-linux-2")
    max_unavailable_percentage = optional(number, 50)
  }))
}

variable "secret_encryption_key_deletion_window" {
  type    = number
  default = 7
}