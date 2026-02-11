terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "syncer" {
  source = "./syncer"
  github_user_name = var.github_user_name
  github_repository_name = var.github_repository_name
  bucket_name = var.bucket_name
}

