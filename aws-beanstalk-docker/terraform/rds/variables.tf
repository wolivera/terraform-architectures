variable "app_tags" {
  type = string
}

variable "application_name" {
  type = string
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "db_subnets" {
  description = "the private subnets for your environment, e.g. \"subnet-12345678,subnet-87654321\""
}

variable "vpc_id" {
  type = string
}

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "postgres_instance_class" {
  default = "db.t3.medium"
}

# variable "postgres_password" {
#   type = string
#   default = "password"
# }
