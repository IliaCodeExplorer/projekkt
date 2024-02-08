data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-lt-${var.environment}-"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.private_subnet
    security_groups             = var.security_groups
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install nginx1 -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo 'Welcome back Azim to my small, but complicated Nginx page' | sudo tee /usr/share/nginx/html/index.html
    EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = var.common_tags
  }
}
resource "aws_autoscaling_group" "app_asg" {
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  

  target_group_arns    = [var.target_group_arn]

#   tag = [
#     {
#       key                 = "Name"
#       value               = "app-instance-${var.environment}"
#       propagate_at_launch = true
#     }
#   ]
# }
}


