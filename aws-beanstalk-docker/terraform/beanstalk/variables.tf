variable "app_tags" {
  type = string
}

variable "application_name" {
  type = string
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "vpc_id" {
  type = string
}

variable "ec2_subnets" {
  description = "the private subnets for your environment, e.g. \"subnet-12345678,subnet-87654321\""
}

variable "elb_subnets" {
  description = "the public subnets for your environment, e.g. \"subnet-12345678,subnet-87654321\""
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

variable "certificate" {
  type = string
}
