
variable "monitoring" {
  type    = bool
  default = false
}
variable "ebs_size" {
  type    = number
  default = "10"
}

variable "ec2_id" {
  default     = "ec2_id"
  description = "ec2_id"
}

variable "availability_zone" {
  description = "Liste des zones de disponibilité disponibles"
  type        = list(string)
}


variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Liste des subnets publics"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID du Security Group pour EC2"
  type        = string
}
