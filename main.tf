resource "aws_vpc" "main" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    "Name"        = "lab"
    "Environment" = "dev"
  }
}

## Create public and private subnets in aws_vpc
# Public subnets
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public1"
    Environment = "dev"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public2"
    Environment = "dev"
  }
}

# Private subnets
resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "private1"
    Environment = "dev"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "private2"
    Environment = "dev"
  }
}

# RDS Subnet
resource "aws_db_subnet_group" "rds_db_subnet" {
  name       = "rds_db_subnet"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  tags = {
    Name        = "rds_db_subnet_group"
    Environment = "dev"
  }

}

# Create Internet Gateway resource in AWS
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "IntGW"
    Environment = "dev"
  }

}

# Create Route table in AWS
resource "aws_route_table" "web_tier" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "web_tier_rtb"
    Environment = "dev"
  }
}

# Create a route table subnet association in AWS
resource "aws_route_table_association" "web_tier_assoc1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.web_tier.id
}

resource "aws_route_table_association" "web_tier_assoc2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.web_tier.id
}
