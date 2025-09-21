terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

provider "aws" {
  # # Configure the AWS Provider
    region = "eu-west-2"
}

