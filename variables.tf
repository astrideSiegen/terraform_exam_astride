variable "namespace" {
  description = "L'espace de noms de projet à utiliser pour la dénomination unique des ressources"
  default     = "wordpress_datascientest"
  type        = string
}

variable "region" {
  description = "AWS région où sera deployer notre ec2"
  default     = "eu-west-3"
  type        = string
}

#variables networking

variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "pubsn_cidr" {
  description = "Liste des CIDR blocks pour les subnets publics"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "privat_sn_cidr" {
  description = "Liste des CIDR blocks pour les subnets privés"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


#variables ec2
variable "instance_type" {
  description = "Type d'instance EC2"
  default     = "t2.micro"
}

# variable "key_name" {
#   description = "Nom de la clé SSH"
# }

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
# variable "database_host" {
#   description = "host de notre base de donnée"
#   type        = string
# }




