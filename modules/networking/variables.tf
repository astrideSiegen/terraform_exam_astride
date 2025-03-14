variable "vpc_cidr" {
  description = "CIDR range of the VPC"
  type        = string
}

variable "network_name" {
  default     = "wordpress-vpc_astride"
  description = "VPC du déployement de l'application wordpress"
  type        = string
}

variable "pubsn_cidr" {
  description = "liste des cidr des subnets publiques"
  type        = list(string)
}

variable "privat_sn_cidr" {
  description = "liste des cidr des subnets privés"
  type        = list(string)
}


variable "cidr_all" {
  default = "0.0.0.0/0"
  type    = string
}





