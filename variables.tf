variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

variable "region" {
  type = string
}

variable "github_user_name" {
  type = string
}

variable "sites" {
  description = "Deploy targets (GitHub repository + S3 bucket)"
  type = list(object({
    github_repository_name = string
    bucket_name            = string
  }))
}