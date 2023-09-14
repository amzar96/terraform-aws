terraform {

  cloud {
    organization = "AWS-EKS-Terraform"

    workspaces {
      name = "s3-creation"
    }
  }

    required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 5.16.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  access_key = env.aws_access_key
  secret_key = env.aws_secret_key
  region     = env.region
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_s3_bucket" "my-tf" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

