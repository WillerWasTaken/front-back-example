provider "aws" {
  profile = "default"
  region  = "eu-west-3"
  version = "~> 2.41"
}

data "aws_vpc" "vpc" {
  default = true
}

data "aws_security_group" "default_sg" {
  name   = "default"
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_key_pair" "app_key" {
  key_name   = "app_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

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
  instance_type = "t2.micro"
  key_name      = aws_key_pair.app_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, data.aws_security_group.default_sg.id]
}
