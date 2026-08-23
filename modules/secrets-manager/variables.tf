#########################################################
# Project Configuration
#########################################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################################
# Database Configuration
#########################################################

variable "db_username" {
  description = "Database Username"
  type        = string

  default = "postgres"
}

variable "db_name" {
  description = "Database Name"
  type        = string

  default = "sonarqube"
}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}

