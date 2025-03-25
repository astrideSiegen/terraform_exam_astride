
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
  description = "zone de disponibilité de notre ebs"
  type        = string
}


variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}


