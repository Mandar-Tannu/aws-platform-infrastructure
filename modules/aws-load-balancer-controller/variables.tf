variable "cluster_name" {

  description = "EKS cluster name"

  type = string

}

variable "region" {

  description = "AWS region"

  type = string

}

variable "vpc_id" {

  description = "EKS VPC ID"

  type = string

}

variable "helm_chart_version" {

  description = "AWS Load Balancer Controller Helm chart version"

  type = string

}

variable "common_tags" {

  description = "Common resource tags"

  type = map(string)

  default = {}

}

