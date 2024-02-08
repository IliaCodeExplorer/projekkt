resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.bucket_name}-${var.environment}"
  acl    = var.bucket_acl

  tags = {
    Name        = "MyBucket"
    Environment = var.environment
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
