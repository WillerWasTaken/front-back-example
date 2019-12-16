variable "ssh_public_key" {
  type = string
}

provider "aws" {
  profile = "default"
  region  = "eu-west-3"
  version = "~> 2.41"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "app_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "app"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

data "aws_security_group" "default_sg" {
  name   = "default"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_key_pair" "app_key" {
  key_name   = "app_key"
  public_key = var.ssh_public_key
}

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami           = "ami-087855b6c8b59a9e4"
  subnet_id     = aws_subnet.app_subnet.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.app_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id, data.aws_security_group.default_sg.id]
}
