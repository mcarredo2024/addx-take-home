variable "vpc_id" {
  type = string
}
variable "subnets" {
  type = list(string)
}
variable "db_user" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}
