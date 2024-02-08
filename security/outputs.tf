output "web_sg_id" {
  description = "The ID of the security group for web servers"
  value       = aws_security_group.web_sg.id
}
# output "app_sg_id" {
#   value = aws_security_group.app_sg.id
# }
