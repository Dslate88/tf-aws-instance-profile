terraform {
  required_version = "= 1.2.2"
  backend "s3" {
    bucket         = "account-terraform-state-files"
    key            = "testing_iam_role.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state_lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
