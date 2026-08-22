output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

output "jenkins_security_group_id" {
  value = aws_security_group.jenkins_sg.id
}

output "sonarqube_security_group_id" {
  value = aws_security_group.sonarqube_sg.id
}

output "eks_node_security_group_id" {
  value = aws_security_group.eks_node_sg.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds_sg.id
}

