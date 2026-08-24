#########################################################
# Project Configuration
#########################################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################################
# Load Balancer
#########################################################

variable "listener_arn" {
  description = "Application Load Balancer Listener ARN"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

#########################################################
# Target Group
#########################################################

variable "target_group_name" {
  description = "Target Group Name"
  type        = string
}

variable "target_type" {
  description = "Target Type"
  type        = string

  default = "instance"
}

variable "target_id" {
  description = "Target Resource ID"
  type        = string
}

variable "port" {
  description = "Backend Port"
  type        = number
}

variable "protocol" {
  description = "Backend Protocol"
  type        = string

  default = "HTTP"
}

#########################################################
# Listener Rule
#########################################################

variable "priority" {
  description = "Listener Rule Priority"
  type        = number
}

variable "path_patterns" {
  description = "Path Patterns"
  type        = list(string)
}

#########################################################
# Health Check
#########################################################

variable "health_check_path" {
  description = "Health Check Path"
  type        = string
}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}

