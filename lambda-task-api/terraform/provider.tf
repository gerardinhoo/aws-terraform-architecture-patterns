terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket = "gerard-lambda-terraform"
    key    = "lambda-task-api/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
