resource "aws_s3_bucket" "host" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }
}