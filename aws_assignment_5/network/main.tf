# VPC
resource "aws_vpc" "tem_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = var.vpc_name
  }
}

# Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnet_names)
  vpc_id = aws_vpc.tem_vpc.id
  cidr_block = var.pub_cidr[count.index]
  availability_zone = "us-east-2${element(["a", "c"], count.index % 2)}"
  tags = {
    Name = var.public_subnet_names[count.index]
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_names)
  vpc_id = aws_vpc.tem_vpc.id
  cidr_block = var.pv_cidr[count.index]
  availability_zone = "us-east-2${element(["a", "c"], count.index % 2)}"

  tags = {
    Name = var.private_subnet_names[count.index]
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tem_vpc.id
  tags = {
    Name = var.igw_name
  }
}



# NAT Gateway

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id
  tags ={
    Name = var.nat_name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tem_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = {
    Name = var.public_route_table_names
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.tem_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = {
    Name = var.private_route_table_names
  }
}

#aws_route_table_association
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_names)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_names)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

resource "aws_vpc" "vpc_us_east_1" {
  # Configuration for VPC in us-east-2
  cidr_block = "10.100.2.0/16"
  # Other VPC configurations go here
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  auto_accept = true
  peer_region = "us-east-1"

  # VPC IDs for the two VPCs involved in peering
  vpc_id        = aws_vpc.vpc_us_east_2.id
  peer_vpc_id   = aws_vpc.vpc_us_east_1.id

  # Other peering connection configurations go here
}
