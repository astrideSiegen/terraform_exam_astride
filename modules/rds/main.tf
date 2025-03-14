resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = var.db_instance_type
  username             = "admin"
  password             = "supersecret"
  multi_az             = true
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "WordPress-RDS"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = var.private_subnet_ids
}
