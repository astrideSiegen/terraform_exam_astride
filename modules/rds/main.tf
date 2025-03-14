resource "aws_db_instance" "wordpress_db" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_type
  username               = var.database_user
  password               = var.database_password
  db_name                = var.database_name
  multi_az               = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]

  tags = {
    Name = "WordPress-RDS_Astride"
  }
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
    security_groups = [aws_security_group.ec2_sg.id]
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
