#########################################################
# Amazon EKS Cluster IAM Role
#########################################################

resource "aws_iam_role" "eks_cluster_role" {

  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-eks-cluster-role"
    }
  )
}

#########################################################
# Attach AmazonEKSClusterPolicy
#########################################################

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {

  role = aws_iam_role.eks_cluster_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#########################################################
# Amazon EKS Node Group IAM Role
#########################################################

resource "aws_iam_role" "eks_node_role" {

  name = "${var.project_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-eks-node-role"
    }
  )
}

#########################################################
# Attach AmazonEKSWorkerNodePolicy
#########################################################

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {

  role = aws_iam_role.eks_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

#########################################################
# Attach AmazonEC2ContainerRegistryPullOnly
#########################################################

resource "aws_iam_role_policy_attachment" "eks_ecr_pull_policy" {

  role = aws_iam_role.eks_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

#########################################################
# Attach AmazonEKS_CNI_Policy
#########################################################

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {

  role = aws_iam_role.eks_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

#########################################################
# Attach AmazonSSMManagedInstanceCore
#########################################################

resource "aws_iam_role_policy_attachment" "eks_ssm_policy" {

  role = aws_iam_role.eks_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
