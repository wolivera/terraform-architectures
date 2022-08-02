output "cname" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.cname
}

output "zone" {
  value = data.aws_elastic_beanstalk_hosted_zone.current.id
}

output "env_name" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.name
}

output "asg_name" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.autoscaling_groups[0]
}

output "lb_arn" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
}
