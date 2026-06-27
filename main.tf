terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "syncer" {
  source = "./syncer"

  for_each = {
    for s in var.sites : s.github_repository_name => s
  }

  github_user_name       = each.value.github_user_name
  github_repository_name = each.value.github_repository_name
  bucket_name            = each.value.bucket_name
}