variable "app_tags" {
  type = string
}

variable "application_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "alarm_sns_topic" {
  type = string
}

variable "asg_name" {
  description = "The name of the AutoScalingGroup"
  type = string
}

variable "lbarn" {
  description = "The ARN of the load balancer"
  type = string
}
