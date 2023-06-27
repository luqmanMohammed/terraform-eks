variable "iam_openid_connect_url" {
  type = string
}

variable "iam_openid_connect_provider_arn" {
  type = string
}

variable "role_definitions" {
  type = map(object({
    service_account_names = set(string)
    policy_arns           = set(string)
  }))
}