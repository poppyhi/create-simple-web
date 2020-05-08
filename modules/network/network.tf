# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "takahashi-vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

# InternetGateway
resource "aws_internet_gateway" "takahashi-igw" {
  vpc_id = aws_vpc.vpc.id
}

# Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "takahashi-public-subnet"
  }
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}

# RouteTable
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.takahashi-igw.id
  }
  tags = {
    Name = "takahashi-public-route"
  }
}

# SubnetRouteTableAssociation
resource "aws_route_table_association" "takahashi-public-Association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route.id
}

# end point s3
resource "aws_vpc_endpoint" "s3-public" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
    tags = {
    Name = "takahashi-s3-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3-public" {
  vpc_endpoint_id = aws_vpc_endpoint.s3-public.id
  route_table_id  = aws_route_table.public-route.id
}