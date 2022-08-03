output "id" {
  value = aws_vpc.main.id
}

output "vpc_public_subnets" {
  value = aws_subnet.public[*].id
}

output "vpc_private_subnets" {
  value = aws_subnet.private[*].id
}