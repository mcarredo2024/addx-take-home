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

data "aws_instances" "eks_nodes" {
  filter {
    name   = "tag:eks:cluster-name"
    values = [module.eks.cluster_name]
  }
}

module "alb_ingress" {
  source             = "./modules/alb_ingress"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  eks_node_private_ips = data.aws_instances.eks_nodes.private_ips
}
