
variable "vpcname" {
  type        = string
  default     = "Project VPC"
  description = "description"
}
variable "environment" {
  description = "Deployment environment for dev"
  type        = string
  default     = "dev"
}
variable "region" {
  type    = string
  default = "us-east-2"
}
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources in the VPC"
  type        = map(string)
}
