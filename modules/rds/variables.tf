variable "availability_zone" {
  description = "Liste des zones de disponibilité disponibles"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Liste des subnets publics"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "Liste des subnets privés"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "ID du Security Group pour EC2"
  type        = string
}

# RDS Configuration
variable "db_instance_type" {
  description = "Classe d'instance pour RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "database_name" {
  description = "Nom de la base de données RDS"
  type        = string
  default     = "wordpress_db_astride"
}

variable "database_user" {
  description = "Nom d'utilisateur de la base de données RDS"
  type        = string
  default     = "admin_astride"
}

variable "database_password" {
  description = "Mot de passe de la base de données RDS"
  type        = string
  #default     = "Wordpress@2025"
  sensitive = true
}
variable "database_host" {
  description = "host de notre base de donnée"
  type        = string
}
