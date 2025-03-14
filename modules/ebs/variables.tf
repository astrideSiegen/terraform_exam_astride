
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


