variable "application_name" {
  description = "the name of your stack, e.g. \"demo\""
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

variable "app_tags" {
  type = string
}

variable "s3_bucket_regional_domain_name" {
  type = string
  description = "The regional domain name of the S3 bucket"
}

variable "s3_bucket_id" {
  type = string
  description = "The ID of the S3 bucket"
}

variable "aws_acm_certificate_arn" {
  type = string
  description = "The ARN of the certificate to use"
}
