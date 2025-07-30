variable "cluster_name" {
  type = string
}
variable "kubernetes_version" {
  type    = string
  default = "1.29"
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "node_pools" {
  type    = list(string)
  default = ["general-purpose"]
}
