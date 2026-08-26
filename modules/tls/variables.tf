#########################################################
# Project
#########################################################

variable "project_name" {

  type = string

}

#########################################################
# Common Tags
#########################################################

variable "common_tags" {

  type = map(string)

}

variable "alb_dns_name" {
  description = "Application Load Balancer DNS name used in the self-signed certificate"
  type        = string
}
