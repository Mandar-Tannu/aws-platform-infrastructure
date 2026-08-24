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
# SonarQube Database Secrets
#########################################################

module "secrets_manager_sonarqube" {

  source = "./modules/secrets-manager"

  secret_name = "${local.project_name}-sonarqube-database"

  db_username = "postgres"

  db_name = "sonarqube"

  common_tags = local.common_tags

}

#########################################################
# SonarQube PostgreSQL RDS
#########################################################

module "rds_sonarqube" {

  source = "./modules/rds"

  project_name = local.project_name

  database_identifier = "${local.project_name}-sonarqube-postgres"

  db_name = "sonarqube"

  database_secret_arn = module.secrets_manager_sonarqube.secret_arn

  engine_version = "17"

  instance_class = "db.t4g.micro"

  allocated_storage = 20

  subnet_ids = data.aws_subnets.default.ids

  security_group_id = module.security_groups.rds_security_group_id

  common_tags = local.common_tags

}

#########################################################
# Application Database Secrets
#########################################################

module "secrets_manager_application" {

  source = "./modules/secrets-manager"

  secret_name = "${local.project_name}-application-database"

  db_username = "postgres"

  db_name = "application"

  common_tags = local.common_tags

}

#########################################################
# Application PostgreSQL RDS
#########################################################

module "rds_application" {

  source = "./modules/rds"

  project_name = local.project_name

  database_identifier = "${local.project_name}-application-postgres"

  db_name = "application"

  database_secret_arn = module.secrets_manager_application.secret_arn

  engine_version = "17"

  instance_class = "db.t4g.micro"

  allocated_storage = 20

  subnet_ids = data.aws_subnets.default.ids

  security_group_id = module.security_groups.rds_security_group_id

  common_tags = local.common_tags

}

#########################################################
# Amazon S3 Module
#########################################################

module "s3" {

  source = "./modules/s3"

  project_name = local.project_name

  bucket_name = local.project_name

  common_tags = local.common_tags

}

