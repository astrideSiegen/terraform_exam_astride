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
variable "subnet_ids" {
  description = "Liste des subnets publics"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID du Security Group pour EC2"
  type        = string

}
# paire de clé utilisée
variable "key_name" {
  type = string
}


