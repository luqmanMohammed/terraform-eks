output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "cluster_arn" {
  value = aws_eks_cluster.this.role_arn
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.this.certificate_authority
}

output "iam_openid_connect_provider_url" {
  value = aws_iam_openid_connect_provider.cluster_oidc_provider[0].url
}

output "iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.cluster_oidc_provider[0].arn
}

output "cluster_auth_token" {
  sensitive = true
  value     = data.aws_eks_cluster_auth.this.token
}