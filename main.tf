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

