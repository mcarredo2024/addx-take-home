module "alb_ingress_controller" {
  source       = "terraform-aws-modules/alb-ingress-controller/aws"
  cluster_name = var.cluster_name
}

output "alb_dns" {
  value = module.alb_ingress_controller.alb_dns_name
}
