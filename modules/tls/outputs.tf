#########################################################
# TLS Outputs
#########################################################

output "certificate_arn" {

  description = "AWS ACM Certificate ARN"

  value = aws_acm_certificate.this.arn

}

