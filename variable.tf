variable "aws_region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
