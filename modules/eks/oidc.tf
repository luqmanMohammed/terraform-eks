data "tls_certificate" "cluster_oidc_endpoint" {
  count = var.enable_iam_roles_for_service_account ? 1 : 0
  url   = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "cluster_oidc_provider" {
  count           = var.enable_iam_roles_for_service_account ? 1 : 0
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.cluster_oidc_endpoint[0].certificates[*].sha1_fingerprint
  url             = data.tls_certificate.cluster_oidc_endpoint[0].url
}