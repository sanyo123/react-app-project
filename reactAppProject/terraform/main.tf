provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  # Define VPC settings here
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "react-app-eks-cluster"
  cluster_version = "1.28"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  # Create Fargate profiles for different environments
  fargate_profile_development = {
    name = "development-profile"
    selectors = [
      {
        namespace = "development"
      }
    ]
  }

  fargate_profile_production = {
    name = "production-profile"
    selectors = [
      {
        namespace = "production"
      }
    ]
  }
}

# Define IAM policies, security groups, and other networking configurations here.