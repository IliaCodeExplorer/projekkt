variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC where the Bastion Host will be created"
  type        = string
  default     = "10.10.0.0/24"
}
