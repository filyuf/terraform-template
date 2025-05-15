# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true

  tags = {
    Name = "main-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public_1a" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = "10.0.1.0/24"
  availability_zone               = "us-east-1a"
  map_public_ip_on_launch        = true
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "public_1b" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = "10.0.2.0/24"
  availability_zone               = "us-east-1b"
  map_public_ip_on_launch        = true
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)

  tags = {
    Name = "public-subnet-1b"
  }
}

# Private Subnets
resource "aws_subnet" "private_1a" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = "10.0.3.0/24"
  availability_zone               = "us-east-1a"
  map_public_ip_on_launch        = false
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 3)

  tags = {
    Name = "private-subnet-1a"
  }
}

resource "aws_subnet" "private_1b" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = "10.0.4.0/24"
  availability_zone               = "us-east-1b"
  map_public_ip_on_launch        = false
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 4)

  tags = {
    Name = "private-subnet-1b"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1a.id

  tags = {
    Name = "nat-gateway"
  }
}

# Egress-Only IGW for IPv6
resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "egress-only-igw"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_egress_only_internet_gateway.eigw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_1b" {
  subnet_id      = aws_subnet.private_1b.id
  route_table_id = aws_route_table.private.id
}
