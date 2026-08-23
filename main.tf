module "security_groups" {

  source = "./modules/security-groups"

  project_name = local.project_name

  vpc_id = data.aws_vpc.default.id

  common_tags = local.common_tags
}

module "ecr" {

  source = "./modules/ecr"

  project_name = local.project_name

  common_tags = local.common_tags
}

module "iam_eks" {

  source = "./modules/iam-eks"

  project_name = local.project_name

  common_tags = local.common_tags
}

module "eks" {

  source = "./modules/eks"

  project_name     = local.project_name
  cluster_role_arn = module.iam_eks.eks_cluster_role_arn
  subnet_ids       = data.aws_subnets.default.ids
  common_tags      = local.common_tags
}

module "eks_node_group" {

  source = "./modules/eks-node-group"

  project_name = local.project_name

  cluster_name = module.eks.cluster_name

  node_role_arn = module.iam_eks.eks_node_role_arn

  subnet_ids = data.aws_subnets.default.ids

  common_tags = local.common_tags
}

module "iam_application" {

  source = "./modules/iam-application"

  project_name = local.project_name

  aws_region = var.aws_region

  ecr_repository_arn = module.ecr.repository_arn

  eks_cluster_arn = module.eks.cluster_arn

  common_tags = local.common_tags
}

#########################################################
# Jenkins EC2 Module
#########################################################

module "jenkins" {

  source = "./modules/ec2"

  project_name = local.project_name

  instance_name = "${local.project_name}-jenkins"

  ami_id = data.aws_ami.ubuntu.id

  instance_type = "c7i-flex.large"

  subnet_id = data.aws_subnets.default.ids[0]

  security_group_ids = [
    module.security_groups.jenkins_security_group_id
  ]

  instance_profile_name = module.iam_application.jenkins_instance_profile_name

  root_volume_size = 20

  common_tags = local.common_tags
}

#########################################################
# SonarQube EC2 Module
#########################################################

module "sonarqube" {

  source = "./modules/ec2"

  project_name = local.project_name

  instance_name = "${local.project_name}-sonarqube"

  ami_id = data.aws_ami.ubuntu.id

  instance_type = "c7i-flex.large"

  subnet_id = data.aws_subnets.default.ids[0]

  security_group_ids = [
    module.security_groups.sonarqube_security_group_id
  ]

  instance_profile_name = module.iam_application.sonarqube_instance_profile_name

  root_volume_size = 20

  common_tags = local.common_tags
}

#########################################################
# Secrets Manager Module
#########################################################

module "secrets_manager" {

  source = "./modules/secrets-manager"

  project_name = local.project_name

  db_username = "postgres"

  db_name = "sonarqube"

  common_tags = local.common_tags

}

