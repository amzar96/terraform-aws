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
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
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

resource "aws_s3_bucket" "zar-tf" {
  bucket = "zar-tf-bucket"

  tags = {
    Name        = "Zars bucket"
    Environment = "Dev"
  }
}

