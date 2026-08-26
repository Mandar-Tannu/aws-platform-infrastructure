#########################################################
# AWS Load Balancer Controller Outputs
#########################################################

output "iam_role_arn" {

  description = "IAM role ARN used by the AWS Load Balancer Controller"

  value = aws_iam_role.this.arn

}

output "helm_release_name" {

  description = "AWS Load Balancer Controller Helm release name"

  value = helm_release.this.name

}

