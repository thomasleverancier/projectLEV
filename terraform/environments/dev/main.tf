# Определяем провайдера AWS
provider "aws" {
  region = var.aws_region
}

# Модуль для создания сетевой инфраструктуры
module "networking" {
  source = "../../modules/networking"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# Модуль для создания ECR репозитория
module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.ecr_repository_name
}

# Модуль для создания EKS кластера
module "eks" {
  source = "../../modules/eks"

  cluster_name    = var.eks_cluster_name
  subnet_ids      = module.networking.private_subnet_ids
  instance_types  = var.eks_instance_types
  desired_size    = var.eks_desired_size
  max_size        = var.eks_max_size
  min_size        = var.eks_min_size
}

# Настройка бэкенда Terraform для хранения state файла в S3
terraform {
  backend "s3" {
    bucket = "projectlev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"  # Убедитесь, что это соответствует вашему региону
  }
}
