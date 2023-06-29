module "iam_roles" {
  source               = "../iam_roles"
  cluster_role_name    = "${var.cluster_name}-cluster-role"
  node_group_role_name = "${var.cluster_name}-nodegroup-role"
}