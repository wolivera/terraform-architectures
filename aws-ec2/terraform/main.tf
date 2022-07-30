terraform {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = var.name
  cidr = "10.99.0.0/18"

  azs              = ["${var.aws_region}a"]
  public_subnets   = ["10.99.0.0/24"]

  tags = {
    Owner       = var.owner
    Environment = var.environment
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.name
  description = "Security group for usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-8080-tcp", "ssh-tcp",  "all-icmp"]
  egress_rules        = ["all-all"]

  tags = {
    Owner       = var.owner
    Environment = var.environment
  }
}


# ################################################################################
# # EC2 Module
# ################################################################################

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name      = var.name
  key_name  = var.key_pair_name

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro" # change to desired size
  monitoring                  = true
  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true

  # optionally add storage device
  #
  # root_block_device = [
  #   {
  #     encrypted   = true
  #     volume_type = "gp3"
  #     throughput  = 200
  #     volume_size = 50
  #     tags = {
  #       Name = "my-root-block"
  #     }
  #   },
  # ]

  # ebs_block_device = [
  #   {
  #     device_name = "/dev/sdf"
  #     volume_type = "gp3"
  #     volume_size = 5
  #     throughput  = 200
  #     encrypted   = true
  #     kms_key_id  = aws_kms_key.this.arn
  #   }
  # ]

  tags = {
    Owner       = var.owner
    Environment = var.environment
  }
}