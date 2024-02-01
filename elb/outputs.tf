output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.app_alb.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the Target Group for the ALB"
  value       = aws_lb_target_group.app_tg.arn
}

output "listener_arn" {
  description = "The ARN of the Listener for the ALB"
  value       = aws_lb_listener.app_listener.arn
}
