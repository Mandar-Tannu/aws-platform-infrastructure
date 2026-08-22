variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "vpc_id" {
  description = "Default VPC ID"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

