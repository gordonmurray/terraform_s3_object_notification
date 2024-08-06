terraform {

  required_version = "1.9.3"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
  }

}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "gordonmurray"

  default_tags {
    tags = {
      Name = "Terraform S3 Object notification"
    }
  }
}


# Data source to get the current AWS account ID
data "aws_caller_identity" "current" {}