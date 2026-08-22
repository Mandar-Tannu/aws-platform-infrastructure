output "repository_name" {
  description = "Amazon ECR Repository Name"
  value       = aws_ecr_repository.repository.name
}

output "repository_uri" {
  description = "Amazon ECR Repository URI"
  value       = aws_ecr_repository.repository.repository_url
}

output "repository_arn" {
  description = "Amazon ECR Repository ARN"
  value       = aws_ecr_repository.repository.arn
}

