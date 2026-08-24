#########################################################
# Project Configuration
#########################################################

variable "project_name" {

  description = "Project Name"

  type = string

}

variable "database_identifier" {

  description = "Amazon RDS database identifier"

  type = string

}

#########################################################
# Database Configuration
#########################################################

variable "db_name" {

  description = "Database Name"

  type = string

}

variable "engine_version" {

  description = "PostgreSQL Engine Version"

  type = string

  default = "17"

}

variable "instance_class" {

  description = "Amazon RDS Instance Class"

  type = string

  default = "db.t4g.micro"

}

#########################################################
# Storage
#########################################################

variable "allocated_storage" {

  description = "Allocated Storage (GB)"

  type = number

  default = 20

}

#########################################################
# Networking
#########################################################

variable "subnet_ids" {

  description = "Subnet IDs"

  type = list(string)

}

variable "security_group_id" {

  description = "Amazon RDS Security Group"

  type = string

}

#########################################################
# AWS Secrets Manager
#########################################################

variable "database_secret_arn" {

  description = "Secrets Manager Secret ARN"

  type = string

}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {

  description = "Common Tags"

  type = map(string)

}

