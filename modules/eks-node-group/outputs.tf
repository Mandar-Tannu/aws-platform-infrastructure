#########################################################
# Node Group Outputs
#########################################################

output "node_group_name" {

  description = "Managed Node Group Name"

  value = aws_eks_node_group.node_group.node_group_name
}

output "node_group_arn" {

  description = "Managed Node Group ARN"

  value = aws_eks_node_group.node_group.arn
}

output "node_group_status" {

  description = "Managed Node Group Status"

  value = aws_eks_node_group.node_group.status
}

