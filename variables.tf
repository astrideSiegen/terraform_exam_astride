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
}

variable "public_subnet_cidrs" {
  description = "Liste des CIDR blocks pour les subnets publics"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Liste des CIDR blocks pour les subnets privés"
  type        = list(string)
}


#variables ec2
variable "instance_type" {
  description = "Type d'instance EC2"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nom de la clé SSH"
}





