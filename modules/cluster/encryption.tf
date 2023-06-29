locals {
  create_kms_key = var.enable_secret_encryption && var.secret_encryption_kms_key_arn == ""
}

resource "aws_kms_key" "secret_encryption_key" {
  count                   = local.create_kms_key ? 1 : 0
  description             = "Key used to ecrypt secrets on ${var.cluster_name} EKS cluster"
  deletion_window_in_days = var.secret_encryption_key_deletion_window
}

resource "aws_kms_alias" "secret_encryption_key_alias" {
  count         = local.create_kms_key ? 1 : 0
  target_key_id = aws_kms_key.secret_encryption_key[0].id
  name          = "alias/eks/${var.cluster_name}"
}