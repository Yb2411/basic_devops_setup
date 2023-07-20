resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "first_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.first_subnet_cidr_block
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "second_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.second_subnet_cidr_block
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.first_subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.second_subnet.id
  route_table_id = aws_route_table.route_table.id
}