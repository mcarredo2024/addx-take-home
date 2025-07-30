module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                      = var.cluster_name
  kubernetes_version        = var.kubernetes_version
  enable_irsa               = true
  endpoint_public_access    = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  compute_config = {
    enabled    = true
    node_pools = var.node_pools
  }
}
