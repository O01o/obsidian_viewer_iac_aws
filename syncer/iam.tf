data "http" "github_actions_openid_configuration" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

data "tls_certificate" "github_actions" {
  url = jsondecode(data.http.github_actions_openid_configuration.response_body).jwks_uri
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.github_actions.certificates[*].sha1_fingerprint
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-s3-deploy-role"

  assume_role_policy = templatefile("./syncer/iam_role_github_actions.json", {
    github_actions_arn = aws_iam_openid_connect_provider.github_actions.arn,
    github_user_name = var.github_user_name,
    github_repository_name = var.github_repository_name,
  })
}

resource "aws_iam_role_policy" "s3_deploy" {
  name = "s3-deploy-policy"
  role = aws_iam_role.github_actions.id

  policy = templatefile("./syncer/iam_role_s3.json", {
    bucket_name = var.bucket_name
  })
}