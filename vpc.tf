
resource "aws_vpc" "my-vpc" {
  cidr_block           = var.cidr_block
  tags                 = var.tags
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id
  tags   = var.tags
}

# resource "aws_subnet" "private-subnet" {
#   vpc_id                  = aws_vpc.my-vpc.id
#   cidr_block              = var.subnet_prefix[0].cidr_block
#   availability_zone       = "us-east-2a"
#   map_public_ip_on_launch = false


#   tags = {
#     Name = var.subnet_prefix[0].name
#     Type = var.subnet_prefix[0].type
#   }
# }

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.subnet_prefix[1].cidr_block
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_prefix[1].name
    Type = var.subnet_prefix[1].type
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = var.tags
}


# # 5. Associate subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.route-table.id
}

# # 6. Create Security Group to allow port 22,443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# # 7. Create a network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.public-subnet.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.allow_web.id]
  tags            = var.tags
}

# # 8. Assign an elastic IP to the network interface created in step 7

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.0.50"
  depends_on                = [aws_internet_gateway.gw]
  tags                      = var.tags
}
