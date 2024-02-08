resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = merge(local.tags, { Name = "${local.name_prefix}-vpc" })

}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = merge(local.tags, { Name = "${local.name_prefix}-public-subnet" })

}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.region}b"

  tags = merge(local.tags, { Name = "${local.name_prefix}-public-subnet2" })

}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = merge(local.tags, { Name = "${local.name_prefix}-private-subnet" })

}
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = merge(local.tags, { Name = "${local.name_prefix}-private-subnet2" })

}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = merge(local.tags, { Name = "${local.name_prefix}-gw" })
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(local.tags, { Name = "${local.name_prefix}-rt" })
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_eip" "nat_gateway" {
  #vpc = true
  domain = "vpc"
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = merge(local.tags, { Name = "${local.name_prefix}-nat" })

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = merge(local.tags, { Name = "${local.name_prefix}-rt-nat" })
}

resource "aws_route_table_association" "nat-rt" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.nat.id
}