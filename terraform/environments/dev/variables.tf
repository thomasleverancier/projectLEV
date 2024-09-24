variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "The availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "projectlev-repo"
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "projectlev-cluster"
}

variable "eks_instance_types" {
  description = "The instance types to use for the EKS nodes"
  type        = list(string)
  default     = ["t2.micro"]
}

variable "eks_desired_size" {
  description = "The desired number of nodes in the EKS cluster"
  type        = number
  default     = 2
}

variable "eks_max_size" {
  description = "The maximum number of nodes in the EKS cluster"
  type        = number
  default     = 3
}

variable "eks_min_size" {
  description = "The minimum number of nodes in the EKS cluster"
  type        = number
  default     = 1
}
