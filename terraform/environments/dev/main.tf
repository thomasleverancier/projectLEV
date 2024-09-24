provider "aws" {
  region = var.aws_region
}


module "networking" {
  source = "../../modules/networking"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.ecr_repository_name
}

module "eks" {
  source = "../../modules/eks"

  cluster_name   = var.eks_cluster_name
  subnet_ids     = module.networking.private_subnet_ids
  instance_types = var.eks_instance_types
  desired_size   = var.eks_desired_size
  max_size       = var.eks_max_size
  min_size       = var.eks_min_size
}


terraform {
  backend "s3" {
    bucket = "projectlev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
