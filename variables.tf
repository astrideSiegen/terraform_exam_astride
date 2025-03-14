variable "namespace" {
  description = "L'espace de noms de projet à utiliser pour la dénomination unique des ressources"
  default     = "wordpress_datascientest"
  type        = string
}

variable "region" {
  description = "AWS région"
  default     = "eu-west-3"
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR du VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs des sous-réseaux publics"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs des sous-réseaux privés"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  description = "Type d'instance EC2"
  default     = "t2.micro"
}

variable "db_instance_type" {
  description = "Type d'instance pour la base de données"
  default     = "db.t3.micro"
}

variable "key_name" {
  description = "Nom de la clé SSH"
}
