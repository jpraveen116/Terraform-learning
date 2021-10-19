provider "aws" {
  region = "ap-south-1"

}


variable "subnet_cidr_block" {
  description = "Subnet cidr block"
}
variable "vpc_cidr_block" {
  description = "VPC cidr block"
}

variable "environment" {
  description = "VPC cidr block"
}

variable "avail_zone" {}
variable "env_prefix" {}
variable "my-ip" {}

variable "instance_type" {}



resource "aws_vpc" "development-vpc" {

  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "development",

  }

}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "subnet-1-dev"
  }
}




/* 
resource "aws_internet_gateway" "my-app-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    "Name" = "${var.env_prefix}-igw"
  }

}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-app-igw.id
  }
  tags = {
    "Name" = "${var.env_prefix}-main-rtb"
  }

}

resource "aws_default_security_group" "default-sg" {

  vpc_id = aws_vpc.myapp-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my-ip]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    "Name" = "${var.env_prefix}-default-sg"
  }

}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

output "aws_ami" {
  value = data.aws_ami.latest-amazon-linux-image.id

}


resource "aws_instance" "my-app-server" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.my-app-subnet-1.id

  availability_zone           = var.avail_zone
  associate_public_ip_address = true
  key_name                    = "aws2"

  tags = {
    "Name" = "${var.env_prefix}-server"
  }
} */
