module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source  = "./modules/eks"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
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
