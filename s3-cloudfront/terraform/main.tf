terraform {
  required_version = ">= 1.0.8"
  required_providers {
    aws = {
      version = ">= 4.15.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  profile    = "default"
}

module "s3" {
  source = "./s3"

  application_name   = var.application_name
  environment        = var.environment
  app_tags           = var.app_tags
  domain_name        = var.domain_name
  website_domain     = var.website_domain
  aws_cloudfront_oai = module.cloudfront.aws_cloudfront_oai
}

module "cloudfront" {
  source = "./cloudfront"

  application_name        = var.application_name
  app_tags                = var.app_tags
  domain_name             = var.domain_name
  website_domain          = var.website_domain
  aws_acm_certificate_arn = var.aws_acm_certificate_arn

  s3_bucket_regional_domain_name = module.s3.s3_bucket_regional_domain_name
  s3_bucket_id                   = module.s3.s3_bucket_id
}
