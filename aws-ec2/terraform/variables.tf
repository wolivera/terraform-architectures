variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "aws_region" {
  type        = string
  description = "AWS region to launch servers on"
  default     = "us-east-1"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "owner" {
  type        = string
  description = "The name of the owner"
  default     = "user"
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "dev"
}

variable "key_pair_name" {
  type       = string
  description = "the name of the key pair to use"
}