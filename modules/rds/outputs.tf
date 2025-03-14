output "rds_sg_id" {
  description = "ID du Security Group de la base de donée rds"
  value       = aws_security_group.rds_sg.id
}
