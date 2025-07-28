resource "aws_ecr_repository" "nodejs_api" {
  name                 = "nodejs-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "repository_url" {
  value = aws_ecr_repository.nodejs_api.repository_url
}
