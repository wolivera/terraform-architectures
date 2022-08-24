variable "application_name" {
  description = "the name of your stack, e.g. \"demo\""
  type = string
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "dev"
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

variable "aws_cloudfront_oai" {
  type = string
}
