terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Create a VPC
module "vpc" {
  source       = "./aws_vpc/"
  cidr_network = "192.168.0.0/16"
}

# Create a Public Subnet
module "subnet" {
  source     = "./aws_subnet/"
  cidr_block = "192.168.0.0/24"
  vpc_id     = module.vpc.vpc_id
  is_public  = true
  az         = "ap-south-1a"
}

module "keypair" {
  source   = "./aws_keypair/"
  key_name = "terra_gen_key-bo-05"
}

module "compute" {
  source    = "./aws_ec2"
  subnet_id = module.subnet.subnet_id
  az        = module.subnet.az
  key_pair  = module.keypair.name
}
