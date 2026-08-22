module "security_groups" {

  source = "./modules/security-groups"

  project_name = local.project_name

  vpc_id = data.aws_vpc.default.id

  common_tags = local.common_tags
}

