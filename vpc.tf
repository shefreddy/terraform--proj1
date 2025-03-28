# VPC Resource
resource "aws_vpc" "main_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main_vpc"
  }
}

# Subnets in Different Availability Zones
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet 1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet 2"
  }
}

# Update the Subnets Data Source
data "aws_subnets" "main_subnet" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main_vpc.id]
  }

  depends_on = [aws_subnet.subnet_1, aws_subnet.subnet_2]
}