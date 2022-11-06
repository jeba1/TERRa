
# creation ofpublic_subnet
data "aws_availability_zones" "web" {
  state = "available"
}
resource "aws_vpc" "vpc_aws" {
  name = var.name
  cidr_block = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
}

# internet gateway for vpc_aws
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_aws.id

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(local.public_subnets)  
  vpc_id     = var.vpc_cidr
  cidr_block = local.public_subnets[count.index]
  availability_zone       = var.azs 
}

# creation for private subnet
resource "aws_subnet" "private_subnet" {
  count = length(local.private_subnets)
  vpc_id     = var.vpc_cidr
  cidr_block = local.private_subnets[count.index]
  availability_zone     = var.azs 
}
#public subnet route aws_route_table

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc_aws.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  } 
}
  

  #private subnet route route_table
  
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc_aws.id

  route {
    cidr_block = "${var.vpc_cidr}"
    gateway_id = aws_internet_gateway.igw.id
  }
} 
resource "aws_route_table_association" "public_route" {
  count           = length(aws_subnet.public_subnet[*].id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_route" {
  count           = length(aws_subnet.private_subnet[*].id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.private_route.id
}


resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  vpc = true
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[count.index].id

  subnet_id = aws_subnet.public_subnet[count.index].id
}

