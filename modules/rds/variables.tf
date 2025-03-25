variable "availability_zones" {
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
}

variable "database_name" {
  description = "Nom de la base de données RDS"
  type        = string

}

variable "database_user" {
  description = "Nom d'utilisateur de la base de données RDS"
  type        = string
}

variable "database_password" {
  description = "Mot de passe de la base de données RDS"
  type        = string
  sensitive   = true
}

