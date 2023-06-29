variable "cluster_name" {
  type = string
}

variable "control_plane_subnets" {
  type = list(string)
}

variable "control_plane_security_groups" {
  type    = list(string)
  default = []
}

variable "cluster_role" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.27"
}

variable "enable_public_access" {
  type    = bool
  default = false
}

variable "public_access_cidrs" {
  type    = list(string)
  default = []
}

variable "enable_iam_roles_for_service_account" {
  type    = bool
  default = true
}

variable "log_group_retention_period" {
  type    = number
  default = 0
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

variable "encryption_kms_key_arn" {
  type    = string
  default = ""
}