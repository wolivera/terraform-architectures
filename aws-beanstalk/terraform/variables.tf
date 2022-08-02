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

variable "domain_name" {
  type = string
  description = "The domain name for the app"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "app_tags" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_subnets" {
  type = string
}

variable "elb_subnets" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "keypair" {
  type = string
}

# variable "sshrestrict" {
#   type = string
# }

# variable "alarm_sns_topic" {
#   type = string
# }
