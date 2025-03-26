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

variable "key_name" {
  description = "Nom de la paire de clés SSH EC2"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC dans lequel déployer EC2"
  type        = string
}

#Accéder à la liste des subnets publics, privés et az où sera deployer notre ec2
variable "public_subnet_id" {
  description = "Le subnet public où l'instance EC2 sera créée"
  type        = string
}


variable "availability_zone" {
  description = "La zone de disponibilité dans laquelle l'EC2 doit être déployée"
  type        = string
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
  description = "Adresse du serveur de la base de données RDS"
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


