terraform {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  profile    = "default"
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

module "eb" {

  source = "./beanstalk/"


  app_tags         = var.app_tags
  application_name = var.application_name
  environment      = var.environment
  vpc_id           = module.vpc.id
  ec2_subnets      = module.vpc.vpc_private_subnets
  elb_subnets      = module.vpc.vpc_public_subnets
  instance_type    = var.instance_type
  disk_size        = var.disk_size
  keypair          = var.keypair
  certificate      = var.tsl_certificate_arn
}

# module "cloudwatch" {

#   source = "./cloudwatch/"


#   app_tags        = var.app_tags
#   alarm_sns_topic = var.alarm_sns_topic
#   asgName         = module.eb.asg_name
#   envName         = module.eb.env_name
#   lbarn           = module.eb.lb_arn
# }
