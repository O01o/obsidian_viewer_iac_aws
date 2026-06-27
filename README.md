# obsidian_viewer_iac_aws

## 概要

GitHub 上で管理されている Obsidian Vault を Web ページ上で閲覧させる場合、HTML 変換して S3+CloudFront にデプロイするアプローチが有効です。  
Obsidian Vault を管理しているリポジトリの GitHub Actions から S3 デプロイする際の AWS 環境を、当リポジトリで構築することができます。  

## 必要環境

AWS 環境および Terraform のインストールを事前に行ってください。  
プロジェクト直下に `terraform.tfvars` を作成し、以下の必要な環境変数を設定してください。  
対応する `github_repository_name` (Obsidian Vault のリポジトリ) と `bucket_name` は、新規追加する度にリストに加えてください。  

- aws_access_key
- aws_secret_key
- region
- github_user_name
- sites (list)
    - github_repository_name
    - bucket_name


## 実行手順

プロジェクト直下で以下のコマンドを実行してください。

```shell
terraform init
terraform plan
terraform apply
```

実行完了後、指定の AWS 環境からリソースが構築済であることを確認してください。
