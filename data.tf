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

#SG
module "jenkins-security-group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "jenkins-server"
  vpc_id      = module.vpc.vpc_id


  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Jenkins-server"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name = "jenkins-sg" 
  }
}
