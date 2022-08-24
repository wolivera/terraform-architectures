variable "application_name" {
  description = "the name of your stack, e.g. \"demo\""
  type = string
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "app_tags" {
  type = string
}

variable "domain_name" {
  type        = string
  description = "The domain name to use"
  default     = "zircondev.com"
}

variable "website_domain" {
  type        = string
  description = "The domain name to use"
  default     = "terraforms3.zircondev.com"
}

variable "aws_acm_certificate_arn" {
  type = string
  description = "The ARN of the certificate to use"
}
