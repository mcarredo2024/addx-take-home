terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "addx-take-home/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
