locals {
  create_kms_key = var.enable_secret_encryption && var.secret_encryption_kms_key_arn == ""
}

resource "aws_kms_key" "secret_encryption_key" {
  count       = local.create_kms_key ? 1 : 0
  description = "Key used to ecrypt secrets on ${var.cluster_name} EKS cluster"
}
