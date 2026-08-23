#########################################################
# Project Configuration
#########################################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################################
# Amazon EKS Cluster
#########################################################

variable "cluster_name" {
  description = "Amazon EKS Cluster Name"
  type        = string
}

#########################################################
# Amazon EKS Node IAM Role
#########################################################

variable "node_role_arn" {
  description = "Amazon EKS Node IAM Role ARN"
  type        = string
}

#########################################################
# Networking
#########################################################

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

#########################################################
# Node Group Configuration
#########################################################

variable "instance_types" {
  description = "Worker node instance types"
  type        = list(string)

  default = [
    "c7i-flex.large"
  ]
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 3
}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}

