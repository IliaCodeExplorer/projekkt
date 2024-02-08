output "s3_bucket_name" {
  value       = aws_s3_bucket.my_bucket.bucket
  description = "The name of the S3 bucket"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.my_bucket.arn
  description = "The ARN of the S3 bucket"
}

output "s3_bucket_url" {
  value       = "https://${aws_s3_bucket.my_bucket.bucket}.s3.amazonaws.com/"
  description = "The URL of the S3 bucket"
}
