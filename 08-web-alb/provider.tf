terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.50.0"
    }
  }
  backend "s3" {
    bucket = "neelareddy.stores"
    key = "expense-dev-web-alb-dev"
    region = "us-east-1"
    dynamodb_table = "neelareddy.stores"
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}