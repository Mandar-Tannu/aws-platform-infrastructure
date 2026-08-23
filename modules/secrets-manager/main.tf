#########################################################
# Random Database Password
#########################################################

resource "random_password" "database_password" {

  length = 24

  special = true

  override_special = "!#$%&*()-_=+[]{}<>?"

}

#########################################################
# Secrets Manager Secret
#########################################################

resource "aws_secretsmanager_secret" "database_secret" {

  name = var.secret_name

  description = "PostgreSQL database credentials"

  recovery_window_in_days = 7

  tags = merge(

    var.common_tags,

    {

      Name = var.secret_name

    }

  )

}

#########################################################
# Secret Version
#########################################################

resource "aws_secretsmanager_secret_version" "database_secret" {

  secret_id = aws_secretsmanager_secret.database_secret.id

  secret_string = jsonencode({

    username = var.db_username

    password = random_password.database_password.result

    database = var.db_name

  })

}

