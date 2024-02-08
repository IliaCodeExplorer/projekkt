data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_instance" "app_server" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = var.private_subnet_id

 key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

   tags = {
    Name = "App Server ${count.index +1}"
  }
}
resource "aws_security_group" "app_sg" {
  name        = "app-server-sg"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id


  tags = {
    Name = "app-server-security-group"
  }
}
