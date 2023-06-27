module "service_role" {
  source                          = "../service_role"
  role_definitions                = var.role_definitions
  iam_openid_connect_provider_arn = module.eks.iam_openid_connect_provider_arn
  iam_openid_connect_url          = module.eks.iam_openid_connect_provider_url
}