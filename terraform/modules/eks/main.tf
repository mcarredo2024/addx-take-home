module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.2" # Stable version with node_groups support

  cluster_name    = "nodejs-eks"
  cluster_version = "1.29"
  subnets         = var.subnets
  vpc_id          = var.vpc_id

  enable_irsa = true

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      subnets          = var.subnets
    }
  }
}
