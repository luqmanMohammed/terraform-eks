data "aws_iam_policy_document" "this" {
  for_each = var.role_definitions
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.iam_openid_connect_url, "https://", "")}:sub"
      values   = [ for sa_name in each.value.service_account_names: "system:serviceaccount:${sa_name}" ]
    }

    principals {
      identifiers = [var.iam_openid_connect_provider_arn]
      type        = "Federated"
    }
  }
}

locals {
  _role_attachments = flatten([
    for role_name, role_def in var.role_definitions : [
      for attachment in role_def.policy_arns : {
        role_name  = role_name
        attachment = attachment
      }
    ]
  ])
  role_to_attachments = {
    for ra in local._role_attachments : "${ra.role_name}-${ra.attachment}" => ra
  }
}

resource "aws_iam_role" "this" {
  for_each           = var.role_definitions
  assume_role_policy = data.aws_iam_policy_document.this[each.key].json
  name               = each.key
}


resource "aws_iam_role_policy_attachment" "input_policy" {
  for_each   = local.role_to_attachments
  policy_arn = each.value.attachment
  role       = aws_iam_role.this[each.value.role_name].name
}
