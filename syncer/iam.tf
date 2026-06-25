data "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-s3-deploy-${var.bucket_name}"

  assume_role_policy = templatefile("./syncer/iam_role_github_actions.json", {
    # dataソースから取得したARNを参照する
    github_actions_arn = data.aws_iam_openid_connect_provider.github_actions.arn,
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