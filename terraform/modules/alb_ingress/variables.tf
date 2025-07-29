variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "eks_node_private_ips" {
  description = "Private IPs of EKS nodes"
  type        = list(string)
}
