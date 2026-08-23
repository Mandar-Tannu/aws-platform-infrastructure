#########################################################
# Jenkins Amazon ECR Policy
#########################################################

resource "aws_iam_policy" "jenkins_ecr_policy" {

  name = "${var.project_name}-jenkins-ecr-policy"

  description = "Allows Jenkins to push Docker images to Amazon ECR"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Sid = "ECRAuthentication"

        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },

      {
        Sid = "ECRRepositoryAccess"

        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:PutImage",
          "ecr:BatchGetImage",
          "ecr:ListImages"
        ]

        Resource = var.ecr_repository_arn
      }

    ]
  })

  tags = var.common_tags
}

#########################################################
# Jenkins Amazon EKS Policy
#########################################################

resource "aws_iam_policy" "jenkins_eks_policy" {

  name = "${var.project_name}-jenkins-eks-policy"

  description = "Allows Jenkins to access the Amazon EKS cluster"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [
          "eks:DescribeCluster"
        ]

        Resource = var.eks_cluster_arn
      }

    ]
  })

  tags = var.common_tags
}

#########################################################
# Jenkins Secrets Manager Policy
#########################################################

resource "aws_iam_policy" "jenkins_secrets_policy" {

  name = "${var.project_name}-jenkins-secrets-policy"

  description = "Allows Jenkins to read application secrets"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]

        Resource = "arn:aws:secretsmanager:${var.aws_region}:*:secret:go-app-*"
      }

    ]
  })

  tags = var.common_tags
}

#########################################################
# Jenkins IAM Role
#########################################################

resource "aws_iam_role" "jenkins_role" {

  name = "${var.project_name}-jenkins-role"

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
      Name = "${var.project_name}-jenkins-role"
    }
  )
}

#########################################################
# Attach AmazonSSMManagedInstanceCore
#########################################################

resource "aws_iam_role_policy_attachment" "jenkins_ssm_policy" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#########################################################
# Attach Jenkins Amazon ECR Policy
#########################################################

resource "aws_iam_role_policy_attachment" "jenkins_ecr_policy_attachment" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = aws_iam_policy.jenkins_ecr_policy.arn
}

#########################################################
# Attach Jenkins Amazon EKS Policy
#########################################################

resource "aws_iam_role_policy_attachment" "jenkins_eks_policy_attachment" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = aws_iam_policy.jenkins_eks_policy.arn
}

#########################################################
# Attach Jenkins Secrets Manager Policy
#########################################################

resource "aws_iam_role_policy_attachment" "jenkins_secrets_policy_attachment" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = aws_iam_policy.jenkins_secrets_policy.arn
}

#########################################################
# SonarQube IAM Role
#########################################################

resource "aws_iam_role" "sonarqube_role" {

  name = "${var.project_name}-sonarqube-role"

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
      Name = "${var.project_name}-sonarqube-role"
    }
  )
}

#########################################################
# Attach AmazonSSMManagedInstanceCore
#########################################################

resource "aws_iam_role_policy_attachment" "sonarqube_ssm_policy" {

  role = aws_iam_role.sonarqube_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#########################################################
# Jenkins Instance Profile
#########################################################

resource "aws_iam_instance_profile" "jenkins_profile" {

  name = "${var.project_name}-jenkins-instance-profile"

  role = aws_iam_role.jenkins_role.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-jenkins-instance-profile"
    }
  )
}

#########################################################
# SonarQube Instance Profile
#########################################################

resource "aws_iam_instance_profile" "sonarqube_profile" {

  name = "${var.project_name}-sonarqube-instance-profile"

  role = aws_iam_role.sonarqube_role.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-sonarqube-instance-profile"
    }
  )
}

