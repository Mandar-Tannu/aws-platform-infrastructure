#########################################################
# Amazon EKS Cluster
#########################################################

resource "aws_eks_cluster" "cluster" {

  name = var.project_name

  role_arn = var.cluster_role_arn

  version = "1.33"

  vpc_config {

    subnet_ids = var.subnet_ids

    endpoint_private_access = false

    endpoint_public_access = true
  }

  enabled_cluster_log_types = [

    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"

  ]

  access_config {

    authentication_mode = "API_AND_CONFIG_MAP"

    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-eks-cluster"
    }
  )
}

