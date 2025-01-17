#------------------
# Terraform configuration
#------------------
terraform {
  required_version = ">=1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-wp-dev-tfstate"
    region  = "ap-northeast-1"
    key     = "terraform.tfstate"
    profile = "udemy_terraform"
  }
}

provider "aws" {
  profile = "udemy_terraform"
  region  = "ap-northeast-1"
}
