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

module "sns" {

  source = "./sns/"

  application_name = var.application_name
  environment      = var.environment
}


module "cloudwatch" {

  source = "./cloudwatch/"

  application_name = var.application_name
  environment      = var.environment
  app_tags         = var.app_tags
  alarm_sns_topic  = module.sns.alarm_sns_topic
  asg_name         = module.eb.asg_name
  lbarn            = module.eb.lb_arn
}

module "rds" {

  source = "./rds"

  application_name = var.application_name
  environment      = var.environment
  app_tags         = var.app_tags
  db_subnets       = module.vpc.vpc_private_subnets
  vpc_id           = module.vpc.id
  cidr             = var.cidr
}

module "ecr" {
  source      = "./ecr"
  name        = var.application_name
  environment = var.environment
}

#
#
## Uncomment below lines and switch with rds in case you're looking for a MongoDB instance
#
#
# module "documentdb" {

#   source = "./documentdb"

#   application_name = var.application_name
#   environment      = var.environment
#   app_tags         = var.app_tags
#   db_subnets       = module.vpc.vpc_private_subnets
#   vpc_id           = module.vpc.id
#   cidr             = var.cidr
# }
