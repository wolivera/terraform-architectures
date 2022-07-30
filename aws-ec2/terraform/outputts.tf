output "ec2_instance_id" {
  description = "The ID of the instance"
  value       = module.ec2_instance.id
}

output "ec2_instance_ip" {
  description = "The public ip of the instance"
  value       = module.ec2_instance.public_ip
}
