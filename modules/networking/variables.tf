variable "vpc_cidr" {
  description = "CIDR range of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "network_name" {
  default     = "wordpress-vpc_astride"
  description = "VPC du déployement de l'application wordpress"
  type        = string
}

variable "pubsn_cidr" {
  description = "liste des cidr des subnets publiques"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "privat_sn_cidr" {
  description = "liste des cidr des subnets privés"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


variable "cidr_all" {
  default = "0.0.0.0/0"
  type    = string
}

variable "azs" {
  description = "Liste des zones de disponibilité"
  type        = list(string)
}



