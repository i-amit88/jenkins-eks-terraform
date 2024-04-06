#VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "eks-vpc"
  cidr = var.vpc_cidr
                             
                             
  azs            = data.aws_availability_zones.azs.names
  private_subnets = var.vpc_private_subnet
  public_subnets = var.vpc_public_subnet

  enable_nat_gateway = true
  enable_dns_hostnames = true
  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }


}

#EKS

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-esk-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true


  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.micro"]
      
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
