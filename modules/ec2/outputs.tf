#ip de l'instance publique
output "public_ip" {
  value = aws_instance.ec2.public_ip
}
#ip de l'instance privée
output "private_ip" {
  value = aws_instance.ec2.private_ip
}

output "ec2_sg_id" {
  description = "ID du Security Group pour EC2"
  value       = aws_security_group.ec2_sg.id
}

output "ec2_id" {
  description = "Id de la machine ec2 sur lquelle sera déployée wordpress"
  value       = aws_instance.ec2.id
}

output "availability_zone_ec2" {
  description = "la zone de disponibilité de notre ec2"
  value       = data.aws_availability_zones.names[0]
}
