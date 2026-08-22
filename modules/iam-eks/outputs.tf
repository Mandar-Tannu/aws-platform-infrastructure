#########################################################
# Amazon EKS Cluster Role Outputs
#########################################################

output "eks_cluster_role_name" {
  description = "Amazon EKS Cluster IAM Role Name"
  value       = aws_iam_role.eks_cluster_role.name
}

output "eks_cluster_role_arn" {
  description = "Amazon EKS Cluster IAM Role ARN"
  value       = aws_iam_role.eks_cluster_role.arn
}

#########################################################
# Amazon EKS Node Group Role Outputs
#########################################################

output "eks_node_role_name" {
  description = "Amazon EKS Node Group IAM Role Name"
  value       = aws_iam_role.eks_node_role.name
}

output "eks_node_role_arn" {
  description = "Amazon EKS Node Group IAM Role ARN"
  value       = aws_iam_role.eks_node_role.arn
}

