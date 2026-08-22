locals {
  project_name = "go-kyc-user-service"

  common_tags = {
    Project     = "go-kyc-user-service"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Owner       = "DevOps"
  }
}

