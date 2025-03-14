output "rds_sg_id" {
  description = "ID du Security Group de la base de donée rds"
  value       = aws_security_group.rds_sg.id
}

# valeurs à recuperer dans notre ec2
output "rds_db_name" {
  description = "Nom de la base de données RDS"
  value       = aws_db_instance.wordpress_db.database_name

}

output "rds_username" {
  description = "Nom d'utilisateur de la base de données RDS"
  value       = aws_db_instance.wordpress_db.database_user
}

output "rds_endpoint" {
  description = "Adresse de la base de données RDS"
  value       = aws_db_instance.wordpress-db.address
}
