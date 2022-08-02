terraform {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

module "vpc" {
  source             = "./vpc"
  application_name   = var.application_name
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  environment        = var.environment
}

module "ssl" {

  source = "./ssl/"

  domain_name = var.domain_name
  cname       = module.eb.cname
  zone        = module.eb.zone
}

module "eb" {

  source = "./beanstalk/"


  app_tags         = var.app_tags
  application_name = var.application_name
  vpc_id           = var.vpc_id
  ec2_subnets      = var.ec2_subnets
  elb_subnets      = var.elb_subnets
  instance_type    = var.instance_type
  disk_size        = var.disk_size
  keypair          = var.keypair
  # sshrestrict      = var.sshrestrict
  certificate = module.ssl.certificate
}

# module "cloudwatch" {

#   source = "./cloudwatch/"


#   app_tags        = var.app_tags
#   alarm_sns_topic = var.alarm_sns_topic
#   asgName         = module.eb.asg_name
#   envName         = module.eb.env_name
#   lbarn           = module.eb.lb_arn
# }
