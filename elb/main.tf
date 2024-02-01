resource "aws_lb" "app_alb" {
  name               = "app-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.alb_sg_id]
  subnets            = module.vpc.public_subnets_ids

  enable_deletion_protection = false

  tags = merge(
    var.common_tags,
    {
      "Name" = "app-alb-${var.environment}"
    }
  )
}
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "app-tg-${var.environment}"
    }
  )
}
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
