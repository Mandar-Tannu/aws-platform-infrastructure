#########################################################
# Amazon EKS Managed Node Group
#########################################################

resource "aws_eks_node_group" "node_group" {

  cluster_name = var.cluster_name

  node_group_name = "${var.project_name}-node-group"

  node_role_arn = var.node_role_arn

  subnet_ids = var.subnet_ids

  instance_types = var.instance_types

  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    max_unavailable = 1
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-node-group"
    }
  )
}

