terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "addx-terraform-state-bucket"
    key            = "addx-take-home/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "addx-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
