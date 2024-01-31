variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC where the Bastion Host will be created"
  type        = string
  default = "10.100.0.0/24"
}
