variable "availability_zone" {
  description = "Liste des zones de disponibilité disponibles"
  type        = list(string)
}

# RDS Configuration
variable "db_instance_type" {
  description = "Classe d'instance pour RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Liste des subnets publics"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "Liste des subnets privés"
  type        = list(string)
}
variable "ec2_sg_id" {
  description = "ID du Security Group pour EC2"
  type        = string
}
