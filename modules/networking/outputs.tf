#exposer le vpc pour y avoir accès dans d'autres modules
output "vpc_id" {
  value = aws_vpc.vpc.id
}

#exposer les subnets
output "public_subnet_ids" {
  description = "public subnet IDs"
  value       = [aws_subnet.public_sn_1.id, aws_subnet.public_sn_2.id]
}

output "private_subnet_ids" {
  description = "private subnet IDs"
  value       = [aws_subnet.private_sn_1.id, aws_subnet.private_sn_2.id]
}

