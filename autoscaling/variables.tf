variable "environment" {
  description = "Deployment environment (e.g., prod, dev)"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "The minimum size of the auto scaling group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the auto scaling group"
  type        = number
}

variable "desired_capacity" {
  description = "The desired capacity of the auto scaling group"
  type        = number
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the launch template"
  type        = list(string)
}

# variable "vpc_zone_identifier" {
#   description = "A list of subnet IDs to place the instances in"
#   type        = string
# }

variable "target_group_arn" {
  description = "The ARN of the target group with which to register instances"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}

variable "user_data" {
  description = "The user data to provide when launching the instances"
  type        = string
  default     = ""
}
variable "private_subnet" {
type = string
}