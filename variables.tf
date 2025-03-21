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
# VPC
variable "vpc_id" {
  type        = string
  description = "acceder à l'id du vpc"
}

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
  default     = "t2.micro"
}

# variable "key_name" {
#   description = "Nom de la clé SSH"
# }





