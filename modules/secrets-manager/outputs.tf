#########################################################
# Secrets Manager Outputs
#########################################################

output "secret_arn" {

  description = "Secret ARN"

  value = aws_secretsmanager_secret.database_secret.arn

}

output "secret_name" {

  description = "Secret Name"

  value = aws_secretsmanager_secret.database_secret.name

}

output "secret_version_id" {

  description = "Secret Version"

  value = aws_secretsmanager_secret_version.database_secret.version_id

}

output "database_password" {

  description = "Generated Database Password"

  value = random_password.database_password.result

  sensitive = true

}

