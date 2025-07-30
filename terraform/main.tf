module "vpc" {
  source  = "./modules/vpc"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.2"  # ✅ MUST BE PRESENT
  cluster_name    = "nodejs-eks"
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets

  enable_irsa = true

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      subnets          = module.vpc.private_subnets
    }
  }
}


module "ecr" {
  source = "./modules/ecr"
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.private_subnets
  db_user     = var.db_user
  db_password = var.db_password
}

module "alb_ingress" {
  source       = "./modules/alb_ingress"
  cluster_name = module.eks.cluster_name
  aws_region   = var.aws_region
  vpc_id       = module.vpc.vpc_id
}
