output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_oidc_provider_arn" {
  value = module.eks.iam_openid_connect_provider_arn
}

output "cluster_oidc_endpoint" {
  value = module.eks.iam_openid_connect_provider_url
}

output "cluster_ca" {
  value = module.eks.cluster_ca
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_auth_token" {
  sensitive = true
  value     = module.eks.cluster_auth_token
}