provider "aws" {
  region = "us-east-2"
}
data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_security_group" "my_webserver" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Dynamic Security GRoups"
  }
}

resource "aws_launch_configuration" "web" {
  name            = "WebServer-Highly-Available-LC"
  image_id        = data.aws_ami.latest_amazon_linux.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my_webserver.id]
  user_data       = file("user.data.sh")
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "ASG-web" {
  name                 = "WebServer-Highly-Available-ASG"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 3
  min_elb_capacity     = 2
  vpc_zone_identifier  = aws_default_subnet.default-az1[*].id
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.web.name]

  dynamic "tag" {
    for_each = {
      Name   = "ASG-WEB-Serwer"
      Owner  = "Ilyas"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = "Name"
      value               = "WebServer-in-ASG"
      propagate_at_launch = true
    }
  }
}
resource "aws_elb" "web" {
  name               = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.my_webserver.id]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = {
    Name = "WebServer-HA-ELB"
  }
}
resource "aws_default_subnet" "default-az1" {
  count             = length(data.aws_availability_zones.available.names)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

