variable "namespace" {
  description = "L'espace de noms de projet à utiliser pour la dénomination unique des ressources"
  type        = string
}

variable "region" {
  description = "AWS région où sera deployer notre ec2"
  type        = string
}

#variables networking

variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
}

variable "pubsn_cidr" {
  description = "Liste des CIDR blocks pour les subnets publics"
  type        = list(string)
}

variable "privat_sn_cidr" {
  description = "Liste des CIDR blocks pour les subnets privés"
  type        = list(string)

}


#variables ec2
variable "instance_type" {
  description = "Type d'instance EC2"

}

variable "key_name" {
  description = "Nom de la clé SSH"
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
# variable "database_host" {
#   description = "host de notre base de donnée"
#   type        = string
# }




