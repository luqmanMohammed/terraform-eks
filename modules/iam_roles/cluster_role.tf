resource "aws_iam_role" "cluster_role" {
  name               = var.cluster_role_name
  assume_role_policy = file("${path.module}/assume_role_policies/cluster.json")
}

resource "aws_iam_role_policy_attachment" "cluster_role" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
