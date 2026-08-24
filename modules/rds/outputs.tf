#########################################################
# Amazon RDS Outputs
#########################################################

output "db_instance_id" {

  description = "Amazon RDS Instance ID"

  value = aws_db_instance.this.id

}

output "db_instance_arn" {

  description = "Amazon RDS Instance ARN"

  value = aws_db_instance.this.arn

}

output "db_endpoint" {

  description = "Amazon RDS Endpoint"

  value = aws_db_instance.this.endpoint

}

output "db_port" {

  description = "Database Port"

  value = aws_db_instance.this.port

}

output "db_name" {

  description = "Database Name"

  value = aws_db_instance.this.db_name

}

