terraform {
  backend "s3" {
    bucket       = "aws-platform-terraform-state-509124060818"
    key          = "global/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}

