variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC where the Bastion Host will be created"
  type        = string
}
variable "common_tags" {
  description = "Common tags for all resources in the module"
  type = map(string)
}
variable "key_name" {
  description = "The name of the SSH key pair to use for the instances"
  type        = string
}