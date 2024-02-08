variable "bucket_name" {
  description = "The name of the S3 bucket. Must be unique."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., prod, dev)."
  type        = string
}

variable "bucket_acl" {
  description = "The canned ACL to apply to the S3 bucket. Defaults to 'private'."
  default     = "private"
  type        = string
}
