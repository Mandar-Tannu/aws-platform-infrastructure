#########################################################
# Amazon RDS DB Subnet Group
#########################################################

resource "aws_db_subnet_group" "this" {

  name = "${var.database_identifier}-subnet-group"

  description = "DB Subnet Group for Amazon RDS PostgreSQL"

  subnet_ids = var.subnet_ids

  tags = merge(

    var.common_tags,

    {

      Name = "${var.database_identifier}-subnet-group"

    }

  )

}

#########################################################
# PostgreSQL Parameter Group
#########################################################

resource "aws_db_parameter_group" "this" {

  name = "${var.database_identifier}-parameter-group"

  family = "postgres17"

  description = "PostgreSQL Parameter Group"

  tags = merge(

    var.common_tags,

    {

      Name = "${var.database_identifier}-parameter-group"

    }

  )

}

#########################################################
# Read SonarQube Database Secret
#########################################################

data "aws_secretsmanager_secret_version" "database" {

  secret_id = var.database_secret_arn

}

locals {

  database_secret = jsondecode(

    data.aws_secretsmanager_secret_version.database.secret_string

  )

}

#########################################################
# Amazon RDS PostgreSQL
#########################################################

resource "aws_db_instance" "this" {

  identifier = var.database_identifier

  engine = "postgres"

  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  storage_type = "gp3"

  storage_encrypted = true

  db_name = var.db_name

  username = local.database_secret.username

  password = local.database_secret.password

  port = 5432

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 0

  deletion_protection = false

  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.this.name

  parameter_group_name = aws_db_parameter_group.this.name

  vpc_security_group_ids = [

    var.security_group_id

  ]

  tags = merge(

    var.common_tags,

    {

      Name = var.database_identifier

    }

  )

}

