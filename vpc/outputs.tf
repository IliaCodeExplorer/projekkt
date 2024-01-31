output "vpc_id" {
  value       = aws_vpc.my-vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "The ID of the public subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.private_subnet.id
  description = "The ID of the private subnet"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gw.id
  description = "The ID of the Internet Gateway"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat.id
  description = "The ID of the NAT Gateway"
}
output "subnet_ids" {
  value = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
  description = "List of subnet IDs"
}
