resource "aws_db_instance" "wordpress_db" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_type
  username               = var.database_user
  password               = local.db_password #Utilisation du mot de passe sécurisé !
  db_name                = var.database_name
  multi_az               = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]

  tags = {
    Name = "WordPress-RDS_Astride"
  }
  # Cela garantit que le Security Group et le Subnet Group existent avant RDS.
  depends_on = [aws_db_subnet_group.rds_subnet_group, aws_security_group.rds_sg]
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "wordpress-db-subnet-group_as"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  # Autoriser uniquement l'EC2 à se connecter à la base de données
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-SG_as"
  }
}

#data sources AWS Secrets Manager pour récupérer le mot de passe sécurisé :
data "aws_secretsmanager_secret" "db_secret" {
  name = "wordpress-pwd-rds" # Nom du secret dans AWS Secrets Manager sur L#interface utilisateur
}

#Récupère la dernière version du secret
data "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

#Détermine le mot de passe en fonction de la priorité
locals {
  db_password = coalesce(
    var.database_password,
    jsondecode(data.aws_secretsmanager_secret_version.db_secret_value.secret_string)["database_password"]
  )
}
