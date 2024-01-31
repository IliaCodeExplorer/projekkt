
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