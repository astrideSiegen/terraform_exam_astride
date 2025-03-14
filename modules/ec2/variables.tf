# environnement de déploiement
variable "namespace" {
  type    = string
  default = "wordpress"
}

#intance type
variable "instance_type" {
  description = "type d'intance ec2"
  default     = "t2.micro"
}
variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

#Accéder à la liste des subnets publics
variable "public_subnet_ids" {
  description = "Liste des subnets publics"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "Liste des subnets privés"
  type        = list(string)
}

# valeurs de rds à ajouter sur notre ec2 lors du deploiement
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

variable "database_host" {
  description = "Adresse de la base de données RDS"
  type        = string
}

# variable "security_group_id" {
#   description = "ID du Security Group pour EC2"
#   type        = string

# }

# paire de clé utilisée
# variable "key_name" {
#   type = string
# }


