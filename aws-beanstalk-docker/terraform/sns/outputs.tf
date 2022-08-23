output "alarm_sns_topic" {
  description = "The ARN of the SNS topic"
  value       = module.sns_topic.sns_topic_arn
}