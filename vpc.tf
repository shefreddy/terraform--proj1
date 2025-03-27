#vpc module
resource "aws_vpc" "main_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main_vpc"
  }
}

data "aws_vpc" "main_vpc" {
  filter {
    name   = "tag:Name"
    values = ["main_vpc"]  # This should match the Name tag in your VPC resource
  }
}

#subnet
resource "aws_subnet" "main_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "Main subnet"
    }
}

data "aws_subnets" "main_subnet" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main_vpc.id]
  }
}