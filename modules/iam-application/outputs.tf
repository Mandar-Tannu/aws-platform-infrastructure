#########################################################
# Jenkins Outputs
#########################################################

output "jenkins_role_name" {

  description = "Jenkins IAM Role Name"

  value = aws_iam_role.jenkins_role.name
}

output "jenkins_role_arn" {

  description = "Jenkins IAM Role ARN"

  value = aws_iam_role.jenkins_role.arn
}

output "jenkins_instance_profile_name" {

  description = "Jenkins Instance Profile Name"

  value = aws_iam_instance_profile.jenkins_profile.name
}

output "jenkins_instance_profile_arn" {

  description = "Jenkins Instance Profile ARN"

  value = aws_iam_instance_profile.jenkins_profile.arn
}

#########################################################
# SonarQube Outputs
#########################################################

output "sonarqube_role_name" {

  description = "SonarQube IAM Role Name"

  value = aws_iam_role.sonarqube_role.name
}

output "sonarqube_role_arn" {

  description = "SonarQube IAM Role ARN"

  value = aws_iam_role.sonarqube_role.arn
}

output "sonarqube_instance_profile_name" {

  description = "SonarQube Instance Profile Name"

  value = aws_iam_instance_profile.sonarqube_profile.name
}

output "sonarqube_instance_profile_arn" {

  description = "SonarQube Instance Profile ARN"

  value = aws_iam_instance_profile.sonarqube_profile.arn
}

