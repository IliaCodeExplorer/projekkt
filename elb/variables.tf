variable "environment" {
  description = "Deployment environment (e.g., prod, dev)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnets_ids" {
  description = "List of IDs of public subnets for the ALB"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}
