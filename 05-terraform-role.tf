#OIDC provider for GitHub
resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
  # Not available on outposts

  client_id_list = [
    #  element(split("/", aws_eks_cluster.demo_cluster.identity[0].oidc[0].issuer), 4)
    "sts.amazonaws.com"
  ]
  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
  url             = "https://token.actions.githubusercontent.com"

  tags = local.tags
}

#GitHub Role
resource "aws_iam_role" "github_role" {
  name               = "github-actions-role"
  assume_role_policy = data.aws_iam_policy_document.github_assume_policy.json

  tags = local.tags
}

data "aws_iam_policy_document" "github_assume_policy" {
  statement {
    sid = "github"

    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_oidc_provider.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }
    
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:*"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "Github_Role_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.github_role.name
}
