#########################################################
# AWS Load Balancer Controller IAM Policy
#########################################################

resource "aws_iam_policy" "this" {

  name = "AWSLoadBalancerControllerIAMPolicy"

  policy = file("${path.module}/iam_policy.json")

  tags = merge(
    var.common_tags,
    {
      Name = "AWSLoadBalancerControllerIAMPolicy"
    }
  )

}

#########################################################
# AWS Load Balancer Controller IAM Role
#########################################################

resource "aws_iam_role" "this" {

  name = "${var.cluster_name}-aws-load-balancer-controller"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]

      }

    ]

  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.cluster_name}-aws-load-balancer-controller"
    }
  )

}

#########################################################
# Attach Controller Policy
#########################################################

resource "aws_iam_role_policy_attachment" "this" {

  role = aws_iam_role.this.name

  policy_arn = aws_iam_policy.this.arn

}

#########################################################
# EKS Pod Identity Agent
#########################################################

resource "aws_eks_addon" "pod_identity_agent" {

  cluster_name = var.cluster_name

  addon_name = "eks-pod-identity-agent"

  tags = var.common_tags

}

#########################################################
# EKS Pod Identity Association
#########################################################

resource "aws_eks_pod_identity_association" "this" {

  cluster_name = var.cluster_name

  namespace = "kube-system"

  service_account = "aws-load-balancer-controller"

  role_arn = aws_iam_role.this.arn

}

#########################################################
# AWS Load Balancer Controller Helm Release
#########################################################

resource "helm_release" "this" {

  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"

  chart = "aws-load-balancer-controller"

  version = var.helm_chart_version

  namespace = "kube-system"

  create_namespace = false

  set = [
    {
      name  = "clusterName"
      value = var.cluster_name
    },
    {
      name  = "serviceAccount.create"
      value = "true"
    },
    {
      name  = "serviceAccount.name"
      value = "aws-load-balancer-controller"
    },
    {
      name  = "region"
      value = var.region
    },
    {
      name  = "vpcId"
      value = var.vpc_id
    }
  ]

  depends_on = [
    aws_eks_addon.pod_identity_agent,
    aws_eks_pod_identity_association.this
  ]
}

