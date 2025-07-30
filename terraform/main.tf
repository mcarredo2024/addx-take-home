module "vpc" {
  source  = "./modules/vpc"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                      = "nodejs-eks"
  kubernetes_version        = "1.29"
  enable_irsa               = true
  endpoint_public_access    = true
  enable_cluster_creator_admin_permissions = true

  vpc_id   = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
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
