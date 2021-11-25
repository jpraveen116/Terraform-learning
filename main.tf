provider "aws" {
  region = "ap-south-1"

}

terraform {
  backend "s3" {
    bucket = "myapp-bucket116"
    region = "ap-south-1"
    key    = "myapp/state.tfstate"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name           = "my-vpc"
  cidr           = var.vpc_cidr_block
  azs            = [var.avail_zone]
  public_subnets = [var.subnet_cidr_block]
  public_subnet_tags = {
    name = "${var.env_prefix}-subnet-1"
  }

  tags = {
    name = "${var.env_prefix}-vpc"

  }
}



module "myapp-server" {
  source            = "./modules/webserver"
  vpc_id            = module.vpc.vpc_id
  image_name        = var.image_name
  my_ip             = var.my_ip
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnets[0]
  avail_zone        = var.avail_zone
  env_prefix        = var.env_prefix
  public_key        = var.public_key
  subnet_cidr_block = var.subnet_cidr_block
  vpc_cidr_block    = var.vpc_cidr_block
}
