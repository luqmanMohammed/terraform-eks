resource "aws_cloudwatch_log_group" "cluster_log_group" {
  count             = var.log_group_retention_period > 0 ? 1 : 0
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_group_retention_period
}