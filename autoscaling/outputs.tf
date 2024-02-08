output "launch_template_id" {
  value       = aws_launch_template.app_lt.id
  description = "The ID of the launch template used by the auto scaling group."
}

output "autoscaling_group_name" {
  value       = aws_autoscaling_group.app_asg.name
  description = "The name of the auto scaling group."
}
