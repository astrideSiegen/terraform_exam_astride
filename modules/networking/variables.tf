variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR range of the VPC"
  type        = string
}

variable "network_name" {
  default     = "wordpress-vpc_astride"
  description = "VPC du déployement de l'application wordpress"
  type        = string
}

variable "pubsn_cidr" {
  default = ["10.0.0.0/24", "10.0.2.0/24"]
  type    = list(string)
}

variable "prisn1_cidr" {
  default = "10.0.1.0/24"
  type    = string
}

variable "prisn2_cidr" {
  default = "10.0.3.0/24"
  type    = string
}

variable "cidr_all" {
  default = "0.0.0.0/0"
  type    = string
}





