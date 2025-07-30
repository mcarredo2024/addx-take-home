variable "vpc_id" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "db_user" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}
