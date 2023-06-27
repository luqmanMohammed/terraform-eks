output "node_group_arns" {
  value = { for k, v in aws_eks_node_group.this : k => v.arn }
}