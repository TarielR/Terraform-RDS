resource "aws_vpc" "rds" {
  cidr_block           = var.common_cidr_block
  enable_dns_hostnames = false
//  enable_dns_support   = true
  tags                 = var.common_tags
}

resource "aws_internet_gateway" "rds_igw" {
  vpc_id = aws_vpc.rds.id

  tags = {
    Name = "RDS GW"
  }
}

//resource "aws_default_route_table" "bank_rt" {
//  default_route_table_id = aws_vpc.bank.default_route_table_id
//
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.bank_igw.id
//  }
//
//  tags = {
//    Name = "Bank RT"
//  }
//}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.rds.id

  route = []

  tags = {
    Name = "RDS private RouteT"
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_route_table.private_rt]
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_route_table.private_rt]
}

//resource "aws_subnet" "public" {
//  cidr_block              = var.public_cidr_block
//  vpc_id                  = aws_vpc.bank.id
//  map_public_ip_on_launch = true
//  tags = {
//    Name = "Bank Public"
//  }
//}

resource "aws_subnet" "private1" {
  cidr_block = var.private_cidr_block
  vpc_id     = aws_vpc.rds.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "RDS Private1"
  }
}

resource "aws_subnet" "private2" {
  cidr_block = var.public_cidr_block
  vpc_id     = aws_vpc.rds.id
  availability_zone = "us-east-1c"
  tags = {
    Name = "RDS Private2"
  }
}

resource "aws_security_group" "rds_sg" {
  name = "HTTP_SSL_ICMP"

  vpc_id = aws_vpc.rds.id

  dynamic "ingress" {
    for_each = ["80", "22", "5432"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  ingress {
    description = "ICMP - IPv4 from Internet"
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "RDS HTTP-SSL_ICMP"
  }
}

######################################
variable "common_cidr_block" {}

variable "common_tags" {}

variable "private_cidr_block" {}

variable "public_cidr_block" {}

#####################################################
output "vpc_id" {
  value = aws_vpc.rds.id
}

output "vpc_name" {
  value = aws_vpc.rds.tags
}

output "igw_id" {
  value = aws_internet_gateway.rds_igw.id
}

output "vpc_default_rt" {
  value = aws_vpc.rds.default_route_table_id
}

output "vpc_private_rt" {
  value = aws_vpc.rds.main_route_table_id
}

output "vpc_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "vpc_sg_name" {
  value = aws_security_group.rds_sg.name
}

output "subnet_az1" {
  value = aws_subnet.private1.availability_zone
}

output "subnet_az2" {
  value = aws_subnet.private2.availability_zone
}

output "vpc_subnet1" {
  value = aws_subnet.private1.id
}

output "vpc_subnet2" {
  value = aws_subnet.private2.id
}

