#########################################################
# Project Configuration
#########################################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################################
# Amazon EKS IAM Role
#########################################################

variable "cluster_role_arn" {
  description = "Amazon EKS Cluster IAM Role ARN"
  type        = string
}

#########################################################
# Networking
#########################################################

variable "subnet_ids" {
  description = "Default Public Subnet IDs"
  type        = list(string)
}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

