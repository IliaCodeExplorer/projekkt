variable "vpc_id" {
  description = "The VPC ID where the security groups will be created"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
  default     = {}
}
