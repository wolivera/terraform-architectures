resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.application_name}-vpc-${var.environment}"
    Environment = var.environment
  }
}
