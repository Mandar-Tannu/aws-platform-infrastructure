#########################################################
# Database Configuration
#########################################################

variable "db_username" {

  description = "Database Username"

  type = string

  default = "postgres"

}

variable "db_name" {

  description = "Database Name"

  type = string

}

variable "secret_name" {

  description = "AWS Secrets Manager secret name"

  type = string

}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {

  description = "Common Tags"

  type = map(string)

}

