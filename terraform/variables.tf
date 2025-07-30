variable "aws_region" {
  default = "us-east-1"
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
