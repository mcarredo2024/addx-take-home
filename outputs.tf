output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "alb_dns" {
  value = module.alb_ingress.alb_dns
}
