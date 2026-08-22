#########################################################
# Amazon EKS Cluster Outputs
#########################################################

output "cluster_name" {
  description = "Amazon EKS Cluster Name"
  value       = aws_eks_cluster.cluster.name
}

output "cluster_arn" {
  description = "Amazon EKS Cluster ARN"
  value       = aws_eks_cluster.cluster.arn
}

output "cluster_endpoint" {
  description = "Amazon EKS Cluster Endpoint"
  value       = aws_eks_cluster.cluster.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Amazon EKS Cluster Certificate Authority Data"
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "Amazon EKS Cluster Security Group ID"
  value       = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}

