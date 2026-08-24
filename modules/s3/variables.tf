#########################################################
# Project Configuration
#########################################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################################
# Bucket Configuration
#########################################################

variable "bucket_name" {
  description = "Amazon S3 Bucket Name"
  type        = string
}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}

