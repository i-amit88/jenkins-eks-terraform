# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "5.43.0"
#     }
#   }
# }

# provider "aws" {
#   region = "us-west-1"
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.vpc_public_subnet

  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name = "jenkins-subnet"
  }

  igw_tags = {
    Name = "jenkins igw"
  }

}