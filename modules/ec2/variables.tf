#########################################################
# Project Configuration
#########################################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################################
# Amazon Machine Image
#########################################################

variable "ami_id" {
  description = "Ubuntu Server AMI ID"
  type        = string
}

#########################################################
# EC2 Instance Configuration
#########################################################

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string

  default = "c7i-flex.large"
}

#########################################################
# Networking
#########################################################

variable "subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "security_group_ids" {
  description = "Security Groups"
  type        = list(string)
}

#########################################################
# IAM
#########################################################

variable "instance_profile_name" {
  description = "IAM Instance Profile Name"
  type        = string
}

#########################################################
# Storage
#########################################################

variable "root_volume_size" {
  description = "Root Volume Size (GB)"
  type        = number

  default = 20
}

#########################################################
# Instance Configuration
#########################################################

variable "instance_name" {
  description = "EC2 Instance Name"
  type        = string
}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}

