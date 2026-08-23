#########################################################
# Project Configuration
#########################################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################################
# Amazon ECR
#########################################################

variable "ecr_repository_arn" {
  description = "Amazon ECR Repository ARN"
  type        = string
}

#########################################################
# Amazon EKS
#########################################################

variable "eks_cluster_arn" {
  description = "Amazon EKS Cluster ARN"
  type        = string
}

#########################################################
# AWS Region
#########################################################

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}

