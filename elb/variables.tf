variable "environment" {
  description = "Deployment environment (e.g., prod, dev)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnet" {
  type = string
}
variable "public_subnet2" {
  type = string
}
variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}
variable "security_groups" {
  type = string
}